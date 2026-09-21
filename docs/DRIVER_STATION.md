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

## V3 interfaces

### Fixed-driver rack

Physical testing showed that the larger handle-support geometry balances the
fixed drivers well, and that opening the supports into front-loading U slots
makes insertion/removal easier without sacrificing retention.

Current U-slot diameters:

- large Phillips: **22.0 mm** (increased from 20.0 mm after physical test)
- large flat-blade: **21.5 mm**
- small flat-blade: **6.9 mm**

The slots are straight-sided with **no top chamfer**. That is particularly
important for the small flat-blade, whose 7.5 mm handle leaves only a small
retaining shoulder over the 6.9 mm slot.

The separate lower guide for the two long drivers remains available as a
fallback, but is not expected to be needed if the production rack behaves like
the successful coupon.

### Full-size ratchet

- **30.0 mm U-slot**
- 6 mm shelf
- adjacent shallow pocket for the bit caddy

### Stanley stubby

- **33.0 mm U-slot**
- 6 mm shelf

Both ratchets remain supported by the handle/neck transition, but can now be
loaded from the front instead of requiring a vertical drop-through motion.

### Physical test results

**2026-09-20 — first fit coupon**

- full-size ratchet, 30 mm closed hole: fits and balances well
- Stanley stubby, 33 mm closed hole: fits and balances well
- original shaft-sized fixed-driver openings: dimensional fit was good, but
  all three fixed drivers were too top-heavy

**2026-09-21 — all-driver U-slot coupon**

- U-shaped support works well for all five drivers
- large flat-blade at 21.5 mm: accepted
- small flat-blade at 6.9 mm: accepted
- full-size ratchet at 30.0 mm: accepted
- Stanley stubby at 33.0 mm: accepted
- large Phillips at 20.0 mm: functional but should be enlarged by 2 mm
- production large-Phillips slot therefore set to **22.0 mm**

This result established the V3 production geometry: U-shaped supports for all
five drivers.

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

The support concept is now physically validated. The next useful test is the
actual pegboard-mounted production parts:

1. Print the V3 fixed-driver rack.
2. Confirm that the 22.0 mm large-Phillips slot gives the intended extra
   clearance.
3. Print the full-size ratchet + bit-caddy module.
4. Print the stubby module.
5. Add the lower long-driver guide only if real pegboard use shows that either
   long driver swings excessively.

All parts should be printed at 100% scale. PETG is preferred for the final
working parts; PLA is acceptable for fit checks.


## U-slot comparison test

A second calibration coupon is available at:

- `calibration/driver_station_u_slot_coupon.scad`

It tests the same U-shaped support concept used by the production holders:

- 22.0 mm — large Phillips
- 21.5 mm — large flat-blade
- 6.9 mm — small flat-blade
- 30.0 mm — full-size ratchet
- 33.0 mm — Stanley stubby

The slots have straight sides and no entry chamfer. The U-slot concept has now
been physically validated; the coupon remains useful for future printer/material
fit checks.


## Stubby holder edge treatment

The Stanley stubby production holder now adds two geometry refinements without
changing the validated 33.0 mm U-slot:

- **Semicircular front endcaps** on both U arms. By default the radius is half
  the arm width, so each arm terminates in a true rounded nose.
- **4 mm concave root fillet** where the horizontal U shelf meets the vertical
  pegboard mounting plate.

Both are parameterized in `stubby_ratchet_holder()` as `front_cap_r` and
`root_fillet_r`. The rounded ends are primarily ergonomic/aesthetic; the root
fillet also reduces the stress concentration at the cantilevered shelf joint.
