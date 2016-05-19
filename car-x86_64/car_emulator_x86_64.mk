#
#Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_COPY_FILES += \
    device/generic/car/car-x86_64/bootanimations/bootanimation-832.zip:system/media/bootanimation.zip \
    device/generic/car/car-x86_64/init.car-x86_64.rc:root/init.goldfish.rc

$(call inherit-product, build/target/product/aosp_x86_64.mk)
$(call inherit-product, packages/services/Car/car_product/build/car.mk)
PRODUCT_PACKAGE_OVERLAYS := device/generic/car/common/overlay

# Overrides
PRODUCT_BRAND := google
PRODUCT_MODEL := Car on x86 emulator
PRODUCT_NAME := car_emulator_x86_64
PRODUCT_DEVICE := car-x86_64

PRODUCT_RESTRICT_VENDOR_FILES := false

PRODUCT_PACKAGES += \
   vehicle.default
# Replace framework versions with dummy one, which is essentially
# the same as removing the xml. Needs this as there is no easy
# way to remove PRODUCT_COPY_FILES from inherited products.
PRODUCT_COPY_FILES += \
    device/generic/car/car-x86_64/android.hardware.dummy.xml:system/etc/permissions/handheld_core_hardware.xml \
    packages/services/Car/car_product/init/init.car.rc:root/init.car.rc \
    packages/services/Car/car_product/init/init.bootstat.rc:root/init.bootstat.rc

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.type.automotive.xml:system/etc/permissions/android.hardware.type.automotive.xml \
    frameworks/native/data/etc/android.hardware.screen.portrait.xml:system/etc/permissions/android.hardware.screen.portrait.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml

