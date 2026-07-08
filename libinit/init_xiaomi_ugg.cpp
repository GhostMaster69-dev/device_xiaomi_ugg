/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_dalvik_heap.h>
#include <libinit_utils.h>
#include <libinit_variant.h>

#include "vendor_init.h"

#include <android-base/file.h>
#include <fstab/fstab.h>

static void device_info = {
    .brand = "xiaomi",
    .device = "ugg",
    .marketname = "",
    .model = "Redmi Y1",
    .build_fingerprint = "",
    .dpi = 260,
};

static void enable_gatekeeper_uid_offset() {
    std::string boot_device = *android::fs_mgr::GetBootDevices().begin();
    if (boot_device == "soc/7864900.sdhci") {
        property_override("ro.gsid.image_running", "1");
    }
}

#ifdef __ANDROID_RECOVERY__
static void set_verified_boot_props_to_disabled(void) {
    property_override("ro.boot.verifiedbootstate", "orange");
    property_override("ro.boot.veritymode", "disabled");
}
#endif

void vendor_load_properties() {
    device_info();
    enable_gatekeeper_uid_offset();
    set_bootloader_prop();
    set_dalvik_heap();

#ifdef __ANDROID_RECOVERY__
    set_verified_boot_props_to_disabled();
#endif
}
