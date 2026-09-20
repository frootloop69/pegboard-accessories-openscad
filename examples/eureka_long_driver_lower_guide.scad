include <../src/presets.scad>
use <../src/driver_station.scad>

rotate([90,0,0])
long_driver_lower_guide(
    pitch=board_pitch(PRESET_EUREKA_WORKSPACE),
    peg_d=peg_diameter(PRESET_EUREKA_WORKSPACE),
    board_geom=reference_board_geometry(PRESET_EUREKA_WORKSPACE),
    hook_offset=hook_offset(PRESET_EUREKA_WORKSPACE),
    neck_length=hook_neck(PRESET_EUREKA_WORKSPACE)
);
