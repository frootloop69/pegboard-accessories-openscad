include <../src/presets.scad>
use <../src/driver_station.scad>
use <../src/mount.scad>

// Production print orientation: horizontal accessory features remain
// parallel to the slicer's XY plane. The common mount/accessory bottom is
// translated exactly onto Z=0; do not rotate the model onto its side.
translate([
    0,
    0,
    -pegboard_mount_bottom_z(
        board_pitch(PRESET_EUREKA_WORKSPACE),
        peg_diameter(PRESET_EUREKA_WORKSPACE)
    )
])
fixed_driver_rack(
    pitch=board_pitch(PRESET_EUREKA_WORKSPACE),
    peg_d=peg_diameter(PRESET_EUREKA_WORKSPACE),
    board_geom=reference_board_geometry(PRESET_EUREKA_WORKSPACE),
    hook_offset=hook_offset(PRESET_EUREKA_WORKSPACE),
    neck_length=hook_neck(PRESET_EUREKA_WORKSPACE)
);
