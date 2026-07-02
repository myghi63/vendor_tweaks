# Product-level ROM tweaks. Soft-inherited from a device.mk with:
#
#     $(call inherit-product-if-exists, vendor/tweaks/tweaks.mk)
#
# Product-scoped tweaks go here: PRODUCT_PROPERTY_OVERRIDES,
# PRODUCT_COPY_FILES, overlays, sysconfig, extra packages, etc.
# Board-scoped tweaks (e.g. TARGET_BOOTANIMATION) live in BoardConfig.mk,
# which the device BoardConfig includes separately.
#
# Nothing here yet -- the first tweak (fast-skip boot animation) is
# board-level. Add product tweaks below as they come up.
