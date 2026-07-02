## vendor_tweaks

Small ROM tweaks kept out of the upstream crDroid/LineageOS repos, wired into a
device with two soft hooks so the repo stays optional.

### Wiring

In the device `device.mk` (product-scoped tweaks):

    $(call inherit-product-if-exists, vendor/tweaks/tweaks.mk)

In the device `BoardConfig.mk` (board-scoped tweaks):

    -include vendor/tweaks/BoardConfig.mk

Both are soft: if `vendor/tweaks` is not synced the build silently skips them.
Two hooks are needed because some settings (e.g. `TARGET_BOOTANIMATION`) are
BoardConfig variables and cannot be set from a product `.mk`.

### Current tweaks

| Tweak | Scope | File |
|-------|-------|------|
| Fast-skip boot animation | board | `BoardConfig.mk` + `bootanimation/bootanimation.zip` |

**Fast-skip boot animation** — crDroid's `desc.txt` flags every part `c`
(play-until-complete), so after boot completes the looping part finishes its
cycle and the outro plays fully on top of an already-booted system. This zip is
the stock animation with `desc.txt` flipped to `p` on every part, so
`bootanimation` exits the instant `service.bootanim.exit=1` is set at
boot-complete. `TARGET_BOOTANIMATION` makes the lineage genrule copy it verbatim.

To refresh after a crDroid bootanimation bump: rebuild once, take
`out/target/product/<device>/product/media/bootanimation.zip`, replace the
`desc.txt` inside (keep the first `w h fps` line, set every part line to `p`),
re-zip **stored** (`zip -0 -X`), and drop it here.
