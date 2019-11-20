// Верхний колпак для советской лампы:

$fn = 100; // Разрешение поверхности.

// Основа:
module base() {
	difference() {
		union() {
			difference() {
				cylinder(h = 8, r = 34);
				translate([0, 0, 5]) {
					cylinder(h = 8, r = 31);
				}
			}
			cylinder(h = 20, r = 28);
		}
		translate([0, 0, -1]) {
			cylinder(h = 22, r = 25.5);
		}
	}
}

module holes(sideHr = 3) {
	translate([20, 0, -1]) { cylinder(h = 8, r = sideHr); }
	translate([-20, 0, -1]) { cylinder(h = 8, r = sideHr); }
	translate([0, 20, -1]) { cylinder(h = 8, r = 3); }
	translate([0, -20, -1]) { cylinder(h = 8, r = 3); }
}

// Заглушка:
module cap() {
	difference() {
		union() {
			cylinder(h = 3, r = 28);
			translate([20, 0, 0]) {
				cylinder(h = 5, r = 5);
			}
			translate([-20, 0, 0]) {
				cylinder(h = 5, r = 5);
			}
		}
		// Центральное отверстие для тумблера типа МТ-1:
		translate([0, 0, -1]) { cylinder(h = 5, r = 5.5); }
		// Отверстия для охлаждения:
		holes(2);
		rotate([0, 0, 30]) { holes(); }
		rotate([0, 0, 60]) { holes(); }
	}
}

union() {
	base();
	translate([0, 0, 17]) {
		cap();
	}
}
