/*
  Pegboard default mount calibration coupon
  -----------------------------------------
  Purpose:
    Validate the known-good mounting interface before designing tool holders.

  Default geometry taken from the user's proven PEGSTR-derived working design:
    hole_spacing      = 25.4 mm
    hole_size         = 5.8 mm
    board_thickness   = 5.0 mm   // geometry parameter from the proven design
    hook_offset       = 4.5 mm
    neck_length       = 0.5 mm

  This coupon deliberately uses:
    - two upper retaining hooks, 25.4 mm apart
    - two lower straight locating pegs, one row below
    - a small backing plate with the hook roots fully encapsulated

  The 5.0 mm board_thickness value is an empirical geometry parameter from
  the known-good model; it is NOT a statement that the metal pegboard is
  physically 5 mm thick.
*/

hole_spacing    = 25.4;
hole_size       = 5.8;
board_thickness = 5.0;
hook_offset     = 4.5;
neck_length     = 0.5;

// Original PEGSTR-derived wall thickness.
base_wall_thickness = 1.85;

// The standalone coupon has no tool-holder body to bury the hook roots.
// Add material ONLY on the accessory side so the mounting interface
// remains unchanged while the rear face stays smooth.
root_cover = neck_length + 0.20;
plate_thickness = base_wall_thickness + root_cover;

epsilon = 0.1;
clip_height = 2 * hole_size + 2;
$fn = 32;


// One peg. clip=true creates the curved upper retaining hook.
// clip=false creates the straight locating peg.
module peg_pin(clip=false) {
    rotate([0,0,15])
        cylinder(
            r = hole_size / 2,
            h = clip ? neck_length : board_thickness * 1.5 + epsilon,
            center = true,
            $fn = 12
        );

    if (clip) {
        rotate([0,0,90])
        intersection() {
            translate([0, 0, hole_size - epsilon])
                cube(
                    [hole_size + 2*epsilon, clip_height, 2*hole_size],
                    center = true
                );

            translate([0, hole_size/2 + 2, board_thickness/2])
                rotate([0,90,0])
                rotate_extrude(convexity = 5, $fn = 20)
                    translate([5.5,0,0])
                        circle(r = (hole_size * 0.95) / 2, $fn = 20);

            translate([0, hole_size/2 + 0.5, board_thickness/2])
                rotate([45,0,0])
                translate([0,0,hole_size * 0.6])
                    cube(
                        [hole_size + 2*epsilon, 3*hole_size, hole_size],
                        center = true
                    );
        }
    }
}


// Two columns. Upper row = retaining hooks.
// Lower row, exactly 25.4 mm below = straight locating pegs.
module mount_pins() {
    rotate([0,90,0]) {
        for (column = [-hole_spacing/2, hole_spacing/2]) {
            translate([0, column, -hook_offset])
                peg_pin(true);

            translate([hole_spacing, column, 0])
                peg_pin(false);
        }
    }
}


// Compact backing plate following the same geometric relationship
// used by the proven PEGSTR-derived reference.
module mount_plate() {
    rotate([0,90,0])
    translate([
        -epsilon,
        0,
        -plate_thickness - board_thickness/2 + epsilon
    ])
    hull() {
        for (column = [-hole_spacing/2, hole_spacing/2]) {
            translate([
                -clip_height/2 + hole_size/2,
                column,
                0
            ])
                cylinder(r=hole_size/2, h=plate_thickness);

            translate([
                hole_spacing,
                column,
                0
            ])
                cylinder(r=hole_size/2, h=plate_thickness);
        }
    }
}


module calibration_coupon() {
    union() {
        mount_plate();
        mount_pins();
    }
}


// Print-ready orientation:
// the curved hook profiles are built predominantly in-plane, improving
// strength and reducing support burden compared with printing them as
// horizontal cantilevers.
rotate([90,0,0])
    calibration_coupon();
