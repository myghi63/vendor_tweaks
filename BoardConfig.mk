# Board-level ROM tweaks. Included softly from a device BoardConfig with:
#
#     -include vendor/tweaks/BoardConfig.mk
#
# BoardConfig-scoped settings go here (things a product .mk cannot set, e.g.
# TARGET_BOOTANIMATION). Product-scoped tweaks live in tweaks.mk instead.

# Fast-skip boot animation.
#
# crDroid ships bootanimation desc.txt with every part flagged 'c'
# (play-until-complete), so when boot finishes (service.bootanim.exit=1) the
# looping part still finishes its current cycle and the outro part plays fully
# on top of an already-booted system. This zip is identical to the stock one
# except desc.txt flags every part 'p', so bootanimation breaks the instant
# boot completes -> the animation disappears as soon as the OS is ready.
#
# The lineage bootanimation genrule copies TARGET_BOOTANIMATION verbatim when
# set, so no regeneration happens. Guarded by wildcard so a partial checkout
# (BoardConfig fragment present, zip missing) does not point at a dead path.
ifneq ($(wildcard vendor/tweaks/bootanimation/bootanimation.zip),)
TARGET_BOOTANIMATION := vendor/tweaks/bootanimation/bootanimation.zip
endif
