# Pegboard Accessories OpenSCAD

Parametric OpenSCAD tooling for designing 3D-printable pegboard accessories for the workshop and 3D-printer racks.

## Project goals

- One reusable pegboard mounting interface per physical board type.
- Calibrate the mounting interface on real hardware before building tool holders.
- Keep tool-holder geometry separate from pegboard mounting geometry.
- Generate holders from measurable dimensions rather than hand-editing STLs.
- Maintain physical test results and hardware presets in source control.

## Current hardware presets

| Preset | Pitch | Peg diameter | Status |
|---|---:|---:|---|
| `EUREKA_WORKSPACE` | 25.4 mm | **5.5 mm** | Physically validated; fits perfectly |
| `SPAMPUR_PRINTER` | 25.4 mm | TBD | 5.8 mm fits easily; 6.1/6.2 mm calibration pending |

Common retained geometry:

- hook offset: 4.5 mm
- hook neck: 0.5 mm
- reference `board_thickness` geometry parameter: 5.0 mm

The 5.0 mm value is an empirical geometry parameter inherited from the proven reference design; it is **not** a statement that the metal pegboard sheet is physically 5 mm thick.

## Repository layout

- `src/` — reusable parametric OpenSCAD modules and board presets
- `calibration/` — source for physical fit-test coupons
- `examples/` — tool-holder examples built on the common mount interface
- `docs/` — board presets, test results, design notes, and third-party references

Generated STL files are intentionally not tracked. Render them from the corresponding `.scad` source so the source remains authoritative.

## Development rule

**Do not build tool-specific holders on an unvalidated mount.**

Mount calibration is authoritative: dimensions are updated from actual printed fit tests on the physical boards.

## Current calibration state

### Eureka workspace pegboard
- 5.8 mm: too large
- **5.5 mm: fits perfectly**
- Current default: **5.5 mm**

### Spampur printer-rack pegboard
- 5.8 mm: fits easily / has room to increase
- 6.1 mm: pending test
- 6.2 mm: pending test
- Current default: **not yet locked**

## OpenSCAD

The project is intended to work with the normal OpenSCAD desktop application. Generated calibration parts should always be printed at 100% scale.

## Current accessories

### Eureka workspace driver station

The first production accessory is a modular electronics-workbench driver
station. It includes:

- three-hole handle-support screwdriver rack
- optional lower guide for the two long drivers (fallback)
- full-size ratchet drop-through holder with adjacent bit-caddy pocket
- Stanley stubby ratchet drop-through holder

Measured tool dimensions, physical test results, and V2 clearances are documented in
`docs/DRIVER_STATION.md`.
