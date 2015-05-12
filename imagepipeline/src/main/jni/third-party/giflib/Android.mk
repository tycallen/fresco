LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_CFLAGS    := -DHAVE_CONFIG_H
LOCAL_MODULE    := gif
LOCAL_SRC_FILES := \
	dgif_lib.c \
	gifalloc.c 
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)


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
