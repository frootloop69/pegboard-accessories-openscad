/*
  Eureka full-size ratchet + bit-caddy holder — Customizer-ready
  Units: mm.

  OpenSCAD: Window -> Customizer

  PARAMETER GUIDE

  Mount calibration
    PEG_D                Peg/hook diameter. Current Eureka calibration for
                         Creality Hyper PLA in standard orientation: 5.2.
    PITCH                Pegboard hole spacing; Eureka is 25.4 mm.
    BOARD_GEOM           Empirical hook geometry; normally keep at 5.0.
    HOOK_OFFSET          Upper retaining-hook offset; normally 4.5.
    NECK_LENGTH          Straight hook-neck length; normally 0.5.

  Ratchet U support
    RATCHET_SLOT_D       U-seat diameter. Current physically revised value:
                         27.0 mm because the handle is not perfectly round.
    SHELF_WIDTH          Overall width of the localized ratchet U support.
    SHELF_DEPTH          Projection from the backplate.
    SHELF_THICKNESS      U-support thickness.
    RATCHET_AXIS_OUT     Backplate-to-U-seat-center distance.
    RATCHET_Y            Left/right center of the ratchet U on the backplate.

  Bit caddy
    AUTO_CADDY_Y         true = align outside wall to backplate edge.
    CADDY_Y              Manual center position used only when AUTO_CADDY_Y
                         is false.
    CADDY_INNER_W        Internal left/right pocket width.
    CADDY_INNER_D        Internal front/back pocket depth.
    CADDY_CAPTURE_H      Side-wall height above the pocket floor region.
    CADDY_WALL           Pocket floor/side-wall thickness.
    CADDY_LIP_H          Front lip height ABOVE the inside floor. For the
                         current 17.5 mm-deep caddy design, do not exceed
                         1.5 mm or the protruding bits interfere.
    CADDY_SIDE_FILLET_R  Radius on exposed front/top side-wall corners.

  Edge treatment
    AUTO_FRONT_CAP       true = use the maximum semicircular U-arm end radius.
    FRONT_CAP_R          Manual end radius when AUTO_FRONT_CAP is false.
    ROOT_FILLET_R        U-shelf/backplate reinforcing fillet.
    CONTACT_CHAMFER      Top inside chamfer where the ratchet handle rests.
*/

use <../src/driver_station.scad>
use <../src/mount.scad>

/* [Mount calibration] */
PEG_D = 5.2;                  // [4.0:0.05:7.5]
PITCH = 25.4;                 // [20:0.1:30]
BOARD_GEOM = 5.0;             // [3:0.1:7]
HOOK_OFFSET = 4.5;            // [2:0.1:7]
NECK_LENGTH = 0.5;            // [0.2:0.05:2]

/* [Ratchet U support] */
RATCHET_SLOT_D = 27.0;        // [24:0.1:31]
SHELF_WIDTH = 45;             // [35:1:70]
SHELF_DEPTH = 46;             // [30:1:70]
SHELF_THICKNESS = 6;          // [3:0.5:10]
RATCHET_AXIS_OUT = 25;        // [18:0.5:40]
RATCHET_Y = -31;              // [-60:0.5:10]

/* [Bit caddy] */
AUTO_CADDY_Y = true;
CADDY_Y = 27;                 // [-10:0.5:60]
CADDY_INNER_W = 50.5;         // [45:0.1:60]
CADDY_INNER_D = 17.5;         // [15:0.5:35]
CADDY_CAPTURE_H = 26;         // [10:1:45]
CADDY_WALL = 3;               // [2:0.25:5]
CADDY_LIP_H = 1.5;            // [0:0.1:10]
CADDY_SIDE_FILLET_R = 4;      // [0:0.5:8]

/* [Edge treatment] */
AUTO_FRONT_CAP = true;
FRONT_CAP_R = 4.5;            // [0:0.5:8]
ROOT_FILLET_R = 4.0;          // [0:0.5:8]
CONTACT_CHAMFER = 1.0;        // [0:0.1:2]

translate([0, 0, -pegboard_mount_bottom_z(PITCH, PEG_D)])
full_ratchet_with_bits(
    pitch=PITCH,
    peg_d=PEG_D,
    board_geom=BOARD_GEOM,
    hook_offset=HOOK_OFFSET,
    neck_length=NECK_LENGTH,
    shelf_width=SHELF_WIDTH,
    shelf_depth=SHELF_DEPTH,
    shelf_thickness=SHELF_THICKNESS,
    ratchet_axis_out=RATCHET_AXIS_OUT,
    ratchet_y=RATCHET_Y,
    ratchet_slot_d=RATCHET_SLOT_D,
    caddy_y=AUTO_CADDY_Y ? undef : CADDY_Y,
    caddy_inner_w=CADDY_INNER_W,
    caddy_inner_d=CADDY_INNER_D,
    caddy_capture_h=CADDY_CAPTURE_H,
    caddy_wall=CADDY_WALL,
    caddy_lip_h=CADDY_LIP_H,
    caddy_side_fillet_r=CADDY_SIDE_FILLET_R,
    front_cap_r=AUTO_FRONT_CAP ? undef : FRONT_CAP_R,
    root_fillet_r=ROOT_FILLET_R,
    contact_chamfer=CONTACT_CHAMFER
);
