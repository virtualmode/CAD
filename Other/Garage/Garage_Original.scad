// Гаражный ключ:

$fn = 50; // Разрешение поверхности.

// Основа:
module base() {
	difference() {
		union() {
			cube([32, 12, 6]);
			translate([9, -3, 0]) {
				cube([14, 18, 6]);
			}

			translate([9, -3, 3]) {
				rotate([0, 90, 0]) {
					cylinder(h = 14, r = 3);
				}
			}

			translate([9, 15, 3]) {
				rotate([0, 90, 0]) {
					cylinder(h = 14, r = 3);
				}
			}
		}
		
		translate([8, -3, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1);
			}
		}
		
		translate([8, 15, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1);
			}
		}
	}
}

// Основание цилиндров:
module baseCyl() {
	difference() {
		union() {
			cube([32, 8, 6]);
			translate([0, 0, 3]) {
				rotate([0, 90, 0]) {
					cylinder(h = 32, r = 3);
				}
			}
		}
		translate([9, -3, -1]) {
			cube([14, 6, 8]);
		}
		translate([-1, 0, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 34, r = 1);
			}
		}
	}
}

module cyl(hgh, x) {
	translate([x, 7, 3]) {
		rotate([-90, 0, 0]) {
			cylinder(h = hgh + 1.2, r = 2);
		}
	}
}

module baseCyl1() {
	baseCyl();
	cyl(hgh = 10.5, x = 3);
	cyl(hgh = 5, x = 17);
	cyl(hgh = 5, x = 29);
}

module baseCyl2() {
	baseCyl();
	cyl(hgh = 13.3, x = 3);
	cyl(hgh = 9, x = 17);
	cyl(hgh = 5, x = 29);
}

// Вся деталь:
translate([0, 6, 0]) { base(); }
translate([0, 33, 0]) { baseCyl1(); }
translate([40, 3, 0]) { baseCyl2(); }
