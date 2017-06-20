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

ADDITIONAL_BUILD_PROPERTIES += \
	persist.udoo_enable_adk=false \
	persist.sys.bluetooth.model=UDOO \
	persist.sys.bluetooth.name=UDOO

PRODUCT_MODEL := UDOO-MX6DQ

# Bootloader (u-boot)
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_qd_android_config
TARGET_BOOTLOADER_BOARD_NAME := UDOO
TARGET_BOOTLOADER_POSTFIX := imx

# Kernel
TARGET_KERNEL_DEFCONF := udoo_quad_dual_android_defconfig
BOARD_KERNEL_CMDLINE  := console=ttymxc1,115200 init=/init vmalloc=128M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=448M androidboot.dm_verity=disabled androidboot.selinux=permissive
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-udoo-hdmi.dtb
TARGET_BOARD_DTS_FILES  := imx6{q,dl}-udoo{-lvds7,-lvds15,-hdmi}.dtb
TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers
TARGET_KERNEL_MODULES := \
	arch/arm/boot/dts/imx6dl-udoo-hdmi.dtb:system/dts/imx6dl-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds7.dtb:system/dts/imx6dl-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds15.dtb:system/dts/imx6dl-udoo-lvds15.dtb \
	arch/arm/boot/dts/imx6q-udoo-hdmi.dtb:system/dts/imx6q-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds7.dtb:system/dts/imx6q-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds15.dtb:system/dts/imx6q-udoo-lvds15.dtb

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6


BOARD_WLAN_DEVICE                        := RALINK
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
WIFI_DRIVER_STATE_CTRL_PARAM             := true
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/rt2800usb.ko"
WIFI_DRIVER_MODULE_NAME                  := "rt2800usb"
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RALINK  := lib_driver_cmd_ralink

TARGET_KERNEL_MODULES       += \
	net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
	net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
	drivers/net/wireless/rt2x00/rt2800lib.ko:system/lib/modules/rt2800lib.ko \
	drivers/net/wireless/rt2x00/rt2800usb.ko:system/lib/modules/rt2800usb.ko \
	drivers/net/wireless/rt2x00/rt2x00lib.ko:system/lib/modules/rt2x00lib.ko \
	drivers/net/wireless/rt2x00/rt2x00usb.ko:system/lib/modules/rt2x00usb.ko

BOARD_SUPPORT_BCM_WIFI  := false

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

TARGET_BUILD_BLUEZ              := true
BOARD_HAVE_BLUETOOTH        	:= true
BOARD_HAVE_BLUETOOTH_USB        := true
BOARD_HAVE_BLUETOOTH_BCM        := false
BLUETOOTH_HCI_USE_USB 		:= true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6dq/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

IMX_CAMERA_HAL_V3 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := false

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6dq/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6dq/seccomp

PRODUCT_COPY_FILES +=	\
	device/udoo/udoo_6dq/uEnv.txt:system/uEnv.txt \
	device/udoo/udoo_6dq/enableadk:system/bin/enableadk

