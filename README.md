## vendor_tweaks

Small ROM tweaks kept out of upstream repos. Each ROM has its own branch:

| Branch | Tweaks |
|--------|--------|
| `crDroid-16.0` | Fast-skip boot animation |
| `lineageOS-24.0` | no-IME-strip gestural overlay, burn-in protection |

The device tree wires this repo softly, so the build skips it if it is not synced:

    $(call inherit-product-if-exists, vendor/tweaks/tweaks.mk)
    -include vendor/tweaks/BoardConfig.mk

### Patches

`patches/<project path>/*.patch` are applied by `vendorsetup.sh` whenever
`build/envsetup.sh` is sourced. `repo sync` discards them, so re-source it after
syncing. Check the output for `FAILED to apply`.

Already-applied patches are skipped through a reverse-apply check, which only
probes the top of the stack. A series whose commits touch the same files must
therefore ship as one squashed patch (see the GameSpace fork's
`patches/frameworks/base/0001`), so re-running the hook is idempotent. Keep the
per-feature series elsewhere (e.g. ~/gamespace-work/patches/los/) for history
and bisecting.

## License

Apache-2.0 (`LICENSE`).

- `patches/frameworks/base/0001-SystemUI-Implement-burn-in-protection-...patch`:
  derives from Paranoid Android / FlamingoOS code (Apache-2.0, headers preserved in
  the patch content), inherited through crDroid.
- `patches/frameworks/base/0002-NavigationBarModeGesturalOverlay-...patch`, the
  vendorsetup hook and the mk wiring: original work under Apache-2.0.
