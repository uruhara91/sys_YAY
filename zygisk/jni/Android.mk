LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := systemui_media_fix
LOCAL_SRC_FILES := module.cpp binder.cpp
LOCAL_CPPFLAGS := \
    -std=c++20 \
    -Wall \
    -Wextra \
    -Wpedantic \
    -fvisibility=hidden \
    -fvisibility-inlines-hidden \
    -ffunction-sections \
    -fdata-sections
LOCAL_LDFLAGS := -Wl,--gc-sections
LOCAL_LDLIBS := -llog -landroid -ldl
include $(BUILD_SHARED_LIBRARY)
