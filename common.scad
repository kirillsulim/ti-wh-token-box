/*
  https://github.com/dppdppd/The-Boardgame-Insert-Toolkit 
 */
include <vendor/boardgame_insert_toolkit_lib.3.scad>;
include <vendor/bit_functions_lib.3.scad>;

nozzle = 0.4;
walls = nozzle * 3;
lib_walls = 1.8;
bottom = 1.6;

lid_down_space = 3.5;
common_fr = 8;

function vecsum(a, b) = 
    [a.x + b.x, a.y + b.y, a.z + b.z];

function cumsum(v) = 
    [for (a = [0, 0, 0], i = 0; i < len(v); a = vecsum(a, v[i]), i = i+1) vecsum(a, v[i])];
        
function cmp_offset(cmp_arr, i) = 
    i == 0? [0, 0] : [cumsum(cmp_arr)[i - 1].x + i * walls, 0];
    
function cmp_offset_y(cmp_arr, i) = 
    i == 0? [0, 0] : [0, cumsum(cmp_arr)[i - 1].y + i * walls];

function lid(text = "", lbl_size = AUTO, angle = 0, lid_rad = 6) = 
    let (lid_pattern_n = 6)
    let (lid_p_thick = 1)
    len(text) == 0 ? 
        [ BOX_LID, [
            [LID_PATTERN_RADIUS, lid_rad],
            [ LID_PATTERN_THICKNESS, lid_p_thick],
            [ LID_PATTERN_N1, lid_pattern_n ],
            [ LID_PATTERN_N2, lid_pattern_n ],
            [ LID_INSET_B, true],
            [ LID_FIT_UNDER_B, t ],
        ]]
    :
        [BOX_LID, [
            [LID_PATTERN_RADIUS, lid_rad],
            [ LID_PATTERN_THICKNESS, lid_p_thick],
            [ LID_PATTERN_N1, lid_pattern_n ],
            [ LID_PATTERN_N2, lid_pattern_n ],
            [ LID_INSET_B, true],
            [ LID_FIT_UNDER_B, t ],
            [ LABEL, [
                 [ LBL_TEXT, text ],
                 [ LBL_FONT, d_font ],
                 [ LBL_SIZE, lbl_size ],
                 [ ROTATION, angle ],
            ]],
            [LID_LABELS_INVERT_B, f],
            [ LID_STRIPE_WIDTH, 1,2 ],
        ]]
;


function no_lid() = 
    [ BOX_NO_LID_B, true ];
    
function label(text, angle = -90, size = AUTO) = 
    [ LABEL, [
        [ LBL_TEXT, text],
        [ LBL_FONT, d_font ],
        [ LBL_PLACEMENT, CENTER ],
        [ LBL_SIZE, size ],
        [ LBL_DEPTH, 0.6 ],
        [ ROTATION, angle ],
        [ POSITION_XY, [0, 0]], 
        [ ENABLED_B, heavy_enabled ],
    ]];
    
function cmp_a(cmp) =
    atan(cmp.y / cmp.x);
    