LOCAL_PATH:= $(call my-dir)

JPEGTURBO_CFLAGS := -DJPEG_LIB_VERSION=80 -Wno-attributes

JPEGTURBO_SRC_FILES := \
	jcapimin.c jcapistd.c jccoefct.c jccolor.c \
	jcdctmgr.c jchuff.c jcinit.c jcmainct.c jcmarker.c jcmaster.c \
	jcomapi.c jcparam.c jcphuff.c jcprepct.c jcsample.c jctrans.c \
	jdapimin.c jdapistd.c jdatadst.c jdatasrc.c jdcoefct.c jdcolor.c \
	jddctmgr.c jdhuff.c jdinput.c jdmainct.c jdmarker.c jdmaster.c \
	jdmerge.c jdphuff.c jdpostct.c jdsample.c jdtrans.c jerror.c \
	jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c jidctint.c \
	jidctred.c jquant1.c jquant2.c jutils.c jmemmgr.c \
	jaricom.c jcarith.c jdarith.c \
	transupp.c jmemnobs.c

# switch between SIMD supported and non supported architectures
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
JPEGTURBO_SRC_FILES += \
	simd/jsimd_arm_neon.S.neon \
	simd/jsimd_arm.c
else
JPEGTURBO_SRC_FILES += jsimd_none.c
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


# fb_jpegturbo module
include $(CLEAR_VARS)
LOCAL_MODULE:= fb_jpegturbo
LOCAL_SRC_FILES := $(JPEGTURBO_SRC_FILES)
LOCAL_CFLAGS := $(JPEGTURBO_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH) 
include $(BUILD_STATIC_LIBRARY)
