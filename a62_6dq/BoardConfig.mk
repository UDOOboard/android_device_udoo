include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/a62_6dq/build_id.mk
include device/udoo/a62_6dq/twrp.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ADDITIONAL_BUILD_PROPERTIES += \
	ro.boot.storage_type=sd
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab_sd.freescale
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab_emmc.freescale:root/fstab.freescale  \
	device/udoo/a62_6dq/fstab_sd.freescale:root/fstab.freescale.sd \
	device/udoo/a62_6dq/fstab_emmc.freescale:root/fstab.freescale.emmc \
	device/udoo/a62_6dq/fstab_sata.freescale:root/fstab.freescale.sata

ADDITIONAL_BUILD_PROPERTIES += \
	persist.audio.device=alc655-audio

TARGET_BOOTLOADER_BOARD_NAME := A62
PRODUCT_MODEL := A62-MX6DQ

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

BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init vmalloc=256M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=384M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend  

BOARD_HAVE_BLUETOOTH        	:= true
BOARD_HAVE_BLUETOOTH_USB        := true
BOARD_HAVE_BLUETOOTH_BCM        := false
BLUETOOTH_HCI_USE_USB 		:= true

BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL     := true
BLUETOOTH_HCI_USE_MCT                   := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/a62_6dq/bluetooth


USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v3
IMX_CAMERA_HAL_V3 := true

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6q:mx6qdl_a62_android_defconfig
TARGET_KERNEL_DEFCONF := imx_v7_android_A62_defconfig
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-seco_A62.dtb imx6dl:imx6dl-seco_A62.dtb

TARGET_KERNEL_MODULES += \
	arch/arm/boot/dts/imx6dl-seco_A62-hdmi.dtb:system/dts/imx6dl-a62-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-seco_A62-lvds7.dtb:system/dts/imx6dl-a62-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-seco_A62-lvds15.dtb:system/dts/imx6dl-a62-lvds15.dtb \
	arch/arm/boot/dts/imx6dl-seco_A62-lvds7hdmi.dtb:system/dts/imx6dl-a62-lvds7hdmi.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-hdmi.dtb:system/dts/imx6q-a62-hdmi.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-lvds7.dtb:system/dts/imx6q-a62-lvds7.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-lvds15.dtb:system/dts/imx6q-a62-lvds15.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-lvds7hdmi.dtb:system/dts/imx6q-a62-lvds7hdmi.dtb \

PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/uEnv.txt:system/uEnv.txt

BOARD_SEPOLICY_DIRS := \
	device/udoo/imx6/sepolicy \
	device/udoo/a62_6dq/sepolicy
