/*
  Eureka workspace mount tuning coupon.

  For a new filament/process, normally change only CAL_PEG_D below, render,
  and print at 100% scale. The rest of the Eureka geometry remains fixed.

  Current validated production value for Creality Hyper PLA in the standard
  axis-aligned orientation: 5.2 mm.
*/

use <default_mount_coupon.scad>

CAL_PEG_D = 5.2;

// Only change these if deliberately recalibrating the mount architecture.
CAL_PITCH = 25.4;
CAL_BOARD_GEOM = 5.0;
CAL_HOOK_OFFSET = 4.5;
CAL_NECK = 0.5;

mount_calibration_coupon(
    peg_d=CAL_PEG_D,
    pitch=CAL_PITCH,
    board_geom=CAL_BOARD_GEOM,
    hook_offset=CAL_HOOK_OFFSET,
    neck_length=CAL_NECK
);
