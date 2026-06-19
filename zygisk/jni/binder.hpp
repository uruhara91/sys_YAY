#pragma once

#include <jni.h>
#include <stdint.h>
#include <sys/types.h>

#define STUB(name) (name "$Stub")
#define TRSCTN(name) ("TRANSACTION_" name)

// Minimal prefix of android::Parcel used by the original ih8SecureLock approach.
// The first machine word contains Parcel state/error fields, followed by mData
// and mDataSize on the Android 12 target build.
struct PParcel {
    size_t state;
    char* data;
    size_t data_size;
};

inline size_t getBinderHeadersLen(int sdk) {
    if (sdk >= 30) return 3 * sizeof(uint32_t);
    if (sdk == 29) return 2 * sizeof(uint32_t);
    return sizeof(uint32_t);
}

bool getMapping(const char* library_name, ino_t* inode, dev_t* device);
uint32_t getStaticIntFieldJni(JNIEnv* env, const char* class_name, const char* field_name);
