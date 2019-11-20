// Гаражный ключ:

$fn = 50; // Разрешение поверхности.

// Основа:
module base() {
	difference() {
		union() {
			// База 1:
            translate([0, 3, 0]) {
                cube([32, 8, 6]);
            }
            translate([0, 3, 3]) {
                rotate([0, 90, 0]) {
                    cylinder(h = 32, r = 3);
                }
            }
            translate([0, 11, 3]) {
                rotate([0, 90, 0]) {
                    cylinder(h = 32, r = 3);
                }
            }
            // База 2:            
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
        
        // Отверстие для кольца 1:
        translate([5, 7, -1]) {
            cylinder(h = 6 + 2, r = 2.5);
        }
        
        // Отверстие для кольца 2:
        translate([27, 7, -1]) {
            cylinder(h = 6 + 2, r = 2.5);
        }
		
        // Крепление крутяшки 1:
		translate([8, -3, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1.5);
			}
		}
		
        // Крепление крутяшки 2:
		translate([8, 17, 3]) {
			rotate([0, 90, 0]) {
				cylinder(h = 14 + 2, r = 1.5);
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
	cyl(hgh = 9.2, x = 3);
	cyl(hgh = 10.7, x = 17);
	cyl(hgh = 9.2, x = 29);
}

module baseCyl2() {
	baseCyl();
	cyl(hgh = 17.4, x = 3);
	cyl(hgh = 13.2, x = 17);
	cyl(hgh = 18.9, x = 29);
}

// Вся деталь:
translate([0, 6, 0]) { base(); }
translate([0, 33, 0]) { baseCyl1(); }
translate([40, 3, 0]) { baseCyl2(); }
