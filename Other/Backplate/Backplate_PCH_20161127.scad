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
		cube([10, 5, 5]);
	}
}

module skos2() {
	rotate([0, 0, 45]) {
		cube([10, 5, 5]);
	}
}

// Основа:
module base() {
	union() {
		difference() {
			translate([-1, -1, -1]) { cube([12, 70, 5]); }
			translate([6, 6, 0]) { hole(); }
			translate([6, 62, 0]) { hole(); }
			
		}
		difference() {
			translate([42, -1, -1]) { cube([12, 70, 5]); }
			translate([47, 6, 0]) { hole(); }
			translate([47, 62, 0]) { hole(); }
		}
		translate([11, -1, -1]) { cube([31, 12, 5]); }
		translate([11, 57, -1]) { cube([31, 12, 5]); }
		// Диагональ:
		translate([ 7, 14, -1]) { skos(); }
		translate([35.5, 57.5, -1]) { skos(); }
		translate([ 39, 7, -1]) { skos2(); }
		translate([ 10.5, 50.5, -1]) { skos2(); }
		/*translate([7.5, 0, 0]) {
			rotate([0, 0, 54]) {
				translate([9, 0, -1]) {
					difference() {
						cube([57.5, 10, 5]);
						translate([16.7, -1, 2.5]) {
							cube([26, 14, 4]);
						}
					}
				}
			}
		}*/
	}
}

// Деталь полностью:
union() {
	// В итоге пришлось перевернуть, чтобы при деформации,
	// изгиб был удобен для крепления:
	translate([54, 1, 4]) {
		rotate([0, 180, 0]) { base(); }
	}
}
