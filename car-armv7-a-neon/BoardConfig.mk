#
# Copyright (C) 2017 The Android Open Source Project
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

include $(SRC_TARGET_DIR)/board/generic/BoardConfig.mk

TARGET_USES_CAR_FUTURE_FEATURES := true

# Enable Vendor Image
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1610612736
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_CACHEIMAGE_PARTITION_SIZE := 69206016

# Use generic car (instead of build/target/board/generic/sepolicy)
# and car_product policy.
# TODO This is only necessary because car_product defines opengl as well.
# When that is removed, remove this BoardConfig and switch the device in the mk
# to generic_x86.
BOARD_SEPOLICY_DIRS := \
    device/generic/car/common/sepolicy \
    packages/services/Car/car_product/sepolicy
