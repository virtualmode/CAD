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
			// Задаёт общую высоту конструкции:
			cylinder(h = 14.5, r = 28.5);
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
		union() {
			// Основа крышки:
			translate([0, 0, -1]) {
				cylinder(h = 4, r = 28.5);
			}
			// Выступы для крепления:
			translate([20, 0, 0]) {
				cylinder(h = 4.5, r = 5.5);
			}
			translate([-20, 0, 0]) {
				cylinder(h = 4.5, r = 5.5);
			}
		}
		// Центральное отверстие для тумблера типа МТ-1:
		translate([0, 0, -2]) { cylinder(h = 8, r = 5.5); }
		// Отверстия для охлаждения:
		holes(2);
		rotate([0, 0, 30]) { holes(); }
		rotate([0, 0, 60]) { holes(); }
	}
}

module fastener() {
	difference() {
		union() {
			cylinder(h = 20, r = 5.5);
			translate([-5.5, 0, 0]) {
				cube([11, 5.5, 20]);
			}
		}
		translate([0, 0, -1]) {
			cylinder(h = 22, r = 2);
		}
		translate([0, 0, -1]) {
			cylinder(h = 3.5, r = 4);
		}
	}
}

/*union() {
	base();
	translate([0, 0, 15.5]) {
		cap();
	}
}*/

fastener();
