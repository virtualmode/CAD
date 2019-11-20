// Case insert model.

use <insert_mount.scad>;
use <motherboard.scad>;
use <psu_mod.scad>;
use <gpu.scad>;

$fn = 50;
OX = 0.01;

diode = 3; // Width of plexiglass for light. Default value is 2.
y = 18 + 0.5; // Insert mount width.
paddingX = 2; // Padding of width.
biasX = 13.4 - paddingX; // Bias to center.
biasY = y / 2 - diode / 2;

module mounts(width, height, mountColor, plexiColor) {
	translate([biasX, 0, 0]) insert_mount(mountColor, plexiColor);
	translate([biasX, height + 2 * y, 0]) mirror([0, 1, 0]) insert_mount(mountColor, plexiColor);
	translate([width - biasX, 0, 0]) mirror([1, 0, 0]) insert_mount(mountColor, plexiColor);
	translate([width - biasX, height + 2 * y, 0]) mirror([1, 0, 0]) mirror([0, 1, 0]) insert_mount(mountColor, plexiColor);
}

module base(width, height, thickness = 6, plexiColor = [192/255, 192/255, 192/255]) {
	deep = 0.2;
	mountX = 29.1;
	notchX = 33;
	color(plexiColor) difference() {
		cube([width, height + y + diode, thickness]);
		// Bevels:
		translate([-OX, biasY + diode, -OX]) rotate([0, 0, -135]) cube([y, y, thickness + 2 * OX]);
		translate([-OX, height + 2 * y, -OX]) rotate([0, 0, -135]) cube([y, y, thickness + 2 * OX]);
		translate([-OX + width, biasY + diode, -OX]) rotate([0, 0, -135]) cube([y, y, thickness + 2 * OX]);
		translate([-OX + width, height + 2 * y, -OX]) rotate([0, 0, -135]) cube([y, y, thickness + 2 * OX]);
		// Notches:
		translate([biasX + mountX, -OX, -OX]) cube([notchX, diode + deep + 2 * OX, thickness + 2 * OX]);
		translate([biasX + mountX, height + y - deep, -OX]) cube([notchX, diode + deep + 2 * OX, thickness + 2 * OX]);
		translate([width - biasX - notchX - mountX, -OX, -OX]) cube([notchX, diode + deep + 2 * OX, thickness + 2 * OX]);
		translate([width - biasX - notchX - mountX, height + y - deep, -OX]) cube([notchX, diode + deep + 2 * OX, thickness + 2 * OX]);
	}
}

// Insert model.
// @param width Whidth of the plexiglass base.
// @param height Height of the motherboard.
module insert(width = 458, height = 356, thickness = 6, mountColor = [1.0, 0.0, 0.0], plexiColor = [1.0, 1.0, 1.0, 0.5], lightColor = [1.0, 1.0, 1.0, 0.8]) {
	// PSU:
	translate([0, biasY + diode + 230, -1.5 - 5]) rotate([0, 0, -90]) psu_mod();
	// GPU:
	translate([158, biasY + diode + 236, -1.5 - 5 - OX]) {
		gpu(); // GPU 1.
		translate([0, -150, 0]) gpu(); // GPU 2.
	}
	// Motherboard:
	translate([width, biasY + diode, thickness + 5]) rotate([0, 0, 90]) motherboard();
	// Mounts:
	translate([0, -biasY, thickness / 2 + OX]) mounts(width, height, mountColor, lightColor);
	// Plexiglass:
	base(width, height, thickness, plexiColor);
}

// Example:
//insert(454, 356 + 10);

// Model for print:
base(454, 356 + 10);
