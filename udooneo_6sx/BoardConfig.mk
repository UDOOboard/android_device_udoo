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
TARGET_BOARD_DTS_FILES  := imx6sx-udoo-neo-{basic,basicks,extended,full}{-hdmi,-lvds7,-lvds15,}{-m4,}.dtb
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

# Connectivity - Wi-Fi wlink8
BOARD_WLAN_VENDOR            := TI
BOARD_WLAN_DEVICE            := WILINK8
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_WLINK8  := lib_driver_cmd_wl18xx
BOARD_HOSTAPD_PRIVATE_LIB_WLINK8         := lib_driver_cmd_wl18xx
COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211
COMMON_GLOBAL_CFLAGS += -DANDROID_P2P_STUB

TARGET_KERNEL_MODULES       += \
	drivers/misc/ti-st/st_drv.ko:system/lib/modules/st_drv.ko   \
	drivers/misc/ti-st/tty_hci.ko:system/lib/modules/tty_hci.ko \
	net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
	net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
	drivers/net/wireless/ti/wl18xx/wl18xx.ko:system/lib/modules/wl18xx.ko \
	drivers/net/wireless/ti/wlcore/wlcore.ko:system/lib/modules/wlcore.ko \
	drivers/net/wireless/ti/wlcore/wlcore_sdio.ko:system/lib/modules/wlcore_sdio.ko

PRODUCT_COPY_FILES +=   \
	hardware/ti/wlan/WILINK8/firmware/ti-connectivity/wl18xx-fw-4.bin:system/etc/firmware/ti-connectivity/wl18xx-fw-4.bin \
	hardware/ti/wlan/WILINK8/firmware/ti-connectivity/wl18xx-conf.bin:system/etc/firmware/ti-connectivity/wl18xx-conf.bin \
	hardware/ti/wlan/WILINK8/firmware/TIInit_11.8.32.bts:system/etc/firmware/TIInit_11.8.32.bts

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false


BOARD_HAVE_BLUETOOTH_TI := true
BOARD_HAVE_BLUETOOTH_BCM := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udooneo_6sx/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udoo_6sx/sepolicy

BOARD_SECCOMP_POLICY += device/udoo/udoo_6sx/seccomp


PRODUCT_COPY_FILES +=	\
	device/udoo/udooneo_6sx/uEnv.txt:system/uEnv.txt

