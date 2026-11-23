# Product-scoped tweaks. Soft-inherited from the device device.mk.

# The "hide space under keyboard" (IME nav bar strip) tweak is done in
# patches/frameworks/base/0002-* (gestural overlay flips config_imeDrawsImeNavBar
# to false) instead of a RRO: runtime-enabled overlays (e.g. the gestural one,
# bumped to MAX priority when picked in Settings) always outrank static RROs.

# Connectivity probes (captive portal + DHCP-fallback DNS) on Cloudflare
# instead of Google. Static RRO on the NetworkStack mainline config; priority
# 150 outranks Lineage's NetworkStackOverlay (100, dhcp hostname only).
PRODUCT_PACKAGES += NetworkStackCaptivePortalOverlay
