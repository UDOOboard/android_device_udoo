#
# Product-specific compile-time definitions.
#

include device/udoo/imx6/soc/imx6sx.mk
include device/udoo/udooneo_6sx/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# udooneo_6sx default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_FS),ubifs)
TARGET_RECOVERY_FSTAB = device/udoo/udooneo_6sx/fstab_nand.freescale
# build ubifs for nand devices
PRODUCT_COPY_FILES +=	\
	device/udoo/udooneo_6sx/fstab_nand.freescale:root/fstab.freescale
else
ifneq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/udooneo_6sx/fstab.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/udoo/udooneo_6sx/fstab.freescale:root/fstab.freescale
else
TARGET_RECOVERY_FSTAB = device/udoo/udooneo_6sx/fstab-f2fs.freescale
# build for f2fs
PRODUCT_COPY_FILES +=	\
	device/udoo/udooneo_6sx/fstab-f2fs.freescale:root/fstab.freescale
endif # BUILD_TARGET_FS
endif # BUILD_TARGET_FS


TARGET_BOOTLOADER_BOARD_NAME := UDOONEO
PRODUCT_MODEL := UDOONEO-MX6SX

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6

# Connectivity - Wi-Fi wlink8
BOARD_WLAN_VENDOR            := TI
BOARD_WLAN_DEVICE            := WILINK8
USES_TI_MAC80211 := true
ifeq ($(USES_TI_MAC80211),true)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION      := VER_0_8_X
BOARD_HOSTAPD_DRIVER        := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_WLINK8  := lib_driver_cmd_wl18xx
BOARD_HOSTAPD_PRIVATE_LIB_WLINK8         := lib_driver_cmd_wl18xx
COMMON_GLOBAL_CFLAGS += -DUSES_TI_MAC80211
COMMON_GLOBAL_CFLAGS += -DANDROID_P2P_STUB

TARGET_KERNEL_MODULES       := \
                                backports/net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
                                backports/net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
				backports/drivers/net/wireless/ti/wl12xx/wl12xx.ko:system/lib/modules/wl12xx.ko \
				backports/drivers/net/wireless/ti/wl18xx/wl18xx.ko:system/lib/modules/wl18xx.ko \
				backports/drivers/net/wireless/ti/wlcore/wlcore.ko:system/lib/modules/wlcore.ko \
				backports/drivers/net/wireless/ti/wlcore/wlcore_sdio.ko:system/lib/modules/wlcore_sdio.ko

endif

PRODUCT_COPY_FILES +=   \
			hardware/ti/wlan/WILINK8/firmware/ti-connectivity/wl18xx-fw-4.bin:system/etc/firmware/ti-connectivity/wl18xx-fw-4.bin \
			hardware/ti/wlan/WILINK8/firmware/ti-connectivity/wl18xx-conf.bin:system/etc/firmware/ti-connectivity/wl18xx-conf.bin \
			hardware/ti/wlan/WILINK8/firmware/TIInit_11.8.32.bts:system/etc/firmware/TIInit_11.8.32.bts

					
BOARD_HAVE_BLUETOOTH_TI := true

USE_ATHR_GPS_HARDWARE := false
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := true
SENSOR_MMA8451 := true

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true
# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/udoo/udooneo_6sx/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init vmalloc=256M androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale cma=64M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif


BOARD_HAVE_BLUETOOTH_BCM := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udooneo_6sx/bluetooth

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v1
IMX_CAMERA_HAL_V1 := true
TARGET_VSYNC_DIRECT_REFRESH := true

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6sx:udoo_neo_android_defconfig
TARGET_KERNEL_DEFCONF := udoo_neo_android_defconfig
TARGET_BOARD_DTS_CONFIG := imx6sx:imx6sx-udoo-neo-full-hdmi-m4.dtb

TARGET_KERNEL_MODULES += \
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
	arch/arm/boot/dts/imx6sx-udoo-neo-full.dtb:system/dts/imx6sx-udoo-neo-full.dtb \

PRODUCT_COPY_FILES +=	\
	device/udoo/udooneo_6sx/uEnv.txt:system/uEnv.txt

BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/udooneo_6sx/sepolicy

BOARD_SEPOLICY_UNION := \
       domain.te \
       system_app.te \
       system_server.te \
       untrusted_app.te \
       sensors.te \
       init_shell.te \
       bluetooth.te \
       hci_attach.te \
       kernel.te \
       mediaserver.te \
       file_contexts \
       genfs_contexts \
       fs_use  \
       rild.te \
       init.te \
       netd.te \
       bootanim.te \
       dnsmasq.te \
       recovery.te \
       device.te \
       zygote.te
