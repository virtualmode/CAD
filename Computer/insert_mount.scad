// Insert mount.

use <nut.scad>;

$fn = 50;
OX = 0.01;

plexiglass = 6.4; // Base plexiglass for mount.
diode = 3; // Width of plexiglass for light. Default value is 2.
biasX = 9.5; // Pillars bias.
alpha = 30;
beta = 90 - alpha;
height = 140 / 2; // Half of the radiator height.
x = 27 + 1.6;
y = 18 + 0.5; // Insert mount width.
z0 = height / cos(alpha);
z1 = sin(alpha) * x / cos(alpha);
z = z0 + z1;
base = x / cos(alpha);
baseOffset = z0 * cos(beta) - biasX;
plexiglassOffset = plexiglass / 2 * tan(alpha);

d = 10 + 0.2;
m = 5 + 0.9;
e = 19 + 1.0; // Nut outer radius.
s = e * cos(alpha); // Nut inner radius.
biasY = 11.7;
base = x / cos(alpha);
baseCenter = 13.3785; // Dynamic center = (base - biasX) / 2 + 2.54;
//echo(baseCenter);
ledWidth = 12.95;
ledHeight = 4.5;
ledBias = -7;
ledLength = 59;
hatDepth = 2.0;
lugdiff = 40; // Lug maximum diameter for difference.

// Pillar mount hole.
module pillar_hole(r1 = 1.5, r2 = 3.3, height = 18.5, depth = 2.0) {
	rotate([-90, 0, 0]) {
		cylinder(r = r1, h = height + 2 * OX);
		cylinder(r = r2, h = depth + 2 * OX);
		translate([0, 0, height - depth + OX])
			cylinder(r = r2, h = depth + 2 * OX);
	}
}

