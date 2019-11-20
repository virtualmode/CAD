$fn = 100; // Разрешение поверхности.

module hole() {
	union() {
		translate([0, 0, -2.5]) {
			cylinder(h = 3.5, r = 5);
		}
		cylinder(h = 8, r = 1.5);
	}
}

module skos() {
	rotate([0, 0, -45]) {
		cube([10, 4, 5]);
	}
}

module skos2() {
	rotate([0, 0, 45]) {
		cube([10, 4, 5]);
	}
}

// Основа:
module base() {
	union() {
		difference() {
			translate([-1, -1, -1]) { cube([12, 53, 5]); }
			translate([6, 6, 0]) { hole(); }
			//translate([6, 45, 0]) { hole(); }
			
		}
		difference() {
			translate([19, -1, -1]) { cube([12, 53, 5]); }
			//translate([24, 6, 0]) { hole(); }
			translate([24, 45, 0]) { hole(); }
		}
		translate([11, -1, -1]) { cube([8, 12, 5]); }
		translate([11, 40, -1]) { cube([8, 12, 5]); }
		// Диагональ:
		translate([ 7, 14, -1]) { skos(); }
		translate([13.2, 41.2, -1]) { skos(); }
	}
}

// Деталь полностью:
union() {
	translate([1, 1, 1]) {
		difference() {
			base();
			// Место под верхние резисторы:
			translate([-2, 10, 2]) { cube([7, 31, 3]); }
			// Центральные резисторы:
			translate([7, 10, 2]) { cube([21, 31, 3]); }
		}
	}
}
