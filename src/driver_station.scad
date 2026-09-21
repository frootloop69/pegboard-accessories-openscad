/*
  Modular electronics-workspace driver station.
  Units: mm.

  Installed-coordinate convention inherited from mount.scad:
    - pegboard plane is approximately the Y/Z plane
    - accessory projects toward negative X
    - tools hang toward negative Z

  V3 uses open U-shaped handle-support slots for all primary drivers:
    - side-load U slots for the three fixed screwdrivers
    - optional lower shaft guide retained as a fallback for the two long drivers
    - side-load U slots for both ratcheting drivers
    - shallow lower pocket for the full-size ratchet bit caddy
*/

use <mount.scad>
use <u_holder.scad>

// Empirical front face chosen to overlap the proven mount plate without
// pushing accessory geometry into the board.
DS_FACE_X = -4.0;
// Legacy/default top Z for low-level helpers. Production accessory modules
// compute their own top Z from pegboard_feature_top_z() so their underside
// aligns with the mount backplate bottom for support-efficient printing.
DS_SHELF_TOP_Z = -18.0;
DS_EPS = 0.15;

// Tool measurements supplied 2026-09-20.
LARGE_PH_SHAFT_D = 5.9;
LARGE_PH_NECK_D = 10.45;
LARGE_PH_HANDLE_D = 26.5;
LARGE_PH_LENGTH = 230;

LARGE_FLAT_SHAFT_D = 7.2;
LARGE_FLAT_NECK_D = 17.2;
LARGE_FLAT_HANDLE_D = 28.65;
LARGE_FLAT_LENGTH = 200;

SMALL_FLAT_SHAFT_D = 2.0;
SMALL_FLAT_NECK_D = 6.99;
SMALL_FLAT_HANDLE_D = 7.5;
SMALL_FLAT_LENGTH = 85.03;

FULL_RATCHET_HANDLE_D = 32.46;
FULL_RATCHET_HANDLE_LENGTH = 104.10;
FULL_RATCHET_NECK_D = 27.26;
FULL_RATCHET_LENGTH = 160;

STUBBY_HANDLE_D = 39.69;
STUBBY_HANDLE_LENGTH = 87.83;
STUBBY_NECK_D = 27.33;
STUBBY_LENGTH = 104.65;

BIT_CADDY_H = 69.9;
BIT_CADDY_W = 48.9;
BIT_CADDY_D = 15.98;
BIT_PROTRUSION = 13.0;

// V3 handle-support U-slot diameters, based on physical coupon testing.
// The larger openings let the tools settle into the handle/neck transition,
// while the open front permits one-handed side loading/removal.
// Large Phillips increased from 20.0 to 22.0 mm after the U-slot coupon test.
LARGE_PH_SUPPORT_D = 22.0;
LARGE_FLAT_SUPPORT_D = 21.5;
SMALL_FLAT_SUPPORT_D = 6.9;

// Original shaft guide sizes retained only for the optional lower guide.
LARGE_PH_GUIDE_D = 6.7;
LARGE_FLAT_GUIDE_D = 8.0;

// Full-size ratchet handle is not perfectly round. A 30 mm support fit the
// widest orientation but could slip through at the narrow orientation.
// Production support reduced by 3 mm after physical testing.
FULL_RATCHET_HOLE_D = 27.0;
STUBBY_HOLE_D = 33.0;

// Small top edge break. Kept deliberately small because both ratchet handles
// have limited shoulder beyond the chosen hole diameter.
DROP_HOLE_EDGE_BREAK = 0.4;

// Shared finish defaults for U-shaped holders.
// Individual holders can override these where tool geometry needs it.
DS_DEFAULT_ROOT_FILLET_R = 4.0;
DS_DEFAULT_CONTACT_CHAMFER = 1.0;
DS_SMALL_TOOL_CONTACT_CHAMFER = 0.25;


module ds_mount(
    columns,
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5
) {
    pegboard_mount(
        columns=columns,
        pitch=pitch,
        peg_d=peg_d,
        board_geom=board_geom,
        hook_offset=hook_offset,
        neck_length=neck_length
    );
}


// Horizontal cantilever shelf joined to the front of the mount plate.
module ds_shelf(
    width,
    depth,
    thickness=6,
    face_x=DS_FACE_X,
    top_z=DS_SHELF_TOP_Z
) {
    translate([face_x-depth, -width/2, top_z-thickness])
        cube([depth, width, thickness]);
}


// Driver-station wrapper around the reusable U-holder rounded shelf.
module ds_rounded_single_u_shelf(
    width,
    depth,
    slot_d,
    thickness=6,
    front_cap_r=undef,
    face_x=DS_FACE_X,
    top_z=DS_SHELF_TOP_Z
) {
    u_holder_rounded_single_shelf(
        width=width,
        depth=depth,
        slot_d=slot_d,
        thickness=thickness,
        face_x=face_x,
        top_z=top_z,
        front_cap_r=front_cap_r
    );
}


// General-purpose concave quarter-round root fillet for U-shaped holders.
// Adds material where a cantilevered shelf meets the pegboard backplate,
// reducing the inside-corner stress concentration while preserving a true radius.
module ds_shelf_root_fillet(
    width,
    radius=4,
    face_x=DS_FACE_X,
    top_z=DS_SHELF_TOP_Z,
    eps=DS_EPS
) {
    u_holder_root_fillet(
        width=width,
        radius=radius,
        face_x=face_x,
        top_z=top_z,
        eps=eps
    );
}


// Through-hole with a very small conical edge break at the top.
// "d" remains the straight-wall diameter for almost the full thickness.
module ds_drop_hole_cut(
    d,
    thickness,
    edge_break=DROP_HOLE_EDGE_BREAK,
    top_z=DS_SHELF_TOP_Z,
    eps=DS_EPS
) {
    translate([0,0,top_z-thickness-eps])
        cylinder(d=d, h=thickness+2*eps, $fn=64);

    if (edge_break > 0)
        translate([0,0,top_z-edge_break-eps])
            cylinder(
                d1=d,
                d2=d + 2*edge_break,
                h=edge_break + 2*eps,
                $fn=64
            );
}


// Open-front U slot: circular seat plus a straight access channel toward
// negative X (away from the pegboard).
module ds_u_slot_cut(
    slot_d,
    axis_x,
    shelf_front_x,
    thickness,
    top_z=DS_SHELF_TOP_Z,
    eps=DS_EPS
) {
    u_holder_slot_cut(
        slot_d=slot_d,
        axis_x=axis_x,
        shelf_front_x=shelf_front_x,
        thickness=thickness,
        top_z=top_z,
        eps=eps
    );
}


// General-purpose top-edge contact chamfer for an open U slot.
// Removes a tapered band only from the top inside edge of the U, leaving the
// validated straight-wall support diameter unchanged below the chamfer.
// With chamfer=1.0 this is approximately a 1 mm x 1 mm (45-degree) break.
module ds_u_slot_top_chamfer_cut(
    slot_d,
    axis_x,
    shelf_front_x,
    chamfer=1.0,
    top_z=DS_SHELF_TOP_Z,
    eps=0.05
) {
    u_holder_top_chamfer_cut(
        slot_d=slot_d,
        axis_x=axis_x,
        shelf_front_x=shelf_front_x,
        chamfer=chamfer,
        top_z=top_z,
        eps=eps
    );
}


// Fixed screwdriver rack.
// Tool order left-to-right when viewed from the front:
//   large Phillips, large flat-blade, small flat-blade.
//
// V3 uses larger open U slots. Physical testing showed this geometry balances
// the tools well while allowing direct side loading/removal. The shared root
// fillet and top-edge contact chamfer are enabled here; the small flat-blade
// uses a reduced 0.25 mm chamfer because its 7.5 mm handle leaves only a small
// shoulder over the 6.9 mm support diameter.
module fixed_driver_rack(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=107,
    shelf_depth=34,
    shelf_thickness=6,
    tool_axis_out=22.5,
    ph_y=-31,
    flat_y=4,
    small_y=31,
    root_fillet_r=DS_DEFAULT_ROOT_FILLET_R,
    contact_chamfer=DS_DEFAULT_CONTACT_CHAMFER,
    small_contact_chamfer=DS_SMALL_TOOL_CONTACT_CHAMFER
) {
    axis_x = DS_FACE_X - tool_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;
    shelf_top_z = pegboard_feature_top_z(shelf_thickness, pitch, peg_d);

    union() {
        ds_mount(
            columns=5,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length
        );

        difference() {
            ds_shelf(
                width=shelf_width,
                depth=shelf_depth,
                thickness=shelf_thickness,
                top_z=shelf_top_z
            );

            translate([0,ph_y,0]) {
                ds_u_slot_cut(
                    slot_d=LARGE_PH_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );
                ds_u_slot_top_chamfer_cut(
                    slot_d=LARGE_PH_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=contact_chamfer,
                    top_z=shelf_top_z
                );
            }

            translate([0,flat_y,0]) {
                ds_u_slot_cut(
                    slot_d=LARGE_FLAT_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );
                ds_u_slot_top_chamfer_cut(
                    slot_d=LARGE_FLAT_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=contact_chamfer,
                    top_z=shelf_top_z
                );
            }

            translate([0,small_y,0]) {
                ds_u_slot_cut(
                    slot_d=SMALL_FLAT_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );
                ds_u_slot_top_chamfer_cut(
                    slot_d=SMALL_FLAT_SUPPORT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=small_contact_chamfer,
                    top_z=shelf_top_z
                );
            }
        }

        ds_shelf_root_fillet(
            width=shelf_width,
            radius=root_fillet_r,
            top_z=shelf_top_z
        );
    }
}


// Optional guide for the two long screwdriver shafts.
// Install on the same pegboard columns two rows below fixed_driver_rack()
// (50.8 mm vertical pitch separation on a 25.4 mm board).
module long_driver_lower_guide(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=107,
    shelf_depth=25,
    shelf_thickness=4,
    tool_axis_out=18,
    ph_y=-31,
    flat_y=4,
    root_fillet_r=DS_DEFAULT_ROOT_FILLET_R,
    contact_chamfer=0.5
) {
    axis_x = DS_FACE_X - tool_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;
    shelf_top_z = pegboard_feature_top_z(shelf_thickness, pitch, peg_d);

    union() {
        ds_mount(
            columns=5,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length
        );

        difference() {
            ds_shelf(
                width=shelf_width,
                depth=shelf_depth,
                thickness=shelf_thickness,
                top_z=shelf_top_z
            );

            translate([0,ph_y,0]) {
                ds_u_slot_cut(
                    slot_d=LARGE_PH_GUIDE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );
                ds_u_slot_top_chamfer_cut(
                    slot_d=LARGE_PH_GUIDE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=contact_chamfer,
                    top_z=shelf_top_z
                );
            }

            translate([0,flat_y,0]) {
                ds_u_slot_cut(
                    slot_d=LARGE_FLAT_GUIDE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );
                ds_u_slot_top_chamfer_cut(
                    slot_d=LARGE_FLAT_GUIDE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=contact_chamfer,
                    top_z=shelf_top_z
                );
            }
        }

        ds_shelf_root_fillet(
            width=shelf_width,
            radius=root_fillet_r,
            top_z=shelf_top_z
        );
    }
}


// Side wall with a convex rounded front/top corner.
// The fillet is in the X/Z profile and runs across the wall thickness (Y),
// rounding the exposed free-end edge without changing the pocket width.
module ds_caddy_side_wall(
    depth,
    wall,
    height,
    front_top_fillet_r=4,
    fn=32
) {
    r = min(front_top_fillet_r, depth, height);

    if (r <= 0) {
        cube([depth, wall, height]);
    } else {
        union() {
            // Main body below the fillet.
            cube([depth, wall, height-r]);

            // Full-height rear section.
            translate([r,0,height-r])
                cube([depth-r, wall, r]);

            // Quarter-cylinder forming the rounded front/top corner.
            intersection() {
                translate([r, wall/2, height-r])
                    rotate([90,0,0])
                        cylinder(
                            r=r,
                            h=wall,
                            center=true,
                            $fn=fn
                        );

                translate([0,0,height-r])
                    cube([r, wall, r]);
            }
        }
    }
}


// Shallow pocket for the ratchet bit caddy. The caddy is stored vertically:
// 69.9 mm high x 48.9 mm wide x 15.98 mm body depth.
// Bits may protrude ~13 mm farther forward; the pocket captures only the
// lower body and leaves the bits unobstructed. The front lip must remain
// <= 1.5 mm above the inside floor so it does not interfere with the bits.
module bit_caddy_pocket(
    center_y=26,
    inner_w=50.5,
    inner_d=17.5,
    capture_h=26,
    wall=3,
    front_lip_h=1.5,
    side_front_top_fillet_r=4,
    base_z=DS_SHELF_TOP_Z,
    back_overlap=DS_EPS
) {
    outer_w = inner_w + 2*wall;

    // The pegboard mount plate itself is the rear wall of the pocket.
    // Keep the tested internal depth measured forward from the plate face,
    // and overlap the floor/side walls slightly into the plate for a robust union.
    inner_back_x = DS_FACE_X;
    front_x = inner_back_x - inner_d;
    shell_d = inner_d + wall + back_overlap;

    // bottom
    translate([
        front_x-wall,
        center_y-outer_w/2,
        base_z-wall
    ])
        cube([shell_d, outer_w, wall]);

    // No separate rear wall: the common pegboard backplate closes the pocket.

    // Side walls. Their exposed front/top edges are rounded to remove the
    // two sharp corners at the mouth of the pocket.
    for (sy = [-1,1])
        translate([
            front_x-wall,
            center_y + sy*(inner_w/2 + wall/2) - wall/2,
            base_z-wall
        ])
            ds_caddy_side_wall(
                depth=shell_d,
                wall=wall,
                height=capture_h+wall,
                front_top_fillet_r=side_front_top_fillet_r
            );

    // low front lip
    translate([
        front_x-wall,
        center_y-outer_w/2,
        base_z-wall
    ])
        cube([wall, outer_w, front_lip_h+wall]);
}


// Full-size ratchet + its bit caddy as one module.
//
// The ratchet support is now a localized U shelf rather than a full-width
// rectangular shelf. The bit-caddy pocket has its own floor/side/front walls
// and uses the common pegboard backplate as its rear wall, avoiding redundant
// material between the pocket and mount plate.
module full_ratchet_with_bits(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=45,
    shelf_depth=46,
    shelf_thickness=6,
    ratchet_axis_out=25,
    ratchet_y=-31,
    caddy_y=undef,
    caddy_inner_w=50.5,
    caddy_wall=3,
    caddy_lip_h=1.5,
    caddy_side_fillet_r=4,
    front_cap_r=undef,
    root_fillet_r=DS_DEFAULT_ROOT_FILLET_R,
    contact_chamfer=DS_DEFAULT_CONTACT_CHAMFER
) {
    axis_x = DS_FACE_X - ratchet_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;
    shelf_top_z = pegboard_feature_top_z(shelf_thickness, pitch, peg_d);

    // Auto-align the caddy's outer edge with the outer edge of the 5-column
    // pegboard backplate while preserving the full tested pocket width.
    mount_half_w = pegboard_mount_outer_half_width(5, pitch, peg_d);
    caddy_outer_w = caddy_inner_w + 2 * caddy_wall;
    caddy_center_y = is_undef(caddy_y)
        ? mount_half_w - caddy_outer_w / 2
        : caddy_y;

    union() {
        ds_mount(
            columns=5,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length
        );

        // Localized ratchet U support only.
        translate([0,ratchet_y,0])
            difference() {
                ds_rounded_single_u_shelf(
                    width=shelf_width,
                    depth=shelf_depth,
                    slot_d=FULL_RATCHET_HOLE_D,
                    thickness=shelf_thickness,
                    front_cap_r=front_cap_r,
                    top_z=shelf_top_z
                );

                ds_u_slot_cut(
                    slot_d=FULL_RATCHET_HOLE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness,
                    top_z=shelf_top_z
                );

                ds_u_slot_top_chamfer_cut(
                    slot_d=FULL_RATCHET_HOLE_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    chamfer=contact_chamfer,
                    top_z=shelf_top_z
                );
            }

        // Bit caddy keeps only its own required pocket geometry.
        // Its underside is aligned with the underside of the ratchet U shelf.
        bit_caddy_pocket(
            center_y=caddy_center_y,
            inner_w=caddy_inner_w,
            wall=caddy_wall,
            front_lip_h=caddy_lip_h,
            side_front_top_fillet_r=caddy_side_fillet_r,
            base_z=shelf_top_z - shelf_thickness + caddy_wall
        );

        // Root reinforcement exists only behind the ratchet U, not across the
        // material-free region beside the caddy.
        translate([0,ratchet_y,0])
            ds_shelf_root_fillet(
                width=shelf_width,
                radius=root_fillet_r,
                top_z=shelf_top_z
            );
    }
}


// Stanley stubby ratchet U-slot holder.
// The U arms use semicircular front endcaps and a concave root fillet where
// the shelf meets the pegboard plate. A small top-edge chamfer is also applied
// to the inner U where the handle rests. The physically validated 33 mm
// straight-wall support slot is unchanged below that chamfer.
module stubby_ratchet_holder(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=60,
    shelf_depth=48,
    shelf_thickness=6,
    tool_axis_out=26,
    front_cap_r=undef,
    root_fillet_r=DS_DEFAULT_ROOT_FILLET_R,
    contact_chamfer=DS_DEFAULT_CONTACT_CHAMFER
) {
    axis_x = DS_FACE_X - tool_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;
    shelf_top_z = pegboard_feature_top_z(shelf_thickness, pitch, peg_d);

    union() {
        ds_mount(
            columns=3,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length
        );

        difference() {
            ds_rounded_single_u_shelf(
                width=shelf_width,
                depth=shelf_depth,
                slot_d=STUBBY_HOLE_D,
                thickness=shelf_thickness,
                front_cap_r=front_cap_r,
                top_z=shelf_top_z
            );

            ds_u_slot_cut(
                slot_d=STUBBY_HOLE_D,
                axis_x=axis_x,
                shelf_front_x=shelf_front_x,
                thickness=shelf_thickness,
                top_z=shelf_top_z
            );

            ds_u_slot_top_chamfer_cut(
                slot_d=STUBBY_HOLE_D,
                axis_x=axis_x,
                shelf_front_x=shelf_front_x,
                chamfer=contact_chamfer,
                top_z=shelf_top_z
            );
        }

        ds_shelf_root_fillet(
            width=shelf_width,
            radius=root_fillet_r,
            top_z=shelf_top_z
        );
    }
}


// Compact fit-check coupon for the user-facing tool interfaces only.
// Does not test the pegboard mount.
module driver_station_fit_coupon(
    thickness=6,
    pad=8
) {
    plate_w = 110;
    plate_d = 80;

    difference() {
        cube([plate_d, plate_w, thickness]);

        // Ratchet holes.
        translate([18,24,-DS_EPS])
            cylinder(d=FULL_RATCHET_HOLE_D, h=thickness+2*DS_EPS, $fn=64);

        translate([18,72,-DS_EPS])
            cylinder(d=STUBBY_HOLE_D, h=thickness+2*DS_EPS, $fn=64);

        // V2 fixed-driver drop-through holes.
        // Deliberately straight-sided with no top chamfer.
        translate([60,20,-DS_EPS])
            cylinder(d=LARGE_PH_SUPPORT_D, h=thickness+2*DS_EPS, $fn=64);

        translate([60,52,-DS_EPS])
            cylinder(d=LARGE_FLAT_SUPPORT_D, h=thickness+2*DS_EPS, $fn=64);

        translate([60,82,-DS_EPS])
            cylinder(d=SMALL_FLAT_SUPPORT_D, h=thickness+2*DS_EPS, $fn=48);
    }
}


// U-slot comparison coupon for all five driver interfaces.
// This is a calibration part only: production holders remain unchanged until
// the physical U-slot test is evaluated.
//
// Slot order along Y:
//   22.0  large Phillips
//   21.5  large flat-blade
//    6.9  small flat-blade
//   27.0  full-size ratchet
//   33.0  Stanley stubby
//
// Each circular seat opens to the +X edge with a straight channel equal to
// the seat diameter. There is no chamfer/edge break so the test isolates the
// effect of changing from a closed hole to an open U-shaped slot.
module driver_station_u_slot_coupon(
    thickness=6
) {
    plate_d = 62;
    plate_w = 185;
    center_x = 34;

    slot_specs = [
        [LARGE_PH_SUPPORT_D,     20],
        [LARGE_FLAT_SUPPORT_D,   52],
        [SMALL_FLAT_SUPPORT_D,   82],
        [FULL_RATCHET_HOLE_D, 122],
        [STUBBY_HOLE_D,       164]
    ];

    difference() {
        cube([plate_d, plate_w, thickness]);

        for (spec = slot_specs) {
            d = spec[0];
            y = spec[1];

            translate([center_x, y, -DS_EPS])
                cylinder(
                    d=d,
                    h=thickness + 2*DS_EPS,
                    $fn=d >= 20 ? 64 : 48
                );

            translate([
                center_x,
                y - d/2,
                -DS_EPS
            ])
                cube([
                    plate_d - center_x + DS_EPS,
                    d,
                    thickness + 2*DS_EPS
                ]);
        }
    }
}
