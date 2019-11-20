// Custom case.

use <ekwb_radiator.scad>;
use <ekwb_fan.scad>;
use <insert.scad>;
use <rod_mount.scad>;

$fn = 50;
OX = 0.01;
EKWB_RADIATOR_OFFSET = 26.0;

// Plexiglass color:
plexi = [1.0, 1.0, 1.0, 0.5];

// Light colors:
light = plexi; // Without light.
//light = [1.0, 0.0, 0.0, 0.8]; // Red light.

// Color schemes:
// Default scheme:
metal = [0.3, 0.3, 0.3]; rod = [0.3, 0.3, 0.3]; fastener = [0.8, 0.8, 0.8]; plastic = [0.4, 0.4, 0.4]; part1 = [1.0, 0.0, 0.0]; part2 = part1;
// Industrial:
//metal = [0.95, 0.54, 0.0]; rod = [0.3, 0.3, 0.3]; fastener = [0.8, 0.8, 0.8]; plastic = [0.4, 0.4, 0.4]; part1 = metal; part2 = metal;

// Case parameters:
d = 10; // Rod diameter.
y = 18.5; // Insert mount width.
diode = 3; // Diode plexi thickness.
radius = d / 2; // Rod radius.
thickness = 6; // Case plexi thickness.
paddingX = 2; // Insert mount base padding.

module mlc_140_3_28_inbound(fanColor) {
	union() {
		rotate([0, 180, 0]) {
			translate([-EKWB_RADIATOR_OFFSET -140 * 3, 0, -28 - 26 + OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
			translate([-EKWB_RADIATOR_OFFSET -140 * 2, 0, -28 - 26 + OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
			translate([-EKWB_RADIATOR_OFFSET -140 * 1, 0, -28 - 26 + OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
		}
		ekwb_radiator(140, 3, 28.0, metal, [0.0, 0.0, 0.0, 0.30], [0.8, 0.8, 0.8], [1.0, 0.86, 0.45]);
	}
}

module mlc_140_3_28_outbound(fanColor) {
	union() {
		translate([EKWB_RADIATOR_OFFSET, 0, 28 + 2 * OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
		translate([EKWB_RADIATOR_OFFSET + 140, 0, 28 + 2 * OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
		translate([EKWB_RADIATOR_OFFSET + 280, 0, 28 + 2 * OX]) ekwb_fan(140, 26.0, fanColor, fanColor);
		ekwb_radiator(140, 3, 28.0, metal, [0.0, 0.0, 0.0, 0.30], [0.8, 0.8, 0.8], [1.0, 0.86, 0.45]);
	}
}

module frame() {
	// Rods:
	color([0.3, 0.3, 0.3]) {
		translate([10 - 1, 4, 133]) rotate([-90, 0, -90]) cylinder(h = 460, r = radius);
		translate([10 - 1, 4, 7]) rotate([-90, 0, -90]) cylinder(h = 460, r = radius);
		translate([5, 4, 9]) rotate([0, 0, -90]) cylinder(h = 122, r = radius);
		translate([473, 4, 9]) rotate([0, 0, -90]) cylinder(h = 122, r = radius);
	}
	// Mounts:
	translate([484, -9.0, 146.0]) rotate([0, 90, 90]) rod_mount_nut(part1, fastener);
	translate([484, 17.0, -thickness]) rotate([0, -90, 90]) rod_mount_nut(part1, fastener);
	translate([-thickness, 17.0, 146.0]) rotate([0, 90, -90]) rod_mount_nut(part1, fastener);
	translate([-thickness, -9.0, -thickness]) rotate([0, -90, -90]) rod_mount_nut(part1, fastener);
}

// Common case module:
length = 356 + 10; // For cables.
insertLength = 2 * 18.5 + length;
caseLength = 2 * 54 + 2 * d + insertLength;
translate([thickness, 0, thickness - 2 * OX]) {
	color([0.3, 0.3, 0.3]) rotate([-90, 0, 0]) {
		translate([5, -5, -10]) cylinder(h = caseLength + 20, r = 5);
		translate([5, -135, -10]) cylinder(h = caseLength + 20, r = 5);
		translate([473, -5, -10]) cylinder(h = caseLength + 20, r = 5);
		translate([473, -135, -10]) cylinder(h = caseLength + 20, r = 5);
	}
	// Radiators with fans:
	translate([10 - 1, caseLength, OX]) rotate([90, 0, 0]) mlc_140_3_28_outbound(plastic);
	translate([10 - 1, 0, 140 + OX]) rotate([-90, 0, 0]) mlc_140_3_28_inbound(plastic);
	// Frames:
	translate([0, 55, 0]) frame();
	translate([0, 55 + 10 + insertLength, 0]) frame();
}

// Insert:
translate([thickness + d + paddingX, 54 + 10 + y / 2 - diode / 2, 73])
	insert(454, length, thickness, part2, plexi, light);

// Covers:
color([1.0, 1.0, 1.0, 0.5]) translate([OX, 0, 6]) cube([thickness - OX, caseLength, 140]);
color([1.0, 1.0, 1.0, 0.5]) translate([484, 0, 6]) cube([thickness - OX, caseLength, 140]);
color([1.0, 1.0, 1.0, 0.5]) translate([0, 0, -OX]) cube([490, caseLength, thickness - OX]);
