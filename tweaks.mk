# Product-scoped tweaks. Soft-inherited from the device device.mk.

# Static RRO (isStatic) that hides the empty strip the keyboard leaves above
# the gesture nav bar (config_imeDrawsImeNavBar=false, crDroid parity).
# isStatic = immutable + default-enabled at boot (OverlayConfig); no runtime
# toggle. To undo: remove the overlay from PRODUCT_PACKAGES and rebuild.
PRODUCT_PACKAGES += ImeNavBarSpaceOverlay
