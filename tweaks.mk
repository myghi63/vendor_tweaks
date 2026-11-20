# Product-scoped tweaks. Soft-inherited from the device device.mk.

# Static RRO that hides the empty strip the keyboard leaves above the gesture
# nav bar (config_imeDrawsImeNavBar=false, crDroid parity). Escape hatch
# without a rebuild: adb shell cmd overlay disable com.tweaks.overlay.imenavbarspace
PRODUCT_PACKAGES += ImeNavBarSpaceOverlay
