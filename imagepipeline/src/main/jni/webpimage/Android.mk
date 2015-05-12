# Copyright 2004-present Facebook. All Rights Reserved.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := webpimage

LOCAL_SRC_FILES := \
  jni.cpp \
  webp.cpp \
  jni_helpers.cpp \

CXX11_FLAGS := -std=c++11
LOCAL_CFLAGS += $(CXX11_FLAGS)
LOCAL_CFLAGS += -fvisibility=hidden
LOCAL_CFLAGS += $(FRESCO_CPP_CFLAGS)
LOCAL_EXPORT_CPPFLAGS := $(CXX11_FLAGS)
LOCAL_LDLIBS += -llog -ljnigraphics
LOCAL_LDFLAGS += $(FRESCO_CPP_LDFLAGS)
LOCAL_SHARED_LIBRARIES += webp

LOCAL_CFLAGS += $(BUCK_DEP_CFLAGS)
LOCAL_LDFLAGS += $(BUCK_DEP_LDFLAGS)
include $(BUILD_SHARED_LIBRARY)


#LOCAL_CPPFLAGS += -ffunction-sections -fdata-sections -fvisibility=hidden
LOCAL_CPPFLAGS += -ffunction-sections -fdata-sections -fvisibility=hidden
LOCAL_CFLAGS += -ffunction-sections -fdata-sections
LOCAL_LDFLAGS += -Wl,--gc-sections

ifeq ($(TARGET_ARCH),mips)
  LOCAL_LDFLAGS += -Wl,--gc-sections
else
  LOCAL_LDFLAGS += -Wl,--gc-sections,--icf=safe
endif


 TARGET_mips_release_CFLAGS := -Os -g -DNDEBUG -fomit-frame-pointer -funswitch-loops -finline-limit=64

 TARGET_mips_debug_CFLAGS := -O0 -g

 TARGET_CFLAGS += -fstack-protector

TARGET_x86_release_CFLAGS := -Os -g -DNDEBUG -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=64

$(call import-module, libwebp-0.4.2)
