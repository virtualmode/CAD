$fn = 100; // Разрешение поверхности.

module frame(h) {
	cube([1, 25, h]);
	translate([25, 0, 0]) { cube([1, 26, h]); }
	cube([25, 1, h]);
	translate([0, 25, 0]) { cube([26, 1, h]); }
}

module base() {
	union() {
		cube([26, 26, 1.2]);
		frame(2.2);
	}
}

// Деталь полностью:
difference() {
	base();
	translate([3.2, 3.2, -1]) { cube([19.6, 19.6, 4]); }
}
