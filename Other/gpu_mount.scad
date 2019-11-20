OX = 0.01;

module lug(height = 0.3) {
	cylinder(r = 14, h = height);
}

union(){
	difference(){
		cube([100, 150, 5]);
		translate([50, 110, 0])
			sphere(40, 40, 40);
		translate([22, 10, -OX])
			cube([56, 56, 5 + 2 * OX]);
		translate([22, 50, -OX])
			cube([56, 56, 5 + 2 * OX]);
		translate([95 + OX, OX, -OX])
			cube([5, 150, 5 + 2 * OX]);
		translate([90 + OX, -OX, -OX])
			cube([10, 70, 5 + 2 * OX]);
		translate([-OX, OX, -OX])
			cube([5, 150, 5 + 2 * OX]);
		translate([-OX, -OX, -OX])
			cube([10, 70, 5 + 2 * OX]);
	}
	// Strengthening:
    translate([5,145])
        cube([90,5,5]);
	// Lugs:
	translate([14, 3, 0]) lug();
	translate([87, 3, 0]) lug();
	translate([11, 72, 0]) lug();
	translate([90, 72, 0]) lug();
	translate([6.5, 148.5, 0]) lug();
	translate([94.5, 148.5, 0]) lug();
}
