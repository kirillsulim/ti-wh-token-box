include <common.scad>;

spacer_label_height = 12;

mtg_card = [64, 89, 0];
card_dimensions = vecsum(mtg_card, [2, 2, 0]);

label = "Label";

card_box_length = 123;
card_box_height = 60;



cb_space_z = card_box_height - bottom;
cb_angle = acos(cb_space_z / (card_dimensions.x + spacer_label_height));
cb_dead_space = cb_space_z * tan(cb_angle) - 3 * lib_walls;
cb_space = [card_dimensions.y, card_box_length - cb_dead_space, cb_space_z];
cb_off_y = cb_dead_space / 2;

card_box_size = [card_dimensions.y + 2 * lib_walls, card_box_length, card_box_height];

card_box = ["Cards catalog", [
    [ BOX_SIZE_XYZ, card_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_SHEAR, [0, cb_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, cb_space ],
        [ POSITION_XY, [0, cb_off_y]],
        [ LABEL, [
            [ LBL_TEXT, [["label"]]],
            [ LBL_PLACEMENT, BACK_WALL ],
            [ LBL_SIZE, AUTO ],
            [ LBL_DEPTH, 0.6 ]
        ]],
    ]],
    //*/
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_COMPARTMENT_SIZE_XYZ, cb_space ],
        [ CMP_PADDING_XY, [0, 100]],
        [ POSITION_XY, [0, 0]],
        [ CMP_CUTOUT_SIDES_4B, [t, f, f, f]],
        [ CMP_CUTOUT_TYPE, BOTH ],
        [ CMP_CUTOUT_WIDTH_PCT, 80 ],
        [ CMP_CUTOUT_DEPTH_PCT, 5],
    ]],/**/
    //*/
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, ROUND ],
        [ CMP_SHAPE_ROTATED_B, t ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, floor(cb_space.y / 2)]],
        [ CMP_SHEAR, [0, cb_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [cb_space.x, 1, cb_space.z + 2] ],
        [ POSITION_XY, [0 , cb_off_y]],
    ]],/**/
    no_lid(),
]];


data = [
    card_box,
];

MakeAll();
