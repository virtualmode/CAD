// PLX model.

$fn = 50;
OX = 0.01;

width = 48.5;
height = 30;
weight = 2.3;
hole = 2;

module plx() {
	difference() {
		union() {
			cube([width, height, weight]);
			translate([5, height, 0]) cube([33, 5, weight]);
		}
		// Bevels:
		translate([5, height, -OX]) rotate([0, 0, 45]) cube([10, 10, weight + 2 * OX]);
		translate([38, height, -OX]) rotate([0, 0, 45]) cube([10, 10, weight + 2 * OX]);
		// Holes:
		translate([13, 4, -OX]) cube([21, 22.5, 100]);
		translate([4, height - 6, - OX]) cylinder(r = hole, h = 100);
		translate([width - 4.5, 7.5, - OX]) cylinder(r = hole, h = 100);
	}
}

// Example:
plx();
