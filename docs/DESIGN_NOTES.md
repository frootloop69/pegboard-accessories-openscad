# Mount design notes

The mount is intentionally split into two mechanical functions:

1. **Upper retaining hook**
   - enters the pegboard hole during insertion;
   - curved retaining section captures the rear of the board;
   - accessory is seated by the normal hook/rotate-down motion.

2. **Lower straight locator**
   - registers to the next pegboard row;
   - prevents rotation and lateral movement;
   - is not intended to provide the primary retention.

All tool holders should consume this mount interface rather than creating their own peg geometry.

## Current empirical geometry

```text
hole pitch              25.4 mm
hook offset              4.5 mm
hook neck                0.5 mm
reference board geometry 5.0 mm
```

Peg diameter is board-specific.

## Calibration principle

Change one mounting variable at a time where practical. Once a board preset is physically validated, treat the printed fit result as authoritative over nominal manufacturer dimensions.


## Print-efficient bottom-alignment rule

For production pegboard accessories, **align the lowest practical front
feature with the bottom edge of the common pegboard backplate**.

In the normal print orientation this gives the backplate and accessory feature
a shared build-plane edge, avoiding an unnecessary air gap and the support
material that gap would require.

The shared mount library exposes:

- `pegboard_mount_bottom_z(pitch, peg_d)` — installed Z coordinate of the
  backplate lower edge.
- `pegboard_feature_top_z(thickness, pitch, peg_d)` — top Z for a horizontal
  feature whose underside should align with that lower edge.
- `pegboard_mount_outer_half_width(columns, pitch, peg_d)` — common plate
  side extent for accessory side-wall alignment.

### Rule

Use `pegboard_feature_top_z()` by default for shelves, U supports, pockets,
trays, and similar cantilevered front features **unless a functional or
mechanical requirement explicitly needs a different vertical position**.

Do not trim or alter the physically validated pegboard hook/locator geometry
merely to improve print orientation. Move accessory geometry to the mount
reference plane instead.
