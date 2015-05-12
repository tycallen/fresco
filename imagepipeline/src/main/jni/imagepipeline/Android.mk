# Copyright 2004-present Facebook. All Rights Reserved.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := imagepipeline
LOCAL_SRC_FILES := \
	decoded_image.cpp \
	exceptions.cpp \
	init.cpp \
	jpeg/jpeg_codec.cpp \
	jpeg/jpeg_error_handler.cpp \
	jpeg/jpeg_memory_io.cpp \
	jpeg/jpeg_stream_wrappers.cpp \
	png/png_codec.cpp \
	png/png_stream_wrappers.cpp \
	streams.cpp \
	transformations.cpp \
	webp/webp_codec.cpp \
	JpegTranscoder.cpp \
	WebpTranscoder.cpp


CXX11_FLAGS := -std=c++11
LOCAL_CFLAGS += $(CXX11_FLAGS)
LOCAL_CFLAGS += -DLOG_TAG=\"libimagepipeline\"
LOCAL_CFLAGS += -fvisibility=hidden
LOCAL_CFLAGS += $(FRESCO_CPP_CFLAGS)
LOCAL_EXPORT_CPPFLAGS := $(CXX11_FLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_LDLIBS := -llog
LOCAL_LDFLAGS += $(FRESCO_CPP_LDFLAGS)
LOCAL_SHARED_LIBRARIES += webp

ifeq ($(BUCK_BUILD), 1)
  LOCAL_SHARED_LIBRARIES += fb_jpegturbo
  LOCAL_CFLAGS += $(BUCK_DEP_CFLAGS)
  LOCAL_LDFLAGS += $(BUCK_DEP_LDFLAGS)
  include $(BUILD_SHARED_LIBRARY)
else
  LOCAL_STATIC_LIBRARIES += fb_jpegturbo
  LOCAL_LDFLAGS += -Wl,--exclude-libs,libfb_jpegturbo.a

  LOCAL_LDLIBS += -lz
  LOCAL_STATIC_LIBRARIES += fb_png
  LOCAL_LDFLAGS += -Wl,--exclude-libs,libfb_png.a

  include $(BUILD_SHARED_LIBRARY)
  $(call import-module,libpng-1.6.10)
endif


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


$(call import-module,libjpeg-turbo-1.3.x)
$(call import-module,libwebp-0.4.2)
