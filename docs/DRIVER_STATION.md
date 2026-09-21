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


## Stubby U-slot contact chamfer

The Stanley stubby holder now has a **1.0 mm 45-degree top-edge chamfer** on
the inside of the 33.0 mm U-slot where the handle rests.

The chamfer is parameterized as `contact_chamfer` in
`stubby_ratchet_holder()`. The 33.0 mm straight-wall support diameter remains
unchanged below the chamfer, so the validated retention geometry is preserved
while the contact edge is less sharp against the handle.


## Reusable U-holder finish system

The U-holder finishing geometry is now factored into the shared library
`src/u_holder.scad`, so future pegboard accessories can use the same design
language without copying driver-specific code.

Reusable primitives:

- `u_holder_slot_cut()` — open U support
- `u_holder_top_chamfer_cut()` — top inside contact chamfer
- `u_holder_root_fillet()` — concave shelf/backplate root fillet
- `u_holder_rounded_single_shelf()` — single-U shelf with rounded arm ends

Driver-station defaults:

- root fillet: **4.0 mm**
- normal contact chamfer: **1.0 mm**
- small-tool contact chamfer: **0.25 mm**
- optional long-driver lower guide chamfer: **0.5 mm**

The fixed-driver rack, full-size ratchet holder, Stanley stubby holder, and
optional long-driver lower guide now all expose/use the shared fillet and
contact-chamfer system.


## Full-size ratchet material reduction

The full-size ratchet/caddy module no longer uses a 107 mm-wide solid shelf.
The ratchet now has a **45 mm-wide localized U support** centered on the
validated 30 mm slot, while the bit caddy retains only its own pocket floor and
walls.

This removes the large unused slab between/beneath the two functions while
preserving:

- 30.0 mm ratchet U-slot
- 1.0 mm top contact chamfer
- rounded U-arm ends
- 4.0 mm root fillet behind the ratchet support
- the existing bit-caddy pocket geometry

The ratchet U and bit caddy are both attached independently to the common
pegboard backplate.


## Bit-caddy vertical alignment

The full-size ratchet bit-caddy pocket is now lowered so the **underside of its
bottom floor aligns with the underside of the ratchet U shelf**. With the
current defaults this means the 3 mm caddy floor and 6 mm ratchet shelf share
the same bottom Z plane, giving the combined module a cleaner lower edge.


## Bit-caddy side alignment

The full-size ratchet bit-caddy pocket now auto-aligns its outer side wall with
the outer edge of the 5-column pegboard backplate. The pocket is shifted toward
the ratchet U rather than narrowed, so the full **50.5 mm internal width** and
3 mm walls are preserved.

The default `caddy_y` is now `undef`, which enables automatic alignment.
Supplying an explicit `caddy_y` still overrides the calculated position.


## Bit-caddy rear-wall merge

The bit-caddy pocket no longer has a separate rear wall. The common pegboard
mounting backplate now forms the rear wall of the pocket directly.

The pocket keeps the same **17.5 mm internal depth** by shifting the front lip,
floor, and side walls toward the backplate. Those parts overlap the backplate by
a small epsilon for a robust OpenSCAD union, but there is no longer a doubled
3 mm wall at the rear.


## Bit-caddy front-lip clearance

The full-size ratchet bit-caddy pocket now limits the front lip to **1.5 mm
above the inside floor**. This is the maximum clearance that still lets the
protruding bits fit without interference.

The pocket therefore remains at the compact **17.5 mm internal front-to-back
depth** rather than being enlarged to roughly 29 mm. If a deeper capture is
ever preferred, the alternative is to increase `inner_d` to about 29 mm and
use a taller front lip.


## Bit-caddy side-wall fillets

The two exposed front/top edges of the bit-caddy side walls now use a
**4 mm convex fillet**. The fillet is applied in the side-wall X/Z profile,
so it rounds the sharp free-end edges marked in the design review without
changing the pocket's internal width.

The radius is exposed as `caddy_side_fillet_r` in
`full_ratchet_with_bits()`.
