/*
  Reusable pegboard mount geometry.
  Units: mm.

  Mechanical architecture:
    - curved upper retaining hooks
    - straight lower locating pegs one grid row below

  The current geometry is based on physical testing plus a known-working
  PEGSTR-derived reference. See docs/THIRD_PARTY.md before redistributing or
  relicensing derived geometry.
*/

// Shared dimensional helpers for accessories built on this mount.
//
// The mount plate's installed lower edge is set by the lower locator row:
// local X max = pitch + peg_d/2, which becomes global Z min after the
// rotate([0,90,0]) used by pegboard_mount_plate().
function pegboard_mount_bottom_z(
    pitch=25.4,
    peg_d=5.5
) = -(pitch + peg_d/2);

// Outer Y extent of the mount plate. Useful for aligning accessory side walls
// with the common backplate rather than allowing them to protrude.
function pegboard_mount_outer_half_width(
    columns=2,
    pitch=25.4,
    peg_d=5.5
) = ((columns - 1) * pitch) / 2 + peg_d/2;

// Default print-efficient accessory rule: if a feature can share the same
// build-plane edge as the backplate, place its underside on mount_bottom_z.
// This returns the required top Z for a feature of the supplied thickness.
function pegboard_feature_top_z(
    thickness,
    pitch=25.4,
    peg_d=5.5
) = pegboard_mount_bottom_z(pitch, peg_d) + thickness;


module pegboard_pin(
    clip=false,
    peg_d=5.5,
    board_geom=5.0,
    neck_length=0.5,
    epsilon=0.1
) {
    clip_height = 2 * peg_d + 2;

    rotate([0,0,15])
        cylinder(
            r = peg_d / 2,
            h = clip ? neck_length : board_geom * 1.5 + epsilon,
            center = true,
            $fn = 12
        );

    if (clip) {
        rotate([0,0,90])
        intersection() {
            translate([0, 0, peg_d - epsilon])
                cube(
                    [peg_d + 2*epsilon, clip_height, 2*peg_d],
                    center = true
                );

            translate([0, peg_d/2 + 2, board_geom/2])
                rotate([0,90,0])
                rotate_extrude(convexity = 5, $fn = 20)
                    translate([5.5,0,0])
                        circle(r = (peg_d * 0.95) / 2, $fn = 20);

            translate([0, peg_d/2 + 0.5, board_geom/2])
                rotate([45,0,0])
                translate([0,0,peg_d * 0.6])
                    cube(
                        [peg_d + 2*epsilon, 3*peg_d, peg_d],
                        center = true
                    );
        }
    }
}


module pegboard_mount_pins(
    columns=2,
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    epsilon=0.1
) {
    width = (columns - 1) * pitch;

    rotate([0,90,0]) {
        for (i = [0:columns-1]) {
            column = -width/2 + i*pitch;

            translate([0, column, -hook_offset])
                pegboard_pin(
                    clip=true,
                    peg_d=peg_d,
                    board_geom=board_geom,
                    neck_length=neck_length,
                    epsilon=epsilon
                );

            translate([pitch, column, 0])
                pegboard_pin(
                    clip=false,
                    peg_d=peg_d,
                    board_geom=board_geom,
                    neck_length=neck_length,
                    epsilon=epsilon
                );
        }
    }
}


module pegboard_mount_plate(
    columns=2,
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    neck_length=0.5,
    base_wall_thickness=1.85,
    root_clearance=0.20,
    epsilon=0.1
) {
    width = (columns - 1) * pitch;
    clip_height = 2 * peg_d + 2;
    root_cover = neck_length + root_clearance;
    plate_thickness = base_wall_thickness + root_cover;

    rotate([0,90,0])
    translate([
        -epsilon,
        0,
        -plate_thickness - board_geom/2 + epsilon
    ])
    hull() {
        for (i = [0:columns-1]) {
            column = -width/2 + i*pitch;

            translate([
                -clip_height/2 + peg_d/2,
                column,
                0
            ])
                cylinder(r=peg_d/2, h=plate_thickness, $fn=32);

            translate([
                pitch,
                column,
                0
            ])
                cylinder(r=peg_d/2, h=plate_thickness, $fn=32);
        }
    }
}


module pegboard_mount(
    columns=2,
    pitch=25.4,
    peg_d=5.5,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5,
    base_wall_thickness=1.85,
    root_clearance=0.20,
    epsilon=0.1,
    include_plate=true
) {
    union() {
        if (include_plate)
            pegboard_mount_plate(
                columns=columns,
                pitch=pitch,
                peg_d=peg_d,
                board_geom=board_geom,
                neck_length=neck_length,
                base_wall_thickness=base_wall_thickness,
                root_clearance=root_clearance,
                epsilon=epsilon
            );

        pegboard_mount_pins(
            columns=columns,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length,
            epsilon=epsilon
        );
    }
}
