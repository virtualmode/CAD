// Nut model.

$fn = 50;
OX = 0.01;

// 2D nut polygon.
module regular_polygon(order, r = 1) {
    angles = [for(i = [0 : order - 1]) i * (360 / order)];
    coords = [for(th = angles) [r * cos(th), r * sin(th)]];
    polygon(coords);
}

// Simple nut model.
// d - rod diameter.
// m - nut height.
// e - max outer nut diameter.
// order - nut corner count.
// material - nut color.
module nut(d = 10, m = 5, e = 20, order = 6, material = [0.8, 0.8, 0.8]) {
    color(material) difference() {
        linear_extrude(height = m) regular_polygon(order, e / 2);
        translate([0, 0, -OX]) cylinder(r = d / 2, h = m + 2 * OX);
    }
}

// Example:
nut(10, 5, 20);
