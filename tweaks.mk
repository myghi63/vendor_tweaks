# Product-scoped tweaks. Soft-inherited from the device device.mk.

# Pocket lock toggle app (repo optional; skipped if not synced).
$(call inherit-product-if-exists, vendor/pocketlock/pocket.mk)
