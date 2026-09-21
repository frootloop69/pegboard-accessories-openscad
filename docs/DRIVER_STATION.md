# Eureka workspace driver station

## Purpose

A modular driver station for the electronics/retro-computing workbench. The
station uses the physically validated `EUREKA_WORKSPACE` pegboard mount
(25.4 mm pitch, 5.5 mm peg diameter).

The design is intentionally split into independent modules so a single tool
can be changed without reprinting the entire station.

## Tool measurements

| Tool | Shaft / neck | Handle | Overall length |
|---|---:|---:|---:|
| Large Phillips | shaft 5.9 mm; neck 10.45 mm | 26.5 mm dia | 230 mm |
| Large flat-blade | shaft 7.2 mm; neck 17.2 mm | 28.65 mm dia | 200 mm |
| Small flat-blade | shaft 2.0 mm; neck 6.99 mm | 7.5 mm dia | 85.03 mm |
| Full-size ratchet | neck 27.26 mm | 32.46 mm dia; 104.10 mm handle length | 160 mm |
| Stanley stubby ratchet | neck 27.33 mm | 39.69 mm dia; 87.83 mm handle length | 104.65 mm |

Full-size ratchet bit caddy:

- height: 69.9 mm
- width: 48.9 mm
- body depth: 15.98 mm
- bits protrude approximately 13 mm beyond the body depth

## V2 interfaces

### Fixed-driver rack

The first physical coupon confirmed that the original shaft-sized openings fit,
but the three fixed drivers sat too high and were top-heavy. V2 changes the
upper rack to closed circular drop-through holes so each tool settles farther
into its handle/neck transition, using the same balance principle as the
ratcheting drivers.

Current hole diameters:

- large Phillips: **20.0 mm**
- large flat-blade: **21.5 mm**
- small flat-blade: **6.9 mm**

These three holes are deliberately straight-sided with **no top chamfer**.
That preserves the small retaining shoulder on the 7.5 mm small-flat handle.

The separate lower guide for the two long drivers remains available as a
fallback, but it is no longer expected to be necessary if the V2 support-hole
geometry balances the tools as intended.

### Full-size ratchet

- 30.0 mm circular drop-through hole
- 6 mm shelf
- small 0.4 mm entry edge break
- adjacent shallow pocket for the bit caddy

### Stanley stubby

- 33.0 mm circular drop-through hole
- 6 mm shelf
- small 0.4 mm entry edge break

The simple drop-through geometry is deliberate: the handles are wider than
their necks and therefore form their own retaining shoulder.

### Physical test result — 2026-09-20

The first fit coupon was tested on the actual tools:

- full-size ratchet, 30 mm hole: fits and balances well
- Stanley stubby, 33 mm hole: fits and balances well
- original fixed-driver shaft openings: dimensional fit was good, but all
  three fixed drivers were too top-heavy

This test directly drove the V2 fixed-driver hole sizes above.

## Source files

Reusable modules:

- `src/driver_station.scad`

Print-ready Eureka examples:

- `examples/eureka_fixed_driver_rack.scad`
- `examples/eureka_long_driver_lower_guide.scad`
- `examples/eureka_full_ratchet_with_bits.scad`
- `examples/eureka_stubby_ratchet.scad`

Optional local-clearance test:

- `calibration/driver_station_fit_coupon.scad`

## Suggested validation sequence

1. Print the updated `calibration/driver_station_fit_coupon.scad` to verify
   the new 20.0 / 21.5 / 6.9 mm fixed-driver support holes.
2. Confirm that all three fixed drivers now settle lower and balance by their
   handles/handle transitions.
3. Print the fixed-driver rack.
4. Add the lower guide only if either long driver still swings excessively.
5. The 30 mm full-size-ratchet and 33 mm stubby interfaces are already
   physically confirmed to fit and balance well.

All parts should be printed at 100% scale. PETG is preferred for the final
working parts; PLA is acceptable for fit checks.
