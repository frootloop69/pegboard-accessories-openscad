/*
  Eureka fixed-driver rack — Customizer-ready production script
  Units: mm.

  OpenSCAD: Window -> Customizer

  PARAMETER GUIDE

  Mount calibration
    PEG_D                Diameter of the pegboard hooks/locators. Current
                         Creality Hyper PLA Eureka calibration: 5.2.
    PITCH                Pegboard hole spacing. Eureka is 25.4 mm (1 inch).
    BOARD_GEOM           Empirical hook-geometry parameter; not literal sheet
                         thickness. Normally leave at 5.0.
    HOOK_OFFSET          Upper retaining-hook offset. Normally leave at 4.5.
    NECK_LENGTH          Straight hook-neck length. Normally leave at 0.5.

  Shelf geometry
    SHELF_WIDTH          Overall left/right width of the rack.
    SHELF_DEPTH          Distance the shelf projects from the backplate.
    SHELF_THICKNESS      Vertical thickness of the shelf.
    TOOL_AXIS_OUT        Distance from backplate face to each U-seat center.

  Tool fit
    PH_SLOT_D            Large Phillips U-slot diameter.
    FLAT_SLOT_D          Large flat-blade U-slot diameter.
    SMALL_SLOT_D         Small flat-blade U-slot diameter.

  Tool positions
    PH_Y / FLAT_Y /
    SMALL_Y              Left/right centers measured from rack centerline.
                         Negative is one side; positive is the other.

  Edge treatment
    ROOT_FILLET_R        Shelf-to-backplate reinforcing fillet radius.
    CONTACT_CHAMFER      Top inside chamfer for the two large U slots.
    SMALL_CONTACT_CHAMFER
                         Reduced chamfer for the small screwdriver slot.
*/

use <../src/driver_station.scad>
use <../src/mount.scad>

/* [Mount calibration] */
PEG_D = 5.2;                  // [4.0:0.05:7.5]
PITCH = 25.4;                 // [20:0.1:30]
BOARD_GEOM = 5.0;             // [3:0.1:7]
HOOK_OFFSET = 4.5;            // [2:0.1:7]
NECK_LENGTH = 0.5;            // [0.2:0.05:2]

/* [Shelf geometry] */
SHELF_WIDTH = 107;            // [70:1:150]
SHELF_DEPTH = 34;             // [20:1:60]
SHELF_THICKNESS = 6;          // [3:0.5:10]
TOOL_AXIS_OUT = 22.5;         // [15:0.5:40]

/* [Tool fit] */
PH_SLOT_D = 22.0;             // [18:0.1:28]
FLAT_SLOT_D = 21.5;           // [18:0.1:30]
SMALL_SLOT_D = 6.9;           // [5:0.05:9]

/* [Tool positions] */
PH_Y = -31;                   // [-50:0.5:10]
FLAT_Y = 4;                   // [-20:0.5:25]
SMALL_Y = 31;                 // [10:0.5:50]

/* [Edge treatment] */
ROOT_FILLET_R = 4.0;          // [0:0.5:8]
CONTACT_CHAMFER = 1.0;        // [0:0.1:2]
SMALL_CONTACT_CHAMFER = 0.25; // [0:0.05:0.5]

// Keep the common backplate/accessory bottom exactly on the build plane.
translate([0, 0, -pegboard_mount_bottom_z(PITCH, PEG_D)])
fixed_driver_rack(
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
    small_y=SMALL_Y,
    ph_slot_d=PH_SLOT_D,
    flat_slot_d=FLAT_SLOT_D,
    small_slot_d=SMALL_SLOT_D,
    root_fillet_r=ROOT_FILLET_R,
    contact_chamfer=CONTACT_CHAMFER,
    small_contact_chamfer=SMALL_CONTACT_CHAMFER
);
