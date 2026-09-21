/*
  Eureka workspace mount tuning coupon.

  For a new filament/process, normally change only CAL_PEG_D below, render,
  and print at 100% scale. The rest of the Eureka geometry remains fixed.

  Suggested starting point for the previously validated setup: 5.5 mm.
*/

CAL_PEG_D = 5.5;

// Only change these if deliberately recalibrating the mount architecture.
CAL_PITCH = 25.4;
CAL_BOARD_GEOM = 5.0;
CAL_HOOK_OFFSET = 4.5;
CAL_NECK = 0.5;

include <default_mount_coupon.scad>
