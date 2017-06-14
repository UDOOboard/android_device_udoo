include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/udoo_6dq/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk

ADDITIONAL_BUILD_PROPERTIES += \
                        ro.internel.storage_size=/sys/block/mmcblk0/size \
                        ro.boot.storage_type=sd \
                        ro.frp.pst=/dev/block/mmcblk0p12

BUILD_TARGET_FS ?= ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6dq/fstab_sd.freescale
PRODUCT_COPY_FILES   += device/udoo/udoo_6dq/fstab_sd.freescale:root/fstab.freescale

TARGET_BOOTLOADER_BOARD_NAME := udoo
PRODUCT_MODEL := udoo-MX6DQ

TARGET_BOOTLOADER_POSTFIX := imx

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6


BOARD_WLAN_DEVICE                        := RALINK
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
WIFI_DRIVER_STATE_CTRL_PARAM             := true
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/rt2800usb.ko"
WIFI_DRIVER_MODULE_NAME                  := "rt2800usb"
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RALINK  := lib_driver_cmd_ralink


BOARD_SUPPORT_BCM_WIFI  := false

BOARD_MODEM_VENDOR := AMAZON

USE_ATHR_GPS_HARDWARE := true
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true

BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init vmalloc=128M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=448M androidboot.dm_verity=disabled

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif


# Broadcom BCM4339 BT
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6dq/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

PHONE_MODULE_INCLUDE := true
# camera hal v3
IMX_CAMERA_HAL_V3 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := false

TARGET_KERNEL_DEFCONF := udoo_quad_dual_android_defconfig
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_qd_android_config
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-udoo-hdmi.dtb

TARGET_KERNEL_MODULES := \
	arch/arm/boot/dts/imx6dl-udoo-hdmi.dtb:system/dts/imx6dl-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds7.dtb:system/dts/imx6dl-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds15.dtb:system/dts/imx6dl-udoo-lvds15.dtb \
	arch/arm/boot/dts/imx6q-udoo-hdmi.dtb:system/dts/imx6q-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds7.dtb:system/dts/imx6q-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds15.dtb:system/dts/imx6q-udoo-lvds15.dtb \

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6dq/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6dq/seccomp

TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers
