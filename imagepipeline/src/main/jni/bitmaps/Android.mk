# Copyright (c) 2015-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree. An additional grant
# of patent rights can be found in the PATENTS file in the same directory.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := bitmaps
LOCAL_SRC_FILES := \
	Bitmaps.c

LOCAL_CFLAGS += -Wall -Wextra -Werror -std=c11
LOCAL_CFLAGS += -fvisibility=hidden
LOCAL_LDLIBS := -ljnigraphics


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

include $(BUILD_SHARED_LIBRARY)
