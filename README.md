## vendor_tweaks

Small ROM tweaks kept out of upstream repos. Each ROM has its own branch:

| Branch | Tweaks |
|--------|--------|
| `crDroid-16.0` | Fast-skip boot animation |
| `lineageOS-24.0` | microG signature spoofing on user builds |
| `crDroid-17.0` | Fast-skip boot animation (via desc.txt patch), armv9-2a without SVE, camera power mode, Dolby Vision block model |

`crDroid-17.0` notes: microG spoofing is not needed (userdebug builds hit the
isDebuggable path) and the audioflinger Dolby patch is upstream now. The
SystemUI status/nav burn-in patch sits in `deferred/` until it is re-anchored on
the 17.0 sources. The boot animation lives in `vendor/addons` in 17.0 and its
generator is kept, so no `TARGET_BOOTANIMATION` zip is shipped here anymore.

The device tree wires this repo softly, so the build skips it if it is not synced:

    $(call inherit-product-if-exists, vendor/tweaks/tweaks.mk)
    -include vendor/tweaks/BoardConfig.mk

### Patches

`patches/<project path>/*.patch` are applied by `vendorsetup.sh` whenever
`build/envsetup.sh` is sourced. `repo sync` discards them, so re-source it after
syncing. Check the output for `FAILED to apply`.
