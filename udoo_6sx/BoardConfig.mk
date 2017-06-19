include device/udoo/imx6/soc/imx6sx.mk
include device/udoo/udoo_6sx/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk

ADDITIONAL_BUILD_PROPERTIES += \
                        ro.internel.storage_size=/sys/block/mmcblk0/size \
                        ro.frp.pst=/dev/block/mmcblk0p12

BUILD_TARGET_FS ?= ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6sx/fstab_sd.freescale
PRODUCT_COPY_FILES   += device/udoo/udoo_6sx/fstab_sd.freescale:root/fstab.freescale

PRODUCT_MODEL := UDOONEO-MX6SX

# Bootloader (u-boot)
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_neo_android_config
TARGET_BOOTLOADER_BOARD_NAME := UDOONEO
TARGET_BOOTLOADER_POSTFIX := imx

# Kernel
TARGET_KERNEL_DEFCONF := udoo_neo_android_defconfig
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale vmalloc=128M cma=448M androidboot.dm_verity=disabled
TARGET_BOARD_DTS_CONFIG := imx6sx:imx6sx-udoo-neo-full-hdmi-m4.dtb
TARGET_BOARD_KERNEL_HEADERS := device/udoo/common/kernel-headers
TARGET_KERNEL_MODULES := \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-hdmi-m4.dtb:system/dts/imx6sx-udoo-neo-basic-hdmi-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-hdmi.dtb:system/dts/imx6sx-udoo-neo-basic-hdmi.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-lvds7-m4.dtb:system/dts/imx6sx-udoo-neo-basic-lvds7-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-lvds7.dtb:system/dts/imx6sx-udoo-neo-basic-lvds7.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-lvds15-m4.dtb:system/dts/imx6sx-udoo-neo-basic-lvds15-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-lvds15.dtb:system/dts/imx6sx-udoo-neo-basic-lvds15.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic-m4.dtb:system/dts/imx6sx-udoo-neo-basic-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basic.dtb:system/dts/imx6sx-udoo-neo-basic.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-hdmi-m4.dtb:system/dts/imx6sx-udoo-neo-basicks-hdmi-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-hdmi.dtb:system/dts/imx6sx-udoo-neo-basicks-hdmi.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-lvds7-m4.dtb:system/dts/imx6sx-udoo-neo-basicks-lvds7-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-lvds7.dtb:system/dts/imx6sx-udoo-neo-basicks-lvds7.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-lvds15-m4.dtb:system/dts/imx6sx-udoo-neo-basicks-lvds15-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-lvds15.dtb:system/dts/imx6sx-udoo-neo-basicks-lvds15.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks-m4.dtb:system/dts/imx6sx-udoo-neo-basicks-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-basicks.dtb:system/dts/imx6sx-udoo-neo-basicks.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-hdmi-m4.dtb:system/dts/imx6sx-udoo-neo-extended-hdmi-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-hdmi.dtb:system/dts/imx6sx-udoo-neo-extended-hdmi.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-lvds7-m4.dtb:system/dts/imx6sx-udoo-neo-extended-lvds7-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-lvds7.dtb:system/dts/imx6sx-udoo-neo-extended-lvds7.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-lvds15-m4.dtb:system/dts/imx6sx-udoo-neo-extended-lvds15-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-lvds15.dtb:system/dts/imx6sx-udoo-neo-extended-lvds15.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended-m4.dtb:system/dts/imx6sx-udoo-neo-extended-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-extended.dtb:system/dts/imx6sx-udoo-neo-extended.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-hdmi-m4.dtb:system/dts/imx6sx-udoo-neo-full-hdmi-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-hdmi.dtb:system/dts/imx6sx-udoo-neo-full-hdmi.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-lvds7-m4.dtb:system/dts/imx6sx-udoo-neo-full-lvds7-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-lvds7.dtb:system/dts/imx6sx-udoo-neo-full-lvds7.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-lvds15-m4.dtb:system/dts/imx6sx-udoo-neo-full-lvds15-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-lvds15.dtb:system/dts/imx6sx-udoo-neo-full-lvds15.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full-m4.dtb:system/dts/imx6sx-udoo-neo-full-m4.dtb \
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb:system/dts/imx6sx-udoo-neo-full.dtb


TARGET_BOOTLOADER_POSTFIX := imx

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6
# UNITE is a virtual device.
BOARD_WLAN_DEVICE            := UNITE
WPA_SUPPLICANT_VERSION       := VER_0_8_UNITE
BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_BCM               := lib_driver_cmd_bcmdhd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_BCM        := lib_driver_cmd_bcmdhd

BOARD_SUPPORT_BCM_WIFI  := true

#for intel vendor
ifeq ($(BOARD_WLAN_VENDOR),INTEL)
BOARD_HOSTAPD_PRIVATE_LIB                := private_lib_driver_cmd
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
HOSTAPD_VERSION                          := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd_intel
WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/iwlagn.ko"
WIFI_DRIVER_MODULE_NAME                  := "iwlagn"
WIFI_DRIVER_MODULE_PATH                  ?= auto
endif

WIFI_DRIVER_FW_PATH_STA        := "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P        := "/system/etc/firmware/bcm/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP         := "/system/etc/firmware/bcm/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_PARAM      := "/sys/module/bcmdhd/parameters/firmware_path"

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif


BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6sx/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6sx/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6sx/seccomp
