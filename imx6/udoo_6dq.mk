$(call inherit-product, device/udoo/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

ifneq ($(wildcard device/udoo/udoo_6dq/fstab.freescale),)
$(shell touch device/udoo/udoo_6dq/fstab.freescale)
endif

# Overrides
PRODUCT_NAME := udoo_6dq
PRODUCT_DEVICE := udoo_6dq

PRODUCT_COPY_FILES += \
        device/udoo/common/tools/expand-data.zip:system/expand-data.zip \
	device/udoo/imx6/init.i.MX6Q.rc:root/init.freescale.i.MX6Q.rc \
	device/udoo/imx6/init.i.MX6DL.rc:root/init.freescale.i.MX6DL.rc \
	device/udoo/udoo_6dq/init.rc:root/init.freescale.rc \
	device/udoo/udoo_6dq/init.bluetooth.rc:root/init.bluetooth.rc \
	device/udoo/udoo_6dq/audio_policy.conf:system/etc/audio_policy.conf \
	device/udoo/udoo_6dq/audio_effects.conf:system/vendor/etc/audio_effects.conf
	
PRODUCT_COPY_FILES +=	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6d.bin:system/lib/firmware/vpu/vpu_fw_imx6d.bin 	\
	external/linux-firmware-imx/firmware/vpu/vpu_fw_imx6q.bin:system/lib/firmware/vpu/vpu_fw_imx6q.bin

# setup dm-verity configs.
 PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/mmcblk0p5
 $(call inherit-product, build/target/product/verity.mk)

PRODUCT_PACKAGES += \
	AudioRoute      \
	Camera2         \
	camera.imx6     \
	libglib         \
	libusb          \
	libbt-vendor

DEVICE_PACKAGE_OVERLAYS := device/udoo/udoo_6dq/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml
