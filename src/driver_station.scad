/*
  Modular electronics-workspace driver station.
  Units: mm.

  Installed-coordinate convention inherited from mount.scad:
    - pegboard plane is approximately the Y/Z plane
    - accessory projects toward negative X
    - tools hang toward negative Z

  V1 is deliberately simple:
    - open U-slot shelf for fixed screwdrivers
    - optional lower shaft guide for the two long drivers
    - circular drop-through shelves for ratcheting drivers
    - shallow lower pocket for the full-size ratchet bit caddy
*/

use <mount.scad>

// Empirical front face chosen to overlap the proven mount plate without
// pushing accessory geometry into the board.
DS_FACE_X = -4.0;
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

// V1 working clearances.
LARGE_PH_SLOT_D = 6.7;
LARGE_FLAT_SLOT_D = 8.0;
SMALL_FLAT_SLOT_D = 2.8;

FULL_RATCHET_HOLE_D = 30.0;
STUBBY_HOLE_D = 33.0;

// Small top edge break. Kept deliberately small because both ratchet handles
// have limited shoulder beyond the chosen hole diameter.
DROP_HOLE_EDGE_BREAK = 0.4;


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
    translate([axis_x,0,top_z-thickness-eps])
        cylinder(d=slot_d, h=thickness+2*eps, $fn=48);

    translate([
        shelf_front_x-eps,
        -slot_d/2,
        top_z-thickness-eps
    ])
        cube([
            axis_x - shelf_front_x + slot_d/2 + 2*eps,
            slot_d,
            thickness + 2*eps
        ]);
}


// Fixed screwdriver rack.
// Tool order left-to-right when viewed from the front:
//   large Phillips, large flat-blade, small flat-blade.
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
    small_y=31
) {
    axis_x = DS_FACE_X - tool_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;

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
                thickness=shelf_thickness
            );

            translate([0,ph_y,0])
                ds_u_slot_cut(
                    slot_d=LARGE_PH_SLOT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness
                );

            translate([0,flat_y,0])
                ds_u_slot_cut(
                    slot_d=LARGE_FLAT_SLOT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness
                );

            translate([0,small_y,0])
                ds_u_slot_cut(
                    slot_d=SMALL_FLAT_SLOT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness
                );
        }
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
    flat_y=4
) {
    axis_x = DS_FACE_X - tool_axis_out;
    shelf_front_x = DS_FACE_X - shelf_depth;

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
                thickness=shelf_thickness
            );

            translate([0,ph_y,0])
                ds_u_slot_cut(
                    slot_d=LARGE_PH_SLOT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness
                );

            translate([0,flat_y,0])
                ds_u_slot_cut(
                    slot_d=LARGE_FLAT_SLOT_D,
                    axis_x=axis_x,
                    shelf_front_x=shelf_front_x,
                    thickness=shelf_thickness
                );
        }
    }
}


// Shallow pocket for the ratchet bit caddy. The caddy is stored vertically:
// 69.9 mm high x 48.9 mm wide x 15.98 mm body depth.
// Bits may protrude ~13 mm farther forward; the pocket captures only the
// lower body and leaves the bits unobstructed.
module bit_caddy_pocket(
    center_y=26,
    inner_w=50.5,
    inner_d=17.5,
    capture_h=26,
    wall=3,
    front_lip_h=10,
    base_z=DS_SHELF_TOP_Z
) {
    outer_w = inner_w + 2*wall;
    outer_d = inner_d + 2*wall;
    back_x = DS_FACE_X - wall;
    inner_back_x = back_x;
    front_x = inner_back_x - inner_d;

    // bottom
    translate([
        front_x-wall,
        center_y-outer_w/2,
        base_z-wall
    ])
        cube([outer_d, outer_w, wall]);

    // rear wall
    translate([
        back_x,
        center_y-outer_w/2,
        base_z-wall
    ])
        cube([wall, outer_w, capture_h+wall]);

    // side walls
    for (sy = [-1,1])
        translate([
            front_x-wall,
            center_y + sy*(inner_w/2 + wall/2) - wall/2,
            base_z-wall
        ])
            cube([outer_d, wall, capture_h+wall]);

    // low front lip
    translate([
        front_x-wall,
        center_y-outer_w/2,
        base_z-wall
    ])
        cube([wall, outer_w, front_lip_h+wall]);
}


// Full-size ratchet + its bit caddy as one module.
module full_ratchet_with_bits(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=107,
    shelf_depth=46,
    shelf_thickness=6,
    ratchet_axis_out=25,
    ratchet_y=-31,
    caddy_y=27
) {
    axis_x = DS_FACE_X - ratchet_axis_out;

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
                thickness=shelf_thickness
            );

            translate([axis_x,ratchet_y,0])
                ds_drop_hole_cut(
                    d=FULL_RATCHET_HOLE_D,
                    thickness=shelf_thickness
                );
        }

        bit_caddy_pocket(center_y=caddy_y);
    }
}


// Stanley stubby ratchet drop-through holder.
module stubby_ratchet_holder(
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    shelf_width=60,
    shelf_depth=48,
    shelf_thickness=6,
    tool_axis_out=26
) {
    axis_x = DS_FACE_X - tool_axis_out;

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
            ds_shelf(
                width=shelf_width,
                depth=shelf_depth,
                thickness=shelf_thickness
            );

            translate([axis_x,0,0])
                ds_drop_hole_cut(
                    d=STUBBY_HOLE_D,
                    thickness=shelf_thickness
                );
        }
    }
}


// Compact fit-check coupon for the user-facing tool interfaces only.
// Does not test the pegboard mount.
module driver_station_fit_coupon(
    thickness=6,
    pad=8
) {
    plate_w = 110;
    plate_d = 52;

    difference() {
        cube([plate_d, plate_w, thickness]);

        // Ratchet holes.
        translate([18,24,-DS_EPS])
            cylinder(d=FULL_RATCHET_HOLE_D, h=thickness+2*DS_EPS, $fn=64);

        translate([18,72,-DS_EPS])
            cylinder(d=STUBBY_HOLE_D, h=thickness+2*DS_EPS, $fn=64);

        // Open U slots along the opposite edge.
        for (spec = [
            [LARGE_PH_SLOT_D, 18],
            [LARGE_FLAT_SLOT_D, 40],
            [SMALL_FLAT_SLOT_D, 59]
        ]) {
            d = spec[0];
            y = spec[1];
            translate([plate_d-14,y,-DS_EPS])
                cylinder(d=d, h=thickness+2*DS_EPS, $fn=48);
            translate([plate_d-14,y-d/2,-DS_EPS])
                cube([15,d,thickness+2*DS_EPS]);
        }
    }
}
