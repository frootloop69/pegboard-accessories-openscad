# Board presets

## `EUREKA_WORKSPACE`

Status: **validated**

```text
pitch              = 25.4 mm
peg_diameter       = 5.2 mm
hook_offset        = 4.5 mm
hook_neck          = 0.5 mm
board_geom         = 5.0 mm
```

Current production calibration: **5.2 mm**, physically tested with Creality
Hyper PLA in the repository-standard axis-aligned print orientation.

Historical result: 5.5 mm fit perfectly with the earlier filament/process.
Treat peg diameter as printer/material/process-sensitive rather than a purely
board-specific nominal dimension.

## `SPAMPUR_PRINTER`

Status: **calibration in progress**

```text
pitch              = 25.4 mm
peg_diameter       = TBD
hook_offset        = 4.5 mm
hook_neck          = 0.5 mm
board_geom         = 5.0 mm
```

Known results:
- 5.8 mm fits easily.
- 6.2 mm is still loose.
- 6.8 mm coupon generated; test pending.
- 6.9 mm coupon generated; test pending.
- 7.0 mm coupon generated; test pending.

Do not lock the Spampur diameter until the physical tests are complete.
