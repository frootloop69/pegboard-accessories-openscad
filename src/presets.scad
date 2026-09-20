/*
  Pegboard hardware presets.
  Units: mm.

  NOTE:
  SPAMPUR_PRINTER peg diameter remains provisional until physical calibration
  of the 6.1 mm and 6.2 mm coupons is complete.
*/

PRESET_EUREKA_WORKSPACE = 0;
PRESET_SPAMPUR_PRINTER  = 1;

function board_pitch(preset) = 25.4;

function peg_diameter(preset) =
    preset == PRESET_EUREKA_WORKSPACE ? 5.5 :
    preset == PRESET_SPAMPUR_PRINTER  ? 5.8 : // provisional only
    5.5;

function hook_offset(preset) = 4.5;
function hook_neck(preset) = 0.5;
function reference_board_geometry(preset) = 5.0;
