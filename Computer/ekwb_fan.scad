// EK-Furious Vardar EVO Fan.

// Constants:
$fn = 50;
OX = 0.01;
BORDER_THICKNESS = 1.5;
HOLDER_SIDE = 11;

module holders(fanWidth) {
    holderOffset = fanWidth - HOLDER_SIDE;
    translate([0, 0, 0]) cube([HOLDER_SIDE, HOLDER_SIDE, BORDER_THICKNESS]);
    translate([0, holderOffset, 0]) cube([HOLDER_SIDE, HOLDER_SIDE, BORDER_THICKNESS]);
    translate([holderOffset, 0, 0]) cube([HOLDER_SIDE, HOLDER_SIDE, BORDER_THICKNESS]);
    translate([holderOffset, holderOffset, 0]) cube([HOLDER_SIDE, HOLDER_SIDE, BORDER_THICKNESS]);
}

module rim(fanWidth, fanHeight) {
    fanRadius = fanWidth / 2;
    translate([0, 0, 2 * BORDER_THICKNESS]) {
        union() {
            cube([HOLDER_SIDE - BORDER_THICKNESS, BORDER_THICKNESS, fanHeight - 4 * BORDER_THICKNESS]);
            cube([BORDER_THICKNESS, HOLDER_SIDE - BORDER_THICKNESS, fanHeight - 4 * BORDER_THICKNESS]);
            rotate([0, 0, 135]) translate([-0.7, -1, 0]) cube([BORDER_THICKNESS, 1.41421 * fanRadius - fanRadius - HOLDER_SIDE - 4.01, fanHeight - 4 * BORDER_THICKNESS]);
        }
    }
}

module hub(fanWidth, fanHeight, hubRadius) {
    hubHeight = 2 * BORDER_THICKNESS;
    intersection() {
        rotate([0, 0, 25]){
            cylinder(h = hubHeight, r = hubRadius);
            translate([0, hubRadius - 8 - 5, 0]) cube([fanWidth / 2, 8, hubHeight]);
            translate([-hubRadius + 5, 0, 0]) cube([8, fanWidth / 2, hubHeight]);
            translate([-fanWidth / 2, -hubRadius + 5, 0]) cube([fanWidth / 2, 8, hubHeight]);
            translate([hubRadius - 8 - 5, -fanWidth / 2, 0]) cube([8, fanWidth / 2, hubHeight]);
        }
        translate([0, 0, -OX]) cylinder(h = fanHeight + 2 * OX, r = fanWidth / 2 - 4.01);
    }
}

module rotor(fanWidth, fanHeight, hubRadius, rotorColor = [0.3, 0.3, 0.3]) {
    rotorOffset = 3 * BORDER_THICKNESS;
    difference() {
        union() {
            color(rotorColor) translate([fanWidth / 2, fanWidth / 2, rotorOffset]) cylinder(h = fanHeight - rotorOffset, r = hubRadius + 4.01);
            color(rotorColor, alpha = 0.7) translate([fanWidth / 2, fanWidth / 2, rotorOffset + 4]) cylinder(h = fanHeight - rotorOffset - 8, r = fanWidth / 2 - 4.01 * 2);
        }
        color([0.15, 0.15, 0.15]) translate([fanWidth / 2, fanWidth / 2, rotorOffset - OX]) cylinder(h = fanHeight - rotorOffset - BORDER_THICKNESS, r = hubRadius + 2);
    }
}

module ekwb_fan(fanWidth = 140.0, fanHeight = 26.0, fanColor = [0.3, 0.3, 0.3], rotorColor = [0.3, 0.3, 0.3]) {
    hubRadius = fanWidth / 5.0;
    color(fanColor) { 
        difference() {
            union() {
                difference() {
                    cube([fanWidth, fanWidth, fanHeight]);
                    translate([BORDER_THICKNESS, BORDER_THICKNESS, -OX]) cube([fanWidth - 2 * BORDER_THICKNESS, fanWidth - 2 * BORDER_THICKNESS, BORDER_THICKNESS + OX]);
                    translate([BORDER_THICKNESS, BORDER_THICKNESS, fanHeight - BORDER_THICKNESS]) cube([fanWidth - 2 * BORDER_THICKNESS, fanWidth - 2 * BORDER_THICKNESS, BORDER_THICKNESS + OX]);
                    translate([-OX, -OX, 2 * BORDER_THICKNESS]) cube([fanWidth + 2 * OX, fanWidth + 2 * OX, fanHeight - 4 * BORDER_THICKNESS]);
                }
                translate([fanWidth / 2, fanWidth / 2, 0]) cylinder(h = fanHeight, r = fanWidth / 2);
                // Holders:
                translate([0, 0, 0]) holders(fanWidth);
                translate([0, 0, fanHeight - BORDER_THICKNESS]) holders(fanWidth);
            }
            translate([fanWidth / 2, fanWidth / 2, -OX]) cylinder(h = fanHeight + 2 * OX, r = fanWidth / 2 - 4);
            // Holder holes:
            translate([7.5, 7.5, -OX]) cylinder(h = fanHeight + 2 * OX, r = 2.0);
            translate([7.5, fanWidth - 7.5, -OX]) cylinder(h = fanHeight + 2 * OX, r = 2.0);
            translate([fanWidth - 7.5, 7.5, -OX]) cylinder(h = fanHeight + 2 * OX, r = 2.0);
            translate([fanWidth - 7.5, fanWidth - 7.5, -OX]) cylinder(h = fanHeight + 2 * OX, r = 2.0);
        }
        translate([fanWidth / 2, fanWidth / 2, OX]) hub(fanWidth, fanHeight, hubRadius);
        // Additional rims:
        rimOffset = HOLDER_SIDE + 2 * BORDER_THICKNESS;
        translate([rimOffset, rimOffset, 0]) rotate([0, 0, 180]) rim(fanWidth, fanHeight);
        translate([fanWidth - rimOffset, rimOffset, 0]) rotate([0, 0, 270]) rim(fanWidth, fanHeight);
        translate([rimOffset, fanWidth - rimOffset, 0]) rotate([0, 0, 90]) rim(fanWidth, fanHeight);
        translate([fanWidth - rimOffset, fanWidth - rimOffset, 0]) rotate([0, 0, 0]) rim(fanWidth, fanHeight);
    }
    rotor(fanWidth, fanHeight, hubRadius, rotorColor);
}

// Examples:
ekwb_fan(140, 26.0, [0.3, 0.3, 0.3], [0.3, 0.3, 0.3]);
