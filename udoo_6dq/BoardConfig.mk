include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/udoo_6dq/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# udoo_6dq default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ADDITIONAL_BUILD_PROPERTIES += \
	ro.boot.storage_type=sd
TARGET_RECOVERY_FSTAB = device/udoo/udoo_6dq/fstab_sd.freescale
PRODUCT_COPY_FILES +=	\
	device/udoo/udoo_6dq/fstab_sd.freescale:root/fstab.freescale

ADDITIONAL_BUILD_PROPERTIES += \
	persist.udoo_enable_adk=false

TARGET_BOOTLOADER_BOARD_NAME := UDOO
PRODUCT_MODEL := UDOO-MX6DQ

TARGET_RELEASETOOLS_EXTENSIONS := device/udoo/imx6

BOARD_WLAN_DEVICE                        := RALINK
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
# WIFI_DRIVER_STATE_CTRL_PARAM             := false
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RALINK  := lib_driver_cmd_ralink


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
UBI_ROOT_INI := device/udoo/udoo_6dq/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
ifeq ($(TARGET_USERIMAGES_USE_EXT4),true)
$(error "TARGET_USERIMAGES_USE_UBIFS and TARGET_USERIMAGES_USE_EXT4 config open in same time, please only choose one target file system image")
endif
endif

BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init vmalloc=256M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=256M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif


BOARD_HAVE_BLUETOOTH        	:= true
BOARD_HAVE_BLUETOOTH_USB        := true
BLUETOOTH_HCI_USE_USB 		:= true

BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL     := true
BLUETOOTH_HCI_USE_MCT                   := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/udoo_6dq/bluetooth


USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v3
IMX_CAMERA_HAL_V3 := true

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := false

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6q:udoo_qd_android_config imx6dl:udoo_qd_android_config
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-udoo-hdmi.dtb imx6dl:imx6dl-udoo-hdmi.dtb

TARGET_KERNEL_VERSION := kernel_imx
TARGET_KERNEL_DEFCONF := udoo_quad_dual_android_defconfig
TARGET_KERNEL_MODULES += \
	arch/arm/boot/dts/imx6dl-udoo-hdmi.dtb:system/dts/imx6dl-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds7.dtb:system/dts/imx6dl-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6dl-udoo-lvds15.dtb:system/dts/imx6dl-udoo-lvds15.dtb \
	arch/arm/boot/dts/imx6q-udoo-hdmi.dtb:system/dts/imx6q-udoo-hdmi.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds7.dtb:system/dts/imx6q-udoo-lvds7.dtb \
	arch/arm/boot/dts/imx6q-udoo-lvds15.dtb:system/dts/imx6q-udoo-lvds15.dtb \

PRODUCT_COPY_FILES +=	\
	device/udoo/udoo_6dq/uEnv.txt:system/uEnv.txt \
	device/udoo/udoo_6dq/verifyuenv:system/bin/verifyuenv \
	device/udoo/udoo_6dq/enableadk:system/bin/enableadk


BOARD_SEPOLICY_DIRS := \
	device/udoo/imx6/sepolicy \
	device/udoo/udoo_6dq/sepolicy

