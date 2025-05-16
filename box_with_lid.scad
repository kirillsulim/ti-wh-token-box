include <common.scad>;

box_width = 150;
box_length = 80;
box_height = 30;

cmp = [5, 2];

box_size = [box_width, box_length, box_height - lid_down_space];
compartment = [
    (box_size.x - (1 + cmp.x) * walls) / cmp.x,
    (box_size.y - (1 + cmp.y) * walls) / cmp.y,
    box_size.z - bottom
];
box = ["Box", [
    [ BOX_SIZE_XYZ, box_size ],
    [ BOX_STACKABLE_B, false ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_SHAPE_ROTATED_B, true ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_NUM_COMPARTMENTS_XY, cmp],
        [ CMP_COMPARTMENT_SIZE_XYZ, compartment ],
        [ CMP_PADDING_XY, [walls, walls]],
    ]],
    lid("", AUTO, 0, 4),
]];

data = [
    box,
];

MakeAll();
