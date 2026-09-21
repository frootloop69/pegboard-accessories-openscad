/*
  Pegboard hardware presets.
  Units: mm.

  NOTE:
  SPAMPUR_PRINTER peg diameter remains provisional.
  5.8 mm fits easily and 6.2 mm remains loose; 6.8/6.9/7.0 mm tests are pending.
*/

PRESET_EUREKA_WORKSPACE = 0;
PRESET_SPAMPUR_PRINTER  = 1;

function board_pitch(preset) = 25.4;

// Eureka production default is calibrated for Creality Hyper PLA in the
// repository-standard axis-aligned print orientation.
function peg_diameter(preset) =
    preset == PRESET_EUREKA_WORKSPACE ? 5.2 :
    preset == PRESET_SPAMPUR_PRINTER  ? 6.2 : // latest tested value; still loose
    5.2;

function hook_offset(preset) = 4.5;
function hook_neck(preset) = 0.5;
function reference_board_geometry(preset) = 5.0;
