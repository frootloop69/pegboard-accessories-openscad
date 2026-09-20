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

## V1 interfaces

### Fixed-driver rack

Open-front U-slots:

- large Phillips: 6.7 mm
- large flat-blade: 8.0 mm
- small flat-blade: 2.8 mm

The two long drivers have a separate optional lower guide. Install the lower
guide on the same pegboard columns, nominally two grid rows (50.8 mm) below
the upper rack.

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

1. Render and print `calibration/driver_station_fit_coupon.scad` if you want
   to verify the 30/33 mm ratchet holes and the three U-slot clearances with
   minimal filament.
2. Print the fixed-driver rack and confirm one-handed insertion/removal.
3. Install the lower guide only if the long drivers benefit from additional
   stabilization.
4. Print the ratchet/caddy module.
5. Print the stubby module.

All parts should be printed at 100% scale. PETG is preferred for the final
working parts; PLA is acceptable for fit checks.
