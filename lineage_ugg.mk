#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_n_mr1.mk)

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from xiaomi device
$(call inherit-product, device/xiaomi/ugg/device.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := ugg
PRODUCT_NAME := lineage_ugg
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Y1
PRODUCT_MANUFACTURER := Xiaomi

# Override Product Name
PRODUCT_SYSTEM_NAME := ugg
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="ugg-user-7.1.2-N2G47H-V11.0.2.0.NDKMIXM-release-keys" \
    BuildFingerprint=xiaomi/ugg/ugg:7.1.2/N2G47H/V11.0.2.0.NDKMIXM:user/release-keys
