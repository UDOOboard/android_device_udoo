#
# Product-specific compile-time definitions.
#

include device/udoo/imx6/soc/imx6dq.mk
include device/udoo/a62_6dq/build_id.mk
include device/udoo/imx6/BoardConfigCommon.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk
# a62_6dq default target for EXT4
BUILD_TARGET_FS ?= ext4
include device/udoo/imx6/imx6_target_fs.mk

ifeq ($(BUILD_TARGET_DEVICE),sd)
ADDITIONAL_BUILD_PROPERTIES += \
                        ro.boot.storage_type=sd
ifneq ($(BUILD_TARGET_FS),f2fs)
TARGET_RECOVERY_FSTAB = device/udoo/a62_6dq/fstab_sd.freescale
# build for ext4
PRODUCT_COPY_FILES +=	\
	device/udoo/a62_6dq/fstab_sd.freescale:root/fstab.freescale
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

BOARD_WLAN_DEVICE                        := rt5370
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
# BOARD_HOSTAPD_DRIVER                   := NL80211
# WIFI_DRIVER_STATE_CTRL_PARAM             := false
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_RALINK  := lib_driver_cmd_ralink

#  BOARD_MODEM_VENDOR := AMAZON

USE_ATHR_GPS_HARDWARE := false
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := false
SENSOR_MMA8451 := false

# for recovery service
TARGET_SELECT_KEY := 28

# we don't support sparse image.
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
DM_VERITY_RUNTIME_CONFIG := true
# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true


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

# BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:off video=mxcfb2:off video=mxcfb3:off vmalloc=400M androidboot.console=ttymxc0 consoleblank=0 androidboot.hardware=freescale cma=384M /*original*/

# Bootargs for different video outputs - LVDS and HDMI, to uncomment here below 
# or to set it up as the environment variables from the U-Boot command line.
 
BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:dev=hdmi,1920x1080M@60,bpp=32 video=mxcfb2:off video=mxcfb3:off vmalloc=400M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend cma=384M 

# BOARD_KERNEL_CMDLINE := console=ttymxc1,115200 init=/init video=mxcfb0:dev=ldb,bpp=32 video=mxcfb1:off video=mxcfb2:off video=mxcfb3:off vmalloc=400M androidboot.console=ttymxc1 consoleblank=0 androidboot.hardware=freescale cma=384M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

#BOARD_KERNEL_CMDLINE := setenv bootargs console=ttymxc1,115200 androidboot.console=ttymxc1 consoleblank=0 vmalloc=400M init=/init video=mxcfb0:dev=hdmi,1920x1080M@60,bpp=32 video=mxcfb1:off video=mxcfb2:off video=mxcfb3:off androidboot.hardware=freescale cma=384M androidboot.selinux=disabled androidboot.dm_verity=disabled no_console_suspend

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
# Note: this NAND partition table must align with MFGTool's config.
BOARD_KERNEL_CMDLINE +=  mtdparts=gpmi-nand:16m(bootloader),16m(bootimg),128m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

# Bluedroid bluetooth support, uncomment below to apply

BOARD_HAVE_BLUETOOTH        	:= true
BOARD_HAVE_BLUETOOTH_USB        := true
BLUETOOTH_HCI_USE_USB 		:= true
# BOARD_HAVE_BLUETOOTH_BCM        := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL     := true
BLUETOOTH_HCI_USE_MCT                   := false
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/udoo/a62_6dq/bluetooth


USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true

# camera hal v2
IMX_CAMERA_HAL_V2 := false

#define consumer IR HAL support
IMX6_CONSUMER_IR_HAL := false

TARGET_UBOOT_VERSION := uboot-imx
TARGET_BOOTLOADER_CONFIG := imx6q:mx6qd_a62_android_defconfig imx6dl:mx6dl_a62_android_defconfig
TARGET_KERNEL_VERSION := kernel_imx
TARGET_KERNEL_DEFCONF := imx_v7_android_A62_defconfig
TARGET_BOARD_DTS_CONFIG := imx6q:imx6q-seco_A62.dtb imx6dl:imx6dl-seco_A62.dtb
#   TARGET_BOOTLOADER_ENV := DDR_SIZE=2 DDR_TYPE=1 BOARD_TYPE=A62 CPU_TYPE=DUAL_LITE ENV_DEVICE=ENV_SPI OPT_UART= OPT_SERIAL_DEBUG= OPT_RTC= OPT_RTC_EXT=


BOARD_SEPOLICY_DIRS := \
       device/udoo/imx6/sepolicy \
       device/udoo/a62_6dq/sepolicy

BOARD_SEPOLICY_UNION := \
       domain.te \
       system_app.te \
       system_server.te \
       untrusted_app.te \
       sensors.te \
       init_shell.te \
       bluetooth.te \
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


