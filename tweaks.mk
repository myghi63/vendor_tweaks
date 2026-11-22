# Product-scoped tweaks. Soft-inherited from the device device.mk.

# Currently no PRODUCT_PACKAGES tweaks live here.
# The "hide space under keyboard" (IME nav bar strip) tweak is done in
# patches/frameworks/base/0003-* (gestural overlay flips config_imeDrawsImeNavBar
# to false) instead of a RRO: runtime-enabled overlays (e.g. the gestural one,
# bumped to MAX priority when picked in Settings) always outrank static RROs.
