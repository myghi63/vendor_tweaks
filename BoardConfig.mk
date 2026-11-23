# Board-scoped tweaks. Included softly from the device BoardConfig.mk.

# Recovery behaves like userdebug even in a user build: append the three
# variant props at the END of the recovery ramdisk's prop.default. The hook
# runs last in the ramdisk assembly (build/make/core/Makefile, rule of
# INTERNAL_RECOVERY_RAMDISK_FILES_TIMESTAMP) and prop loading keeps the LAST
# occurrence (system/core/init/property_service.cpp), so these outrank the
# variant props written earlier. /prop.default is only read in recovery mode
# (IsRecoveryMode), so the running system stays a plain user build.
# Effect in recovery: "Install anyway?" on signature failure, downgrade/SPL
# prompts, Mount /system, Enable ADB, adb_keys copy + adb root, auto adbd and
# console. The SELinux policy still follows the build variant (user).
# Kati expands variable values at definition time (no deferred re-expansion),
# and TARGET_RECOVERY_ROOT_OUT only exists later in envsetup.mk (1022): the
# path is spelled from PRODUCT_OUT + TARGET_COPY_OUT_RECOVERY, both already
# defined when the device BoardConfig is parsed (envsetup.mk:364/267). Plain
# echo commands keep the value free of backslashes and shell $ so no
# expansion pass can mangle it.
BOARD_RECOVERY_IMAGE_PREPARE := echo ro.build.type=userdebug >> $(PRODUCT_OUT)/$(TARGET_COPY_OUT_RECOVERY)/root/prop.default && echo ro.debuggable=1 >> $(PRODUCT_OUT)/$(TARGET_COPY_OUT_RECOVERY)/root/prop.default && echo ro.adb.secure=0 >> $(PRODUCT_OUT)/$(TARGET_COPY_OUT_RECOVERY)/root/prop.default
