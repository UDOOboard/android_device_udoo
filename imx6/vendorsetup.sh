add_lunch_combo a62_6dq-eng
add_lunch_combo a62_6dq-user

add_lunch_combo udoo_6dq-eng
add_lunch_combo udoo_6dq-user

add_lunch_combo udooneo_6sx-eng
add_lunch_combo udooneo_6sx-user

# Must fix ... a bad solution to avoid conflict between Bluedroid and Bluez
if [ `grep -c TARGET_BUILD_BLUEZ external/bluetooth/bluez/android/Android.mk` -eq 0 ]
  then
     echo '#' > /tmp/Android_bluetoot.mk
     echo '# Warn! Changed by device/udoo/imx6/vendorsetup.sh script ' >> /tmp/Android_bluetoot.mk
     echo '#' >> /tmp/Android_bluetoot.mk
     echo '' >> /tmp/Android_bluetoot.mk
     echo 'ifeq ($(TARGET_BUILD_BLUEZ),true)' >> /tmp/Android_bluetoot.mk
     echo '' >> /tmp/Android_bluetoot.mk
     cat external/bluetooth/bluez/android/Android.mk >> /tmp/Android_bluetoot.mk
     echo '' >> /tmp/Android_bluetoot.mk
     echo 'endif # ($(TARGET_BUILD_BLUEZ),true)' >> /tmp/Android_bluetoot.mk

     mv /tmp/Android_bluetoot.mk external/bluetooth/bluez/android/Android.mk
fi
# Must fix ... a bad solution to avoid conflict between Bluedroid and Bluez


