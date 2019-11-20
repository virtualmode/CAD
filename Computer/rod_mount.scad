// Rod mount.

use <nut.scad>;

$fn = 50;
OX = 0.01;

// Base model for printing.
// d - rod diameter.
// m - nut height.
// e - max outer nut diameter.
// s - min outer nut diameter.
// plexiglass - plexiglass thickness.
module rod_mount(d = 10 + 0.2, m = 5 + 0.4, e = 19 + 0.2, s = 17 + 0.5, plexiglass = 6) {
	biasX = 7.25 - 5.0; // Radiator rod X bias (difference between rod radius and EKWB fan hole).
	biasY = -0.5; // Radiator rod Y bias (default ~ 3.0).
	borderX = 3.6; // Support border width.
	borderY = 3.2;
	borderZ = 3.5; // Hidden side borders.
	bulkhead = 0.0; // Bulkhead offset (default ~ 1.5).
	radius = d / 2;
	pr = plexiglass + radius;
	// Mount dimensions:
	y = plexiglass + d + biasY + m + borderY;
	x = pr + biasX + s / 2 + m + borderX + bulkhead; // Make model more square.
	z = e + 2 * borderZ;
	// Model:
	difference() { 
		union() {
			// Main model:
			difference() {
				// Base:
				cube([x, y, z]);
				// Nut places:
				translate([pr + biasX + s / 2 + bulkhead, pr - s / 2, borderZ]) difference() {
					cube([m, s, e + borderZ + OX]);
				}
				translate([pr + biasX - s / 2, plexiglass + d + biasY, borderZ]) difference() {
					cube([s + OX, m, e + borderZ + OX]);
				}
				// Rod holes:
				translate([pr, pr, -OX]) cylinder(r = radius, h = z + 2 * OX); // Side rod hole.
				translate([plexiglass - (s - d) / 2 + biasX, pr, borderZ + e / 2]) rotate([0, 90, 0]) cylinder(r = radius, h = x + 2 * OX); // Vertical rod hole.
				translate([pr + biasX, pr, borderZ + e / 2]) rotate([0, 90, 90]) cylinder(r = radius, h = y + 2 * OX); // Horizontal rod hole.
				// Bevels:
				translate([plexiglass + OX, -OX, -OX]) rotate([0, 0, 135]) cube([2 * plexiglass, 2 * plexiglass, z + 2 * OX]);
				translate([x + plexiglass / 2, y - plexiglass, -OX]) rotate([0, 0, 45]) cube([2 * plexiglass, 2 * plexiglass, z + 2 * OX]);
				// Simplification:
				translate([plexiglass, plexiglass + radius, borderZ]) cube([d, radius + OX, z]);
				translate([pr, pr, borderZ + e / 2 - radius / 1.5]) cube([s / 2 + biasX + OX, radius + OX, e]); // Overhang.
				// Stockade:
				translate([pr + biasX - s / 2, pr - OX, borderZ + e / 2 - radius / 2]) cube([s + OX, radius + 2 * OX, radius + 2 * OX]);
				translate([plexiglass + biasX - (s - d) / 2, pr - OX, borderZ + e / 2 - radius / 2]) rotate([0, 57, 0]) cube([radius + 2 * OX, radius + 2 * OX, radius + 2 * OX]);
				translate([plexiglass + biasX - (s - d) / 2, pr - OX, borderZ + e / 2 + radius / 2]) rotate([0, 90 - 57, 0]) cube([radius + 2 * OX, radius + 2 * OX, radius + 2 * OX]);
				
			}
			// Bevel stockade:
			translate([plexiglass + d - OX, pr - 2, borderZ + e / 2 + radius - 0.415]) rotate([64, 0, 0]) {
				cube([x - plexiglass - d - m - borderX + 2 * OX, borderZ + e / 2, borderZ]);
			}
		}
		// Difference for bevel stockade:
		translate([plexiglass + d - OX, pr - 2, borderZ + e / 2 + radius - 0.415]) rotate([64, 0, 0]) {
			translate([- m / 2, 0, -borderZ + OX])
				cube([x - plexiglass - d - borderX + 2 * OX, borderZ + e / 2, borderZ]);
		}
		// Cap:
		translate([0, 0, z + OX])
		cube([x, y, m]);
	}
}

// Rod mount with nuts for visualization.
module rod_mount_nut(mountColor = [1.0, 0.0, 0.0], nutColor = [0.8, 0.8, 0.8]) {
	d = 10.2; // Rod diameter for model.
	m = 5; // Nut height.
	e = 19; // Max outer nut diameter.
	order = 6;
	color(mountColor) rod_mount();
	side = 6 + d / 2;
	translate([side, side, 26.2]) nut(d, m, e, order, nutColor);
	translate([side, side, -5.0]) nut(d, m, e, order, nutColor);
	translate([30.8, side, 13.1]) rotate([0, 90, 0]) nut(d, m, e, order, nutColor);
	translate([side + 2, 29.3, 13.1]) rotate([90, 0, 0]) nut(d, m, e, order, nutColor);
}

// Example for printing:
rod_mount(); // Not inverted model.
//translate([0, 24.3, 0]) mirror([0, 1, 0]) rod_mount(); // Inverted model.

// Nuts to visualize result:
//rod_mount_nut(); // Not inverted model.
//translate([0, 24.3, 0]) mirror([0, 1, 0]) rod_mount_nut(); // Inverted model.
