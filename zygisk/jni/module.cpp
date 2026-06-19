#include <android/api-level.h>
#include <android/log.h>
#include <dlfcn.h>
#include <jni.h>
#include <stdint.h>
#include <string.h>
#include <sys/system_properties.h>

#include <vector>

#include "binder.hpp"
#include "zygisk.hpp"

#define LOGI(fmt, ...) \
    __android_log_print(ANDROID_LOG_INFO, "SystemUIMediaFix", "[%d] " fmt, __LINE__, ##__VA_ARGS__)
#define LOGE(fmt, ...) \
    __android_log_print(ANDROID_LOG_ERROR, "SystemUIMediaFix", "[%d] " fmt, __LINE__, ##__VA_ARGS__)

namespace {

constexpr int kSupportedSdk = 31;
constexpr char kTargetProcess[] = "com.android.systemui";
constexpr char kSupportedFingerprint[] =
    "Infinix/X6815B-OP/Infinix-X6815B:12/SP1A.210812.016/231020V486:user/release-keys";
constexpr char16_t kSessionControllerDescriptor[] =
    u"android.media.session.ISessionController";
constexpr size_t kSessionControllerDescriptorLength =
    (sizeof(kSessionControllerDescriptor) / sizeof(kSessionControllerDescriptor[0])) - 1;

using TransactFn = int (*)(void*, int32_t, uint32_t, void*, void*, uint32_t);
using ParcelSetDataFn = int32_t (*)(void*, const uint8_t*, size_t);
using ParcelSetDataPositionFn = void (*)(const void*, size_t);

int g_sdk = 0;
uint32_t g_get_metadata_code = 0;
TransactFn g_transact_original = nullptr;
ParcelSetDataFn g_parcel_set_data = nullptr;
ParcelSetDataPositionFn g_parcel_set_data_position = nullptr;
std::vector<uint8_t> g_empty_metadata_reply;

bool clearJniException(JNIEnv* env, const char* operation) {
    if (!env->ExceptionCheck()) return false;
    LOGE("JNI exception while %s", operation);
    env->ExceptionDescribe();
    env->ExceptionClear();
    return true;
}

bool buildEmptyMetadataReply(JNIEnv* env) {
    jclass parcel_class = env->FindClass("android/os/Parcel");
    if (parcel_class == nullptr || clearJniException(env, "finding Parcel")) return false;

    jmethodID obtain =
        env->GetStaticMethodID(parcel_class, "obtain", "()Landroid/os/Parcel;");
    jmethodID write_no_exception = env->GetMethodID(parcel_class, "writeNoException", "()V");
    jmethodID marshall = env->GetMethodID(parcel_class, "marshall", "()[B");
    jmethodID recycle = env->GetMethodID(parcel_class, "recycle", "()V");
    if (obtain == nullptr || write_no_exception == nullptr || marshall == nullptr ||
        recycle == nullptr || clearJniException(env, "resolving Parcel methods")) {
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    jobject parcel = env->CallStaticObjectMethod(parcel_class, obtain);
    if (parcel == nullptr || clearJniException(env, "obtaining Parcel")) {
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    env->CallVoidMethod(parcel, write_no_exception);
    if (clearJniException(env, "writing no-exception header")) {
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    jclass builder_class = env->FindClass("android/media/MediaMetadata$Builder");
    if (builder_class == nullptr || clearJniException(env, "finding MediaMetadata.Builder")) {
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    jmethodID builder_constructor = env->GetMethodID(builder_class, "<init>", "()V");
    jmethodID build = env->GetMethodID(
        builder_class, "build", "()Landroid/media/MediaMetadata;");
    if (builder_constructor == nullptr || build == nullptr ||
        clearJniException(env, "resolving MediaMetadata.Builder methods")) {
        env->DeleteLocalRef(builder_class);
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    jobject builder = env->NewObject(builder_class, builder_constructor);
    jobject metadata = builder == nullptr ? nullptr : env->CallObjectMethod(builder, build);
    if (builder == nullptr || metadata == nullptr ||
        clearJniException(env, "building empty MediaMetadata")) {
        if (metadata != nullptr) env->DeleteLocalRef(metadata);
        if (builder != nullptr) env->DeleteLocalRef(builder);
        env->DeleteLocalRef(builder_class);
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    // Android 12 AIDL encodes nullable Parcelable values through writeTypedObject().
    // Use the platform implementation itself so the replacement reply follows the exact
    // Parcel format expected by this firmware.
    jmethodID write_typed_object = env->GetMethodID(
        parcel_class, "writeTypedObject", "(Landroid/os/Parcelable;I)V");
    if (write_typed_object != nullptr) {
        env->CallVoidMethod(parcel, write_typed_object, metadata, 1);
    } else {
        env->ExceptionClear();
        jmethodID write_int = env->GetMethodID(parcel_class, "writeInt", "(I)V");
        jclass metadata_class = env->FindClass("android/media/MediaMetadata");
        jmethodID write_to_parcel = metadata_class == nullptr
            ? nullptr
            : env->GetMethodID(
                  metadata_class, "writeToParcel", "(Landroid/os/Parcel;I)V");
        if (write_int == nullptr || metadata_class == nullptr || write_to_parcel == nullptr ||
            clearJniException(env, "resolving Parcelable fallback")) {
            if (metadata_class != nullptr) env->DeleteLocalRef(metadata_class);
            env->DeleteLocalRef(metadata);
            env->DeleteLocalRef(builder);
            env->DeleteLocalRef(builder_class);
            env->CallVoidMethod(parcel, recycle);
            env->DeleteLocalRef(parcel);
            env->DeleteLocalRef(parcel_class);
            return false;
        }
        env->CallVoidMethod(parcel, write_int, 1);
        env->CallVoidMethod(metadata, write_to_parcel, parcel, 1);
        env->DeleteLocalRef(metadata_class);
    }

    if (clearJniException(env, "serializing empty MediaMetadata")) {
        env->DeleteLocalRef(metadata);
        env->DeleteLocalRef(builder);
        env->DeleteLocalRef(builder_class);
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    auto bytes = static_cast<jbyteArray>(env->CallObjectMethod(parcel, marshall));
    if (bytes == nullptr || clearJniException(env, "marshalling replacement reply")) {
        env->DeleteLocalRef(metadata);
        env->DeleteLocalRef(builder);
        env->DeleteLocalRef(builder_class);
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    const jsize length = env->GetArrayLength(bytes);
    if (length <= 8) {
        LOGE("Replacement Parcel is unexpectedly small: %d", length);
        env->DeleteLocalRef(bytes);
        env->DeleteLocalRef(metadata);
        env->DeleteLocalRef(builder);
        env->DeleteLocalRef(builder_class);
        env->CallVoidMethod(parcel, recycle);
        env->DeleteLocalRef(parcel);
        env->DeleteLocalRef(parcel_class);
        return false;
    }

    g_empty_metadata_reply.resize(static_cast<size_t>(length));
    env->GetByteArrayRegion(bytes, 0, length,
                            reinterpret_cast<jbyte*>(g_empty_metadata_reply.data()));
    const bool copy_failed = clearJniException(env, "copying replacement Parcel");

    env->CallVoidMethod(parcel, recycle);
    clearJniException(env, "recycling Parcel");
    env->DeleteLocalRef(bytes);
    env->DeleteLocalRef(metadata);
    env->DeleteLocalRef(builder);
    env->DeleteLocalRef(builder_class);
    env->DeleteLocalRef(parcel);
    env->DeleteLocalRef(parcel_class);

    if (copy_failed) {
        g_empty_metadata_reply.clear();
        return false;
    }

    LOGI("Prepared empty MediaMetadata reply (%zu bytes)", g_empty_metadata_reply.size());
    return true;
}

void* resolveSymbol(const char* const* names, size_t count) {
    for (size_t i = 0; i < count; ++i) {
        if (void* symbol = dlsym(RTLD_DEFAULT, names[i]); symbol != nullptr) return symbol;
    }

    void* handle = dlopen("libbinder.so", RTLD_NOW);
    if (handle == nullptr) {
        LOGE("Could not open libbinder.so: %s", dlerror());
        return nullptr;
    }

    for (size_t i = 0; i < count; ++i) {
        if (void* symbol = dlsym(handle, names[i]); symbol != nullptr) return symbol;
    }
    return nullptr;
}

bool resolveParcelFunctions() {
#if defined(__LP64__)
    const char* set_data_symbols[] = {
        "_ZN7android6Parcel7setDataEPKhm",
        "_ZN7android6Parcel7setDataEPKvm",
    };
    const char* set_position_symbols[] = {
        "_ZNK7android6Parcel15setDataPositionEm",
        "_ZN7android6Parcel15setDataPositionEm",
    };
#else
    const char* set_data_symbols[] = {
        "_ZN7android6Parcel7setDataEPKhj",
        "_ZN7android6Parcel7setDataEPKvj",
    };
    const char* set_position_symbols[] = {
        "_ZNK7android6Parcel15setDataPositionEj",
        "_ZN7android6Parcel15setDataPositionEj",
    };
#endif

    g_parcel_set_data = reinterpret_cast<ParcelSetDataFn>(
        resolveSymbol(set_data_symbols, sizeof(set_data_symbols) / sizeof(set_data_symbols[0])));
    g_parcel_set_data_position = reinterpret_cast<ParcelSetDataPositionFn>(resolveSymbol(
        set_position_symbols, sizeof(set_position_symbols) / sizeof(set_position_symbols[0])));

    if (g_parcel_set_data == nullptr || g_parcel_set_data_position == nullptr) {
        LOGE("Could not resolve Parcel::setData/setDataPosition");
        return false;
    }
    return true;
}

bool isGetMetadataRequest(const PParcel* request, uint32_t code) {
    if (request == nullptr || request->data == nullptr || code != g_get_metadata_code) return false;

    const size_t header_length = getBinderHeadersLen(g_sdk);
    if (request->data_size < header_length + sizeof(int32_t)) return false;

    int32_t descriptor_length = 0;
    memcpy(&descriptor_length, request->data + header_length, sizeof(descriptor_length));
    if (descriptor_length < 0 ||
        static_cast<size_t>(descriptor_length) != kSessionControllerDescriptorLength) {
        return false;
    }

    const size_t descriptor_bytes =
        (static_cast<size_t>(descriptor_length) + 1) * sizeof(char16_t);
    const size_t descriptor_offset = header_length + sizeof(int32_t);
    if (descriptor_offset + descriptor_bytes > request->data_size) return false;

    return memcmp(request->data + descriptor_offset, kSessionControllerDescriptor,
                  kSessionControllerDescriptorLength * sizeof(char16_t)) == 0;
}

bool isNullMetadataReply(const PParcel* reply) {
    // Normal Android 12 AIDL response: writeNoException() + nullable object marker.
    // A null MediaMetadata reply is therefore two zero int32 values.
    if (reply == nullptr || reply->data == nullptr || reply->data_size != 2 * sizeof(int32_t)) {
        return false;
    }

    int32_t exception_code = -1;
    int32_t presence_marker = -1;
    memcpy(&exception_code, reply->data, sizeof(exception_code));
    memcpy(&presence_marker, reply->data + sizeof(exception_code), sizeof(presence_marker));
    return exception_code == 0 && presence_marker == 0;
}

int transactHook(void* self, int32_t handle, uint32_t code, void* request,
                 void* reply, uint32_t flags) {
    const bool should_patch = isGetMetadataRequest(static_cast<PParcel*>(request), code);
    const int result = g_transact_original(self, handle, code, request, reply, flags);

    if (!should_patch || result != 0 || !isNullMetadataReply(static_cast<PParcel*>(reply))) {
        return result;
    }

    const int32_t set_data_result = g_parcel_set_data(
        reply, g_empty_metadata_reply.data(), g_empty_metadata_reply.size());
    if (set_data_result != 0) {
        LOGE("Parcel::setData failed: %d", set_data_result);
        return result;
    }

    g_parcel_set_data_position(reply, 0);
    LOGI("Replaced null MediaMetadata Binder reply");
    return result;
}

bool hookBinder(zygisk::Api* api) {
    ino_t inode = 0;
    dev_t device = 0;
    if (!getMapping("libbinder.so", &inode, &device)) {
        LOGE("Could not locate libbinder.so mapping");
        return false;
    }

    api->pltHookRegister(
        device, inode,
        "_ZN7android14IPCThreadState8transactEijRKNS_6ParcelEPS1_j",
        reinterpret_cast<void*>(&transactHook),
        reinterpret_cast<void**>(&g_transact_original));

    if (!api->pltHookCommit() || g_transact_original == nullptr) {
        LOGE("Could not install IPCThreadState::transact hook");
        return false;
    }
    return true;
}

bool isSupportedBuild() {
    if (android_get_device_api_level() != kSupportedSdk) return false;

    char fingerprint[PROP_VALUE_MAX] = {};
    if (__system_property_get("ro.build.fingerprint", fingerprint) <= 0) return false;
    return strcmp(fingerprint, kSupportedFingerprint) == 0;
}

bool run(zygisk::Api* api, JNIEnv* env) {
    g_sdk = android_get_device_api_level();
    if (!isSupportedBuild()) {
        LOGE("Unsupported build; refusing to hook (SDK %d)", g_sdk);
        return false;
    }

    g_get_metadata_code = getStaticIntFieldJni(
        env, STUB("android/media/session/ISessionController"), TRSCTN("getMetadata"));
    if (g_get_metadata_code == 0) {
        LOGE("Could not resolve ISessionController.TRANSACTION_getMetadata");
        return false;
    }

    if (!buildEmptyMetadataReply(env)) return false;
    if (!resolveParcelFunctions()) return false;
    if (!hookBinder(api)) return false;

    LOGI("Hook installed; transaction code=%u", g_get_metadata_code);
    return true;
}

class SystemUIMediaFix final : public zygisk::ModuleBase {
  public:
    void onLoad(zygisk::Api* api, JNIEnv* env) override {
        api_ = api;
        env_ = env;
    }

    void preServerSpecialize(zygisk::ServerSpecializeArgs* args) override {
        (void)args;
        api_->setOption(zygisk::Option::DLCLOSE_MODULE_LIBRARY);
    }

    void postAppSpecialize(const zygisk::AppSpecializeArgs* args) override {
        if (args == nullptr || args->nice_name == nullptr) {
            api_->setOption(zygisk::Option::DLCLOSE_MODULE_LIBRARY);
            return;
        }

        const char* process_name = env_->GetStringUTFChars(args->nice_name, nullptr);
        if (process_name == nullptr) {
            clearJniException(env_, "reading process name");
            api_->setOption(zygisk::Option::DLCLOSE_MODULE_LIBRARY);
            return;
        }

        const bool is_target = strcmp(process_name, kTargetProcess) == 0;
        env_->ReleaseStringUTFChars(args->nice_name, process_name);

        if (!is_target || !run(api_, env_)) {
            api_->setOption(zygisk::Option::DLCLOSE_MODULE_LIBRARY);
        }
    }

  private:
    zygisk::Api* api_ = nullptr;
    JNIEnv* env_ = nullptr;
};

}  // namespace

REGISTER_ZYGISK_MODULE(SystemUIMediaFix)
