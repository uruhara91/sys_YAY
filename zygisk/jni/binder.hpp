#pragma once

#include <jni.h>
#include <stdint.h>
#include <sys/types.h>

#define STUB(name) (name "$Stub")
#define TRSCTN(name) ("TRANSACTION_" name)

// Minimal prefix of android::Parcel for the fingerprint-locked Android 12 target.
// The first machine word contains Parcel state/error fields, followed by mData
// and mDataSize.
struct PParcel {
    size_t state;
    char* data;
    size_t data_size;
};

bool getMapping(const char* library_name, ino_t* inode, dev_t* device);
uint32_t getStaticIntFieldJni(JNIEnv* env, const char* class_name, const char* field_name);
