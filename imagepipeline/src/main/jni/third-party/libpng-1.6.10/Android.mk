LOCAL_PATH:= $(call my-dir)

LIBPNG_SRC_FILES:= \
	png.c \
	pngerror.c \
	pngget.c \
	pngmem.c \
	pngpread.c \
	pngread.c \
	pngrio.c \
	pngrtran.c \
	pngrutil.c \
	pngset.c \
	pngtrans.c \
	pngwio.c \
	pngwrite.c \
	pngwtran.c \
	pngwutil.c



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

include $(CLEAR_VARS)
LOCAL_MODULE:= libfb_png
LOCAL_SRC_FILES:= $(LIBPNG_SRC_FILES)
LOCAL_CFLAGS:= $(LIBPNG_CFLAGS)
LOCAL_EXPORT_C_INCLUDES:= $(LOCAL_PATH)
include $(BUILD_STATIC_LIBRARY)
