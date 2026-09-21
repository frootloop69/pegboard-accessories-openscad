# Changelog

## 2026-09-20

- Initialized project structure.
- Established 25.4 mm pegboard pitch.
- Rejected initial incorrect simple J-hook coupon geometry.
- Adopted proven curved upper retaining hook + lower straight locator architecture.
- Eureka: 5.5 mm peg diameter physically validated as a perfect fit.
- Spampur: 5.8 mm confirmed easy fit; 6.1/6.2 mm tests pending.
- Added V1 modular Eureka workspace driver station.
- Added measured interfaces for three fixed screwdrivers, full-size ratchet,
  Stanley stubby ratchet, and the full-size ratchet bit caddy.
- Added optional driver-station fit coupon and print-ready example files.

- Physical V1 driver fit coupon tested on actual tools: both ratchet holes fit
  and balance well; the original fixed-driver shaft openings fit but leave the
  drivers too top-heavy.
- Revised fixed-driver rack to closed 20.0 / 21.5 / 6.9 mm handle-support
  holes; lower shaft guide retained only as an optional fallback.

- Added an all-driver U-slot comparison coupon using the current
  20.0 / 21.5 / 6.9 / 30.0 / 33.0 mm support diameters; production holder
  geometry is intentionally unchanged pending physical test.

## 2026-09-21

- Physically tested the all-driver U-slot coupon; U-shaped supports work well
  for all five drivers.
- Increased the large Phillips support diameter from 20.0 mm to **22.0 mm**.
- Locked current support sizes at 22.0 / 21.5 / 6.9 / 30.0 / 33.0 mm.
- Switched the production fixed-driver rack, full-size ratchet holder, and
  Stanley stubby holder to front-loading U-shaped supports.
- Retained the lower long-driver guide only as an optional fallback.

- Refined the Stanley stubby production holder with semicircular U-arm
  endcaps and a parameterized 4 mm concave shelf-to-backplate root fillet.
  The validated 33.0 mm tool-support slot is unchanged.

- Added a parameterized **1.0 mm top-edge contact chamfer** to the inside of
  the Stanley stubby 33.0 mm U-slot. The validated straight-wall support
  diameter remains unchanged below the chamfer.

- Generalized U-holder finishing into `src/u_holder.scad`.
- Applied the shared root fillet and top-edge contact chamfer to the fixed
  driver rack, full-size ratchet holder, Stanley stubby holder, and optional
  long-driver lower guide.
- Standard defaults are 4.0 mm root fillet and 1.0 mm contact chamfer, with
  reduced chamfers for small/support-guide geometry where appropriate.

- Removed the large unused full-width shelf from the full-size ratchet/caddy
  holder. The ratchet now uses a localized **45 mm-wide** rounded U shelf,
  while the bit caddy keeps only its own pocket structure.
- Restricted the ratchet root fillet to the localized U support, eliminating
  the remaining material strip across the intentionally open region.

- Lowered the full-size ratchet bit-caddy pocket so its bottom surface aligns
  with the bottom surface of the ratchet U shelf.

- Shifted the full-size ratchet bit-caddy pocket inward so its outer side wall
  aligns with the outer edge of the backplate instead of protruding past it.
  Internal pocket width is unchanged.
- Made caddy side alignment automatic by default while retaining `caddy_y`
  as an optional manual override.

- Removed the separate rear wall from the full-size ratchet bit-caddy pocket.
  The common pegboard backplate now serves as the pocket rear wall directly.
- Preserved the 17.5 mm internal caddy depth while eliminating the redundant
  double-wall thickness.

- Reduced the bit-caddy front lip to **1.5 mm above the inside floor** so the
  protruding bits clear the pocket.
- Kept the compact 17.5 mm internal pocket depth instead of enlarging the
  pocket to ~29 mm.

- Added 4 mm convex fillets to the two exposed front/top edges of the
  full-size ratchet bit-caddy side walls.

- Established a repository-wide print-efficiency rule: where function permits,
  align the underside of accessory features with the bottom of the common
  pegboard backplate to eliminate unnecessary support gaps.
- Added reusable mount helpers for backplate-bottom Z, flush feature-top Z, and
  backplate side extent.
- Applied the rule to all current production accessories: fixed-driver rack,
  full-size ratchet/caddy holder, Stanley stubby holder, and optional
  long-driver lower guide.
- On the Eureka 25.4 mm / 5.5 mm preset, primary 6 mm shelves move down by
  4.15 mm so their underside is flush with the backplate bottom.

- Removed the legacy 90-degree side-print rotation from all current production
  Eureka accessory examples.
- Production exports now preserve horizontal shelves/U supports/pocket floors
  parallel to the slicer XY plane and translate the shared mount/accessory
  bottom exactly to Z=0.
- Established this as the repository-wide production print-axis rule to avoid
  stepped fill and poor bed contact from side-oriented geometry.
