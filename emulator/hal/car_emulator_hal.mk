#
# Copyright (C) 2018 Google Inc.
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
#

# Default HAL implementations for automotive
PRODUCT_PACKAGES += \
    android.hardware.automotive.audiocontrol@1.0-service \
    android.hardware.bluetooth@1.0-service.sim \
    android.hardware.bluetooth.audio@2.0-impl \
    android.hardware.automotive.vehicle@2.0-service

# Vendor Interface Manifest
PRODUCT_COPY_FILES += \
    device/generic/car/emulator/hal/car_emulator_manifest.xml:$(TARGET_COPY_OUT_VENDOR)/manifest.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml
