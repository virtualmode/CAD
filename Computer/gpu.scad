// GPU model.

$fn = 50;
OX = 0.01;

// GPU model.
// @param pcb Color of the PCB.
module gpu(pcb = [236/255, 53/255, 57/255]) {
	color(pcb) union() {
		translate([0, 10, 0]) cube([300, 110, 1.5]);
		translate([300 - 85 - 45, 0, 0]) cube([85, 10, 1.5]);
	}
}

// Example:
gpu();
