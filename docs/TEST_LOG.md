# Calibration test log

## 2026-09-20

### Eureka workspace board

| Test | Result |
|---|---|
| 5.8 mm | Too large |
| 5.5 mm | Fits perfectly |

**Decision:** lock `EUREKA_WORKSPACE.peg_diameter = 5.5 mm`.

### Spampur printer-shelf board

| Test | Result |
|---|---|
| 5.8 mm | Fits easily; diameter can increase |
| 6.2 mm | Still loose |
| 6.8 mm | Pending |
| 6.9 mm | Pending |
| 7.0 mm | Pending |

**Decision:** keep Spampur diameter provisional. The useful fit range is clearly larger than initially expected, so the next bracket is 6.8–7.0 mm.


## 2026-09-21

### Eureka workspace board — Creality Hyper PLA

Print orientation: repository-standard axis-aligned production orientation.

| Test | Result |
|---|---|
| 5.2 mm | **Validated fit** |

**Decision:** for Creality Hyper PLA in the standard production orientation,
set the current Eureka production default to
`EUREKA_WORKSPACE.peg_diameter = 5.2 mm`.

The earlier 5.5 mm result remains a valid historical calibration for the
previous filament/process; peg diameter is therefore tracked as
material/process-sensitive.
