// EK-CoolStream radiator.

// Constants:
$fn = 50;
OX = 0.01;
BORDER_WIDTH = 2.5;
BORDER_THICKNESS = 1.5;
FITTING_INNER_RADIUS = 6.5;
FITTING_OUTER_RADIUS = 9.5;
EKWB_RADIATOR_OFFSET = 26.0;
HOLDER_SIDE = 10;

module holder() {
    difference() {
        cube([HOLDER_SIDE, HOLDER_SIDE, BORDER_THICKNESS]);
        translate([HOLDER_SIDE / 2, HOLDER_SIDE / 2, -OX]) cylinder(h = BORDER_THICKNESS + 2 * OX, r = 1.7);
    }
}

module holderLine(z, fanWidth, fanCount) {
    for (i = [0:fanCount - 1]) {
        translate([EKWB_RADIATOR_OFFSET + i * fanWidth, BORDER_WIDTH, z]) holder();
        translate([EKWB_RADIATOR_OFFSET + i * fanWidth, fanWidth - BORDER_WIDTH - HOLDER_SIDE, z]) holder();
        translate([EKWB_RADIATOR_OFFSET + (i + 1) * fanWidth - HOLDER_SIDE, BORDER_WIDTH, z]) holder();
        translate([EKWB_RADIATOR_OFFSET + (i + 1) * fanWidth - HOLDER_SIDE, fanWidth - BORDER_WIDTH - HOLDER_SIDE, z]) holder();
    }
}

module ekwb_radiator(fanWidth, fanCount, radiatorThickness = 28.0,
    radiatorColor = [0.3, 0.3, 0.3],
    gridColor = [0.0, 0.0, 0.0, 0.90],
    logoColor = [0.8, 0.8, 0.8],
    copperColor = [1.0, 0.86, 0.45]) {
    difference() {
        color(radiatorColor) union() {
            // Radiator:
            difference() {
                cube([fanWidth * fanCount + 40, fanWidth, radiatorThickness]);
                translate([EKWB_RADIATOR_OFFSET, BORDER_WIDTH, -OX]) cube([fanWidth * fanCount, fanWidth - BORDER_WIDTH * 2, radiatorThickness + 2 * OX]);
            }
            // Mount:
            holderLine(radiatorThickness - BORDER_THICKNESS, fanWidth, fanCount);
            holderLine(0, fanWidth, fanCount);
            // Place for inlet and outlet (calculated with fittings):
            translate([13.50, fanWidth -  32.50, OX]) { cylinder(h = radiatorThickness + 20.5, r = FITTING_OUTER_RADIUS); }
            translate([13.50, 32.50, OX]) { cylinder(h = radiatorThickness + 20.5, r = FITTING_OUTER_RADIUS); }
        }
        // Inlet and outlet:
        color(copperColor) translate([13.50, fanWidth -  32.50, OX]) { cylinder(h = radiatorThickness + 20.5 + OX, r = FITTING_INNER_RADIUS); }
        color(copperColor) translate([13.50, 32.50, OX]) { cylinder(h = radiatorThickness + 20.5 + OX, r = FITTING_INNER_RADIUS); }
    }
    // Logotype:
    color(logoColor) translate([13.50, 12.50, OX]) { cylinder(h = radiatorThickness + 0.50, r = 8.5); }
    // Grid:
    color(gridColor)
        translate([EKWB_RADIATOR_OFFSET, BORDER_WIDTH, BORDER_THICKNESS + OX + 2.0])
            cube([fanWidth * fanCount, fanWidth - BORDER_WIDTH * 2, radiatorThickness - 2 * (BORDER_THICKNESS + OX) - 4.0]);
    
}

// Examples:
ekwb_radiator(140, 3, 28.0, [0.3, 0.3, 0.3], [0.0, 0.0, 0.0, 0.90], [0.8, 0.8, 0.8], [1.0, 0.86, 0.45]); // EK-CoolStream SE 420.
