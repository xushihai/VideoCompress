# This is the Android makefile for libyuv for both platform and NDK.
LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc

        LOCAL_SRC_FILES := \
    libyuv/source/compare.cc           \
    libyuv/source/compare_common.cc    \
    libyuv/source/convert.cc           \
    libyuv/source/convert_argb.cc      \
    libyuv/source/convert_from.cc      \
    libyuv/source/convert_from_argb.cc \
    libyuv/source/convert_to_argb.cc   \
    libyuv/source/convert_to_i420.cc   \
   libyuv/source/cpu_id.cc            \
    libyuv/source/planar_functions.cc  \
    libyuv/source/rotate.cc            \
    libyuv/source/rotate_any.cc        \
    libyuv/source/rotate_argb.cc       \
    libyuv/source/rotate_common.cc     \
    libyuv/source/row_any.cc           \
    libyuv/source/row_common.cc        \
    libyuv/source/scale.cc             \
    libyuv/source/scale_any.cc         \
    libyuv/source/scale_argb.cc        \
    libyuv/source/scale_common.cc      \
    libyuv/source/video_common.cc

        ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DLIBYUV_NEON
        LOCAL_SRC_FILES += \
        libyuv/source/compare_neon.cc.neon    \
        libyuv/source/rotate_neon.cc.neon     \
        libyuv/source/row_neon.cc.neon        \
        libyuv/source/scale_neon.cc.neon
        endif

ifeq ($(TARGET_ARCH_ABI),arm64-v8a)
LOCAL_CFLAGS += -DLIBYUV_NEON
        LOCAL_SRC_FILES += \
        libyuv/source/compare_neon64.cc    \
        libyuv/source/rotate_neon64.cc     \
        libyuv/source/row_neon64.cc        \
        libyuv/source/scale_neon64.cc
        endif

ifeq ($(TARGET_ARCH_ABI),$(filter $(TARGET_ARCH_ABI), x86 x86_64))
LOCAL_SRC_FILES += \
        libyuv/source/compare_gcc.cc       \
        libyuv/source/rotate_gcc.cc        \
        libyuv/source/row_gcc.cc           \
        libyuv/source/scale_gcc.cc
        endif

LOCAL_SRC_FILES     += \
  jni.c \
  utils.c \
  video.c \


LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/libyuv/include
LOCAL_C_INCLUDES += $(LOCAL_PATH)/libyuv/include

        LOCAL_MODULE := tmessages.22
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
#include $(BUILD_STATIC_LIBRARY)
