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
