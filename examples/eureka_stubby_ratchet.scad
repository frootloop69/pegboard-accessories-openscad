/*
  Eureka Stanley stubby ratchet holder — Customizer-ready
  Units: mm.

  OpenSCAD: Window -> Customizer

  PARAMETER GUIDE

  Mount calibration
    PEG_D                Peg/hook diameter. Current Eureka Creality Hyper PLA
                         calibration in standard orientation: 5.2 mm.
    PITCH                Pegboard hole pitch: 25.4 mm.
    BOARD_GEOM           Empirical hook geometry; normally 5.0.
    HOOK_OFFSET          Upper retaining-hook offset; normally 4.5.
    NECK_LENGTH          Straight hook-neck length; normally 0.5.

  Stubby U support
    SLOT_D               U-seat diameter. Current validated value: 33.0 mm.
    SHELF_WIDTH          Overall width of the U support.
    SHELF_DEPTH          Projection from the backplate.
    SHELF_THICKNESS      U-support thickness.
    TOOL_AXIS_OUT        Backplate-to-U-seat center distance.

  Edge treatment
    AUTO_FRONT_CAP       true = automatically make each arm end a maximum
                         semicircular nose.
    FRONT_CAP_R          Manual arm-end radius when AUTO_FRONT_CAP is false.
    ROOT_FILLET_R        U-shelf/backplate reinforcing fillet.
    CONTACT_CHAMFER      Top inside chamfer where the handle rests.
*/

use <../src/driver_station.scad>
use <../src/mount.scad>

/* [Mount calibration] */
PEG_D = 5.2;                  // [4.0:0.05:7.5]
PITCH = 25.4;                 // [20:0.1:30]
BOARD_GEOM = 5.0;             // [3:0.1:7]
HOOK_OFFSET = 4.5;            // [2:0.1:7]
NECK_LENGTH = 0.5;            // [0.2:0.05:2]

/* [Stubby U support] */
SLOT_D = 33.0;                // [28:0.1:38]
SHELF_WIDTH = 60;             // [45:1:80]
SHELF_DEPTH = 48;             // [30:1:70]
SHELF_THICKNESS = 6;          // [3:0.5:10]
TOOL_AXIS_OUT = 26;           // [18:0.5:40]

/* [Edge treatment] */
AUTO_FRONT_CAP = true;
FRONT_CAP_R = 6.75;           // [0:0.25:10]
ROOT_FILLET_R = 4.0;          // [0:0.5:8]
CONTACT_CHAMFER = 1.0;        // [0:0.1:2]

translate([0, 0, -pegboard_mount_bottom_z(PITCH, PEG_D)])
stubby_ratchet_holder(
    pitch=PITCH,
    peg_d=PEG_D,
    board_geom=BOARD_GEOM,
    hook_offset=HOOK_OFFSET,
    neck_length=NECK_LENGTH,
    shelf_width=SHELF_WIDTH,
    shelf_depth=SHELF_DEPTH,
    shelf_thickness=SHELF_THICKNESS,
    tool_axis_out=TOOL_AXIS_OUT,
    slot_d=SLOT_D,
    front_cap_r=AUTO_FRONT_CAP ? undef : FRONT_CAP_R,
    root_fillet_r=ROOT_FILLET_R,
    contact_chamfer=CONTACT_CHAMFER
);
