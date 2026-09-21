/*
  Eureka optional long-driver lower guide — Customizer-ready
  Units: mm.

  OpenSCAD: Window -> Customizer

  PARAMETER GUIDE

  Mount calibration
    PEG_D / PITCH / BOARD_GEOM / HOOK_OFFSET / NECK_LENGTH
                         Common pegboard mount geometry. Current Eureka
                         Creality Hyper PLA peg diameter is 5.2 mm.

  Guide geometry
    SHELF_WIDTH          Overall guide width.
    SHELF_DEPTH          Projection from the pegboard.
    SHELF_THICKNESS      Guide thickness.
    TOOL_AXIS_OUT        Backplate-to-guide-seat center distance.

  Shaft clearance
    PH_GUIDE_D           Large Phillips shaft-guide U diameter.
    FLAT_GUIDE_D         Large flat-blade shaft-guide U diameter.

  Positions
    PH_Y / FLAT_Y        Left/right guide centers. These should normally match
                         the corresponding positions on the fixed-driver rack.

  Edge treatment
    ROOT_FILLET_R        Shelf/backplate reinforcing fillet.
    CONTACT_CHAMFER      Small top inside guide chamfer.
*/

use <../src/driver_station.scad>
use <../src/mount.scad>

/* [Mount calibration] */
PEG_D = 5.2;                  // [4.0:0.05:7.5]
PITCH = 25.4;                 // [20:0.1:30]
BOARD_GEOM = 5.0;             // [3:0.1:7]
HOOK_OFFSET = 4.5;            // [2:0.1:7]
NECK_LENGTH = 0.5;            // [0.2:0.05:2]

/* [Guide geometry] */
SHELF_WIDTH = 107;            // [70:1:150]
SHELF_DEPTH = 25;             // [15:1:50]
SHELF_THICKNESS = 4;          // [3:0.5:8]
TOOL_AXIS_OUT = 18;           // [12:0.5:35]

/* [Shaft clearance] */
PH_GUIDE_D = 6.7;             // [5:0.1:10]
FLAT_GUIDE_D = 8.0;           // [6:0.1:12]

/* [Positions] */
PH_Y = -31;                   // [-50:0.5:10]
FLAT_Y = 4;                   // [-20:0.5:25]

/* [Edge treatment] */
ROOT_FILLET_R = 4.0;          // [0:0.5:8]
CONTACT_CHAMFER = 0.5;        // [0:0.1:1.5]

translate([0, 0, -pegboard_mount_bottom_z(PITCH, PEG_D)])
long_driver_lower_guide(
    pitch=PITCH,
    peg_d=PEG_D,
    board_geom=BOARD_GEOM,
    hook_offset=HOOK_OFFSET,
    neck_length=NECK_LENGTH,
    shelf_width=SHELF_WIDTH,
    shelf_depth=SHELF_DEPTH,
    shelf_thickness=SHELF_THICKNESS,
    tool_axis_out=TOOL_AXIS_OUT,
    ph_y=PH_Y,
    flat_y=FLAT_Y,
    ph_guide_d=PH_GUIDE_D,
    flat_guide_d=FLAT_GUIDE_D,
    root_fillet_r=ROOT_FILLET_R,
    contact_chamfer=CONTACT_CHAMFER
);
