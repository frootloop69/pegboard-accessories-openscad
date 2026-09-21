/*
  Generic pegboard mount calibration coupon.

  Open this file directly to render the generic 5.8 mm coupon, or import the
  mount_calibration_coupon() module from a board-specific tuning file.
*/

use <../src/mount.scad>

module mount_calibration_coupon(
    peg_d=5.8,
    pitch=25.4,
    board_geom=5.0,
    hook_offset=4.5,
    neck_length=0.5
) {
    // Print in the same axis-aligned orientation as production accessories so
    // filament/process effects on the peg geometry are representative.
    translate([
        0,
        0,
        -pegboard_mount_bottom_z(pitch, peg_d)
    ])
        pegboard_mount(
            columns=2,
            pitch=pitch,
            peg_d=peg_d,
            board_geom=board_geom,
            hook_offset=hook_offset,
            neck_length=neck_length
        );
}

// Direct-open default.
mount_calibration_coupon();
