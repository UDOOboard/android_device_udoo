include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/a62_6dq/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_DEVICE),sd)
ADDITIONAL_BUILD_PROPERTIES += \
                        ro.boot.storage_type=sd
ifneq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab_sd.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab_emmc.freescale:root/fstab.freescale  \
	device/udoo/a62_6dq/fstab_sd.freescale:root/fstab.freescale.sd \
	device/udoo/a62_6dq/fstab_emmc.freescale:root/fstab.freescale.emmc \
	device/udoo/a62_6dq/fstab_sata.freescale:root/fstab.freescale.sata
else
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab_sd-f2fs.freescale
# build for f2fs
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab_sd-f2fs.freescale:root/fstab.freescale
endif # BUILD_TARGET_FS
else
ADDITIONAL_BUILD_PROPERTIES += \
                        ro.boot.storage_type=emmc
ifneq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab.freescale:root/fstab.freescale
else
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab-f2fs.freescale
# build for f2fs
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab-f2fs.freescale:root/fstab.freescale
endif # BUILD_TARGET_FS
endif # BUILD_TARGET_DEVICE


TARGET_BOOTLOADER_BOARD_NAME := A62
PRODUCT_MODEL := A62-MX6DQ

ADDITIONAL_BUILD_PROPERTIES += \
	       persist.audio.device=alc655-audio

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6
BOARD_WLAN_DEVICE                        := RALINK
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
WIFI_DRIVER_STATE_CTRL_PARAM             := true
WIFI_DRIVER_MODULE_PATH			 := "/system/lib/modules/rt2800usb.ko"
WIFI_DRIVER_MODULE_NAME			 := "rt2800usb"
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

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/udoo/a62_6dq/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

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
IMX_CAMERA_HAL_V3 := false

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6q:mx6qdl_a62_android_defconfig 
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-seco_A62.dtb imx6dl:imx6dl-seco_A62.dtb

TARGET_KERNEL_VERSION := kernel_imx
TARGET_KERNEL_DEFCONF := imx_v7_android_A62_defconfig
TARGET_KERNEL_MODULES += \
	arch/arm/boot/dts/imx6dl-seco_A62-hdmi.dtb:system/dts/imx6dl-a62-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-seco_A62-lvds7.dtb:system/dts/imx6dl-a62-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-seco_A62-lvds15.dtb:system/dts/imx6dl-a62-lvds15.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-hdmi.dtb:system/dts/imx6q-a62-hdmi.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-lvds7.dtb:system/dts/imx6q-a62-lvds7.dtb \
	arch/arm/boot/dts/imx6q-seco_A62-lvds15.dtb:system/dts/imx6q-a62-lvds15.dtb \

PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/uEnv.txt:system/uEnv.txt

BOARD_SEPOLICY_DIRS := \
	device/udoo/imx6/sepolicy \
	device/udoo/a62_6dq/sepolicy
