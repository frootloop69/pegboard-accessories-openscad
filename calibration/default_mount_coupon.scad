/*
  Generic pegboard mount calibration coupon.
  Set CAL_PEG_D before including this file, or render directly at 5.8 mm.
*/

use <../src/mount.scad>

CAL_PEG_D = is_undef(CAL_PEG_D) ? 5.8 : CAL_PEG_D;
CAL_PITCH = is_undef(CAL_PITCH) ? 25.4 : CAL_PITCH;
CAL_BOARD_GEOM = is_undef(CAL_BOARD_GEOM) ? 5.0 : CAL_BOARD_GEOM;
CAL_HOOK_OFFSET = is_undef(CAL_HOOK_OFFSET) ? 4.5 : CAL_HOOK_OFFSET;
CAL_NECK = is_undef(CAL_NECK) ? 0.5 : CAL_NECK;

// Print-ready orientation.
rotate([90,0,0])
    pegboard_mount(
        columns=2,
        pitch=CAL_PITCH,
        peg_d=CAL_PEG_D,
        board_geom=CAL_BOARD_GEOM,
        hook_offset=CAL_HOOK_OFFSET,
        neck_length=CAL_NECK
    );