// Pillar.
module pillar(lug) {
	difference() {
		union() {
			translate([-biasX, 0, 0]) difference() {
				rotate([0, alpha, 0]) cube([x, y, z]);
				translate([0, -OX, 0]) cube([biasX, y + 2 * OX, 1.5 * x + 2 * OX]);
				translate([0, -OX, -1.5 * x]) cube([1.5 * x + 2 * OX, y + 2 * OX, 1.5 * x + 2 * OX]);
			}
			// Lugs for solid:
			translate([0, 0, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
			translate([30, 0, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
			// Lugs for pillars:
			translate([0, y - lug, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
			translate([30, y - lug, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
			// Lugs for plexi:
			translate([0, y / 2 - diode / 2, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
			translate([30, y / 2 - diode / 2, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
		}
		// Mounts:
		translate([baseCenter, y / 2, 0]) cylinder(r = d / 2, h = 15);
		translate([baseCenter, -OX + y / 2, biasY])
			scale([1, 0.96, 1]) // Increase side layers.
				nut(0, m, e);
		//translate([baseCenter - s / 2, -OX, biasY]) cube([s, e, m]); // TODO: Big nut hole.
		// Holes:
		translate([7.25, -OX, 7.25]) pillar_hole();
		translate([19.5, -OX, 7.25]) pillar_hole();
		translate([24.0, -OX, 7.25 + 40]) pillar_hole();
		translate([44.5, -OX, 7.25 + 40]) pillar_hole();
	}
}

// Place for leds.
module led_place() {
	translate([baseOffset - plexiglassOffset + base / 2 - 5.6 - ledBias * sin(alpha), y / 2 - diode / 2 - ledHeight + OX, ledBias * cos(alpha)])
			rotate([0, -alpha, 0])
				cube([ledWidth, ledHeight, ledLength]);
}

// Insert mount base.
module mount_base(lug) {
	difference() {
		union() {
			translate([0, 0, -height]) pillar(lug);
			translate([0, 0, height]) mirror([0, 0, 1]) pillar(lug);
			// Improvements:
			translate([baseOffset - plexiglassOffset, 0, -plexiglass / 2]) cube([plexiglass, y, plexiglass]);
			// Solid central lug:
			translate([30, 0, 0]) rotate([-90, 0, 0]) cylinder(r = 15, h = lug);
			// Plexi central lug:
			translate([30, y / 2 - diode / 2, 0]) rotate([-90, 0, 0]) cylinder(r = 15, h = lug);
		}
		// Improvements:
		pg = plexiglass + 0.2;
		translate([baseOffset + base - plexiglassOffset, -OX, -x]) cube([1.5 * x + 2 * OX, y + 2 * OX, 1.5 * x + 2 * OX]);
		translate([0, y / 2 + diode / 2, -pg / 2 - OX]) cube([base + baseOffset + plexiglassOffset, y, pg + 2 * OX]);
		// Place for leds:
		led_place();
		mirror([0, 0, 1]) led_place();
		translate([baseOffset + 6.9, y / 2 - diode / 2 - ledHeight + OX, -ledWidth / 2]) cube([ledWidth, ledHeight, ledWidth]);
		translate([baseOffset + 19, y / 2 - diode / 2 - ledHeight + OX, -plexiglass / 2]) cube([15, ledHeight, plexiglass]);
		// Additional gain:
		translate([34.5, -OX, 0]) pillar_hole();
	}
	// Solid central lug:
	translate([56, 0, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
	// Pillar lugs:
	translate([56, y - lug, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
	translate([30, y - lug, 0]) rotate([-90, 0, 0]) cylinder(r = 15, h = lug);
	// Plexi central lug:
	translate([56, y / 2 - diode / 2, 0]) rotate([-90, 0, 0]) cylinder(r = 18, h = lug);
}

// Solid mount part.
module mount_solid(lug = 0) {
	difference() {
		mount_base(lug);
		translate([-lugdiff / 2, y / 2 - diode / 2 - OX, - height - lugdiff / 2]) cube([baseOffset + base + lugdiff, y, 2 * height + lugdiff]);
	}
}

// Plexiglass mount part.
module mount_plexi(lug = 0) {
	difference() {
		mount_base(lug);
		translate([-lugdiff / 2, -OX, - height - lugdiff / 2]) cube([baseOffset + base + lugdiff, y / 2 - diode / 2, 2 * height + lugdiff]);
		translate([-lugdiff / 2, y / 2 + diode / 2, - height - lugdiff / 2]) cube([baseOffset + base + lugdiff, y, 2 * height + lugdiff]);
	}
}

// Mount pillars.
module mount_pillars(lug = 0) {
	difference() {
		mount_base(lug);
		translate([-lugdiff / 2, -OX, - height - lugdiff / 2]) cube([baseOffset + base + lugdiff, y / 2 + diode / 2 + 2 * OX, 2 * height + lugdiff]);
		// TODO: Hardcoded size and place.
		//translate([52.5, 14.65, -27]) rotate([90, 0, 0]) pillar_hole(1.5, 3.3, 54, 15.0);
	}
}

// Insert mount.
module insert_mount(mountColor = [1.0, 0.0, 0.0], plexiColor = [1.0, 1.0, 1.0, 0.8]) {
	color(mountColor) mount_solid();
	translate([2 * OX, -OX, OX]) color(plexiColor) mount_plexi();
	translate([-OX, 2 * OX, -OX]) color(mountColor) mount_pillars();
}

// Example:
//rotate([90, 0, 0]) insert_mount();
//insert_mount();
//mount_solid();

// For print:
//rotate([90, 0, 0]) mount_solid(lug = 0.3);
//translate([0, 0, -(y / 2 - diode / 2)]) rotate([90, 0, 0]) mount_plexi(lug = 0.3);
//translate([0, 0, y]) rotate([90, 0, 0]) mirror([0, 1, 0]) mount_pillars(lug = 0.3);
//pillar_hole();

// For laser:
translate([0, 0, -(y / 2 - diode / 2)]) rotate([90, 0, 0]) mount_plexi(lug = 0.0);
