#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common
$(call inherit-product, device/xiaomi/msm8937-common/common.mk)
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# 64-bit support
TARGET_SUPPORTS_64_BIT_APPS := true

# Board
BOARD_VENDOR=xiaomi
TARGET_BOARD_PLATFORM := msm8937
TARGET_BOARD_SUFFIX := _64

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

PRODUCT_PACKAGES += \
    DeviceOverlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_fingerprint/android.hardware.fingerprint.xml

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.xml,$(LOCAL_PATH)/audio/mixer_paths/,$(TARGET_COPY_OUT_ODM)/etc/) \
    $(call find-copy-subdir-files,*.xml,$(LOCAL_PATH)/audio/platform_info/,$(TARGET_COPY_OUT_ODM)/etc/)

# Camera
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_ODM)/bin/mm-qcamera-daemon \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_ODM)/etc/camera/.placeholder

PRODUCT_PACKAGES += \
    camera.ulysse

# Dumpstate
PRODUCT_PACKAGES += \
    libdumpstate_device

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck_ramdisk \
    tune2fs_ramdisk \
    resize2fs_ramdisk

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Use FUSE passthrough
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.fuse.passthrough.enable=true

# Fingerprint
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_ODM)/bin/gx_fpd

PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service.xiaomi_ugg

PRODUCT_PACKAGES += \
    liblzma.vendor:64

# Input
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/keylayout/,$(TARGET_COPY_OUT_ODM)/usr/keylayout/) \
    $(foreach f, msm8917-sku5-snd-card_Button_Jack.kl msm8920-sku7-snd-card_Button_Jack.kl msm8952-sku1-snd-card_Button_Jack.kl, \
        $(LOCAL_PATH)/keylayout/msm8952-snd-card-mtp_Button_Jack.kl:$(TARGET_COPY_OUT_ODM)/usr/keylayout/$(f))

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay-service.sysfs

$(call soong_config_set_bool,livedisplay_sysfs,enable_ab,true)
$(call soong_config_set_bool,livedisplay_sysfs,enable_ce,true)
$(call soong_config_set_bool,livedisplay_sysfs,enable_re,true)

# Placeholder
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_ODM)/bin/.placeholder \
    $(LOCAL_PATH)/configs/blankfile:$(TARGET_COPY_OUT_ODM)/lib64/.placeholder

# Power
$(call soong_config_set,qtipower,tap_to_wake_node,/proc/sys/dev/xiaomi_msm8937_touchscreen/enable_dt2w)

# Recovery
PRODUCT_COPY_FILES += \
    vendor/xiaomi/ugg/proprietary/vendor/bin/hvdcp_opti:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/hvdcp_opti

# Rootdir
PRODUCT_PACKAGES += \
    fstab.qcom_ramdisk \
    init.baseband.sh \
    init.goodix.sh \
    init.xiaomi.device.rc \
    init.xiaomi.device.sh

# Shims
PRODUCT_PACKAGES += \
    libbinder_shim.vendor \
    libfakelogprint \
    libshim_mutexdestroy \
    libshim_pthreadts \
    libshims_android \
    libshims_ui \
    libwui

PRODUCT_COPY_FILES += \
    prebuilts/vndk/v32/arm64/arch-arm64-armv8-a/shared/vndk-sp/libhidlbase.so:$(TARGET_COPY_OUT_ODM)/lib64/libhidlbase-v32.so

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from vendor blobs
$(call inherit-product, vendor/xiaomi/ugg/ugg-vendor.mk)
