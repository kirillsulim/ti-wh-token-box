include <common.scad>;

h = 41;
s1 = [36, 7, h];
s2 = [28, 16, h];
grid = [4, 5];

box_size = [(s1.x + walls) * grid.x + walls, (s2.y + walls) * grid.y + walls, h + 2 * walls];

box = ["Box", [
    [ BOX_SIZE_XYZ, box_size ],
    [ BOX_STACKABLE_B, false ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_NUM_COMPARTMENTS_XY, grid ],
        [ CMP_COMPARTMENT_SIZE_XYZ, s1],
        [ CMP_PADDING_XY, [walls, s2.y - s1.y + walls]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_NUM_COMPARTMENTS_XY, grid ],
        [ CMP_COMPARTMENT_SIZE_XYZ, s2],
        [ CMP_PADDING_XY, [s1.x - s2.x + walls, walls]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_HEIGHT_PCT, 35 ],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_COMPARTMENT_SIZE_XYZ, [box_size.x - 2 * walls, box_size.y - 2 * walls, 5]],
    ]],
    lid("WORMHOLES", AUTO, 0, 4),
    [ LABEL, [
        [LBL_TEXT, "t.me/kirillsulim"],
        [LBL_PLACEMENT, BOTTOM],
        [LBL_DEPTH, 0.6],
    ]],
]];

data = [
    box,
];

MakeAll();
