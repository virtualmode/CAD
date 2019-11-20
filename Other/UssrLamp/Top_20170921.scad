// Верхний колпак для советской лампы:

$fn = 100; // Разрешение поверхности.

// Основа:
module base() {
	difference() {
		union() {
			difference() {
				cylinder(h = 8, r = 34);
				translate([0, 0, 5]) {
					cylinder(h = 8, r = 30.5);
				}
			}
			cylinder(h = 20, r = 28);
		}
		translate([0, 0, -1]) {
			cylinder(h = 22, r = 25);
		}
	}
}

module holes(sideHr = 3) {
	translate([20, 0, -2]) { cylinder(h = 8, r = sideHr); }
	translate([-20, 0, -2]) { cylinder(h = 8, r = sideHr); }
	translate([0, 20, -2]) { cylinder(h = 8, r = 3); }
	translate([0, -20, -2]) { cylinder(h = 8, r = 3); }
}

// Заглушка:
module cap() {
	difference() {
		difference() {
			translate([0, 0, -1]) {
                cylinder(h = 4, r = 28);
            }
			translate([20, 0, -3.6]) {
				cylinder(h = 6, d1 = 12, d2 = 1);
			}
			translate([-20, 0, -3.6]) {
				cylinder(h = 6, d1 = 12, d2 = 1);
			}
		}
		// Центральное отверстие для тумблера типа МТ-1:
		translate([0, 0, -2]) { cylinder(h = 6, r = 5.5); }
		// Отверстия для охлаждения:
		holes(2);
		rotate([0, 0, 30]) { holes(); }
		rotate([0, 0, 60]) { holes(); }
	}
}

translate([0, 0, 20]) {
    rotate([0, 180, 0]) {
        union() {
            base();
            translate([0, 0, 17]) {
                cap();
            }
        }
    }
}
