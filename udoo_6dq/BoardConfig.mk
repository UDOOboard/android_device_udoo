include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/udoo_6dq/build_id.mk
include device/udoo/udoo_6dq/twrp.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ADDITIONAL_BUILD_PROPERTIES += \
	ro.boot.storage_type=sd
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6dq/fstab.freescale
PRODUCT_COPY_FILES +=	\
	device/udoo/udoo_6dq/fstab_sd.freescale:root/fstab.freescale     \
	device/udoo/udoo_6dq/fstab_sd.freescale:root/fstab.freescale.sd  \
	device/udoo/udoo_6dq/fstab_sata.freescale:root/fstab.freescale.sata

ADDITIONAL_BUILD_PROPERTIES += \
	persist.udoo_enable_adk=false

TARGET_BOOTLOADER_BOARD_NAME := UDOO
PRODUCT_MODEL := UDOO-MX6DQ

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6

BOARD_WLAN_DEVICE                        := RALINK
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
WIFI_DRIVER_STATE_CTRL_PARAM             := true
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/rt2800usb.ko"
WIFI_DRIVER_MODULE_NAME                  := "rt2800usb"
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RALINK  := lib_driver_cmd_ralink

TARGET_KERNEL_MODULES       := \
	backports/net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
	backports/net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
	backports/drivers/net/wireless/rt2x00/rt2800lib.ko:system/lib/modules/rt2800lib.ko \
	backports/drivers/net/wireless/rt2x00/rt2800usb.ko:system/lib/modules/rt2800usb.ko \
	backports/drivers/net/wireless/rt2x00/rt2x00lib.ko:system/lib/modules/rt2x00lib.ko \
	backports/drivers/net/wireless/rt2x00/rt2x00usb.ko:system/lib/modules/rt2x00usb.ko

PRODUCT_COPY_FILES +=   \
	device/udoo/common/wifi/firmware/rt5370/rt2870.bin:system/etc/firmware/rt2870.bin

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := false
SENSOR_MMA8451 := false

BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init vmalloc=256M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=256M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

TARGET_BUILD_BLUEZ              := true
BOARD_HAVE_BLUETOOTH        	:= true
BOARD_HAVE_BLUETOOTH_USB        := true
BOARD_HAVE_BLUETOOTH_BCM        := false
BLUETOOTH_HCI_USE_USB 		:= true

BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL     := true
BLUETOOTH_HCI_USE_MCT                   := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6dq/bluetooth


USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v3
IMX_CAMERA_HAL_V3 := true

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_qd_android_config
TARGET_KERNEL_DEFCONF := udoo_quad_dual_android_defconfig
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-udoo-hdmi.dtb

TARGET_KERNEL_MODULES += \
	arch/arm/boot/dts/imx6dl-udoo-hdmi.dtb:system/dts/imx6dl-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds7.dtb:system/dts/imx6dl-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds15.dtb:system/dts/imx6dl-udoo-lvds15.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds7hdmi.dtb:system/dts/imx6dl-udoo-lvds7hdmi.dtb \
	arch/arm/boot/dts/imx6q-udoo-hdmi.dtb:system/dts/imx6q-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds7.dtb:system/dts/imx6q-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds15.dtb:system/dts/imx6q-udoo-lvds15.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds7hdmi.dtb:system/dts/imx6q-udoo-lvds7hdmi.dtb \

PRODUCT_COPY_FILES +=	\
	device/udoo/udoo_6dq/uEnv.txt:system/uEnv.txt \
	device/udoo/udoo_6dq/enableadk:system/bin/enableadk


BOARD_SEPOLICY_DIRS := \
	device/udoo/imx6/sepolicy \
	device/udoo/udoo_6dq/sepolicy
