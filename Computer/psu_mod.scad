// PSU modification model.

$fn = 50;
OX = 0.01;

// PSU modification model.
// @param primary Color of the primary PCB.
// @param secondary Color of the secondary PCB.
module psu_mod(primary = [42/255, 153/255, 85/255],
	secondary = [106/255, 96/255, 84/255]) {
	difference() {
		union() {
			color(secondary) translate([0, 0, -1.5]) cube([80, 140, 1.5]);
			color(primary) translate([70, 0, 0]) cube([160, 150, 1.5]);
		}
		translate([215 + OX, -OX, -OX]) cube([15, 40, 10]);
	}
}

// Example:
psu_mod();
