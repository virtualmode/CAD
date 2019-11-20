// Гаражный ключ:

$fn = 50; // Разрешение поверхности.

// Основа:
module base() {
	difference() {
		union() {
			cube([32, 14, 6]);
			translate([9, -3, 0]) {
				cube([14, 20, 6]);
			}

			translate([9, -3, 3]) {
				rotate([0, 90, 0]) {
					cylinder(h = 14, r = 3);
				}
			}

			translate([9, 17, 3]) {
				rotate([0, 90, 0]) {
					cylinder(h = 14, r = 3);
				}
			}
		}
		
		translate([8, -3, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1.5);
			}
		}
		
		translate([8, 17, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1.5);
			}
		}
		
		// Отверстие для кольца 1:
		translate([5, 7, -1]) {
			cylinder(h = 6 + 2, r = 2.5);
		}
		
		// Отверстие для кольца 2:
		translate([27, 7, -1]) {
			cylinder(h = 6 + 2, r = 2.5);
		}
		
		// Буква К:
		translate([13, 2, 5]) {
			rotate([0, 0, 0]) {
				cube([2, 10, 10]);
			}
		}
		translate([18, 2, 5]) {
			rotate([0, 0, 45]) {
				cube([2, 7, 10]);
			}
		}
		translate([13, 7, 5]) {
			rotate([0, 0, -45]) {
				cube([2, 7, 10]);
			}
		}
		
		translate([-0.125, 11.87, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
			}
		}
		translate([-0.125, -2.125, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
			}
		}
		translate([32.1, -2.125, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
			}
		}
		translate([32.1, 11.87, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
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
				cylinder(h = 34, r = 1.5);
			}
		}
		
		translate([-1, -3, -1]) {
			cube([3, 6, 6 + 2]);
		}
		translate([30, -3, -1]) {
			cube([3, 6, 6 + 2]);
		}
		translate([-0.125, 0.87, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
			}
		}
		translate([32.15, 0.87, -1]) {
			rotate([0, 0, 45]) {
				cube([3, 3, 6 + 2]);
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
translate([0, 32, 0]) { baseCyl1(); }
translate([35, 3, 0]) { baseCyl2(); }
