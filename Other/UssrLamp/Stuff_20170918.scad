// Заглушки для советской лампы:

$fn = 100; // Разрешение поверхности.

// Обычная заглушка:
module stuff() {
    difference() {
        union() {
            cube([11, 11,  2]);
            translate([1.25, 1.25, 0]) {
                cube([ 8.5,  8.5, 12]);
            }
        }
        translate([-2, 5.5, 7.5]) {
            rotate([0, 90, 0]) {
                cylinder(h = 15, r = 2.5);
            }
        }
    }
}

// Заглушка для проброса провода:
module stuffWire() {
    difference() {
        union() {
            cube([11, 11,  2]);
            translate([1.25, 0, 0]) {
                cube([ 8.5,  9.75, 12]);
            }
        }
        translate([-2, 5.5, 7.5]) {
            rotate([0, 90, 0]) {
                cylinder(h = 15, r = 2.5);
            }
        }
        translate([-1, -3, 2.4]) {
            rotate([-16, 0, 0]) {
                cube([15, 3, 15]);
            }
        }
        translate([-1, -2.8, 9.3]) {
            rotate([-50, 0, 0]) {
                cube([15, 3, 15]);
            }
        }
        translate([-1, -3, 12.5]) {
            rotate([-76, 0, 0]) {
                cube([15, 3, 15]);
            }
        }
    }
}

// Все детали:
//translate([ 0,  0,  0]) { stuff(); }
//translate([ 0, 15,  0]) { stuff(); }
//translate([ 0, 30,  0]) { stuff(); }
//translate([15,  0,  0]) { stuff(); }

translate([15, 15,  0]) { stuffWire(); }
translate([15, 30,  0]) { stuffWire(); }
//translate([30,  0,  0]) { stuffWire(); }
//translate([30, 15,  0]) { stuffWire(); }
