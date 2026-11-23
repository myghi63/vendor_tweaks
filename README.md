## vendor_tweaks

Small ROM tweaks kept out of upstream repos. Each ROM has its own branch:

| Branch | Tweaks |
|--------|--------|
| `crDroid-16.0` | Fast-skip boot animation |
| `lineageOS-24.0` | no-IME-strip gestural overlay, burn-in protection, Cloudflare connectivity probes, userdebug-behaving recovery |

### Cloudflare connectivity probes (`overlay/NetworkStackCaptivePortalOverlay`)

Static RRO (priority 150, target `com.android.networkstack` / `NetworkStackConfig`)
replacing the Google probes: captive portal HTTP/HTTPS `cp.cloudflare.com/generate_204`,
fallbacks Cloudflare + `connectivity-check.ubuntu.com`, DHCP-fallback DNS `1.1.1.1`/`1.0.0.1`.
Only HTTP 204 counts as "no portal"; the endpoints were verified 2026-11-23
(`one.one.one.one/generate_204` is 404 — do not use it as a probe URL).

Notes:
- A static RRO outranks the `Settings.Global captive_portal_*` keys, so
  `settings put global captive_portal_http_url ...` stops having effect; undo is
  removing the package, not the setting.
- Private DNS (Settings → Private DNS) has no resource hook; for Cloudflare DoT
  use hostname `one.one.one.one` (verified on port 853; `dns.cloudflare.com` is
  not a DoT endpoint). Opportunistic mode (the default) is the safe one: strict
  breaks on networks that block port 853.

### Recovery behaves like userdebug (`BoardConfig.mk`)

`BOARD_RECOVERY_IMAGE_PREPARE` appends `ro.build.type=userdebug`,
`ro.debuggable=1`, `ro.adb.secure=0` to the recovery ramdisk's `prop.default`,
which is only read in recovery mode — the system stays a plain `user` build.
In recovery this re-enables "Install anyway?" on foreign zip signatures,
downgrade/SPL prompts, Mount /system, Enable ADB, adb_keys + adb root and the
console; sideloading the ROM zip keeps it consistent because the recovery.img
inside the zip already carries these props (unlike rebuilding the recovery
separately, which the next ROM sideload would overwrite). The SELinux policy
still follows the build variant (user).

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
