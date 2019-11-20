// ATX motherboard.

// Constants:
OX = 0.01;
pcbX = 305;
pcbY = 204;
pcbZ = 1.5;
wtxX = 356;
wtxY = 356;
ramX = 140;
ramY = 7;
ramZ = 7;

// Colors:
pcbColor = [56/255, 107/255, 172/255];
wtxColor = [100/255, 100/255, 255/255, 0.3];
metalColor = [255/255, 255/255, 255/255];
ram1Color = [238/255, 51/255, 41/255];
ram2Color = [252/255, 224/255, 57/255];
darkColor = [64/255, 64/255, 64/255];

// Modules:
module ramSlot(baseColor) {
    color(baseColor) {
        cube([140, ramY, ramZ]);
        cube([6, ramY, 17]);
        translate([ramX - 6, 0, 0]) cube([6, ramY, 17]);
    }
    color(metalColor) {
        translate([ramX - 6, 0, 17]) cube([9, ramY, 7]);
    }
    color(metalColor) {
        translate([-3, 0, 17]) cube([9, ramY, 7]);
    }
}

module pcie1() {
    color(darkColor) cube([ramY, 25, 11]);
}

module pcie16() {
    color(darkColor) cube([ramY, 90, 11]);
}

module motherboard() {
    // PCB:
	translate([wtxX - pcbX, 0, 0]) {
		color(pcbColor) cube([pcbX, pcbY, pcbZ]);
		translate([0, 0, pcbZ]) { // Place on board.

		// Periphery:
		color(metalColor) {
			translate([3, -1, 0]) {
				cube([14, 20, 28]);
				translate([14+5, 0, 0]) cube([14, 12, 30]);
				translate([(19)+14+5, 0, 0]) cube([15, 22, 27]);
				translate([(38)+15+5, 0, 0]) cube([15, 22, 27]);
				translate([(58)+15+5, 0, 0]) cube([18, 27, 31]);
				translate([(78)+18+5, 0, 0]) cube([18, 27, 31]);
				translate([(101)+18+5, 0, 0]) cube([24, 21, 35]);
			}
		}

		// RAM:
		translate([16, pcbY - 27, 0]) ramSlot(ram1Color);
		translate([16, pcbY - 27 - 2 * (ramY + 1), 0]) ramSlot(ram1Color);
		translate([16, pcbY - 27 - 1 * (ramY + 1), 0]) ramSlot(ram2Color);
		translate([16, pcbY - 27 - 3 * (ramY + 1), 0]) ramSlot(ram2Color);

		translate([159, 43, 0]) pcie16();
		translate([159 + 20 * 1, 43, 0]) pcie1();
		translate([159 + 20 * 2, 43, 0]) pcie16();
		translate([159 + 20 * 3, 43, 0]) pcie1();
		translate([159 + 20 * 4, 43, 0]) pcie16();
		translate([159 + 20 * 5, 43, 0]) pcie1();
		translate([159 + 20 * 6, 43, 0]) pcie16();

		}
	}
	// WTX preview:
	color(wtxColor) translate([0, 0, OX]) cube([wtxX, wtxY, pcbZ - 2 * OX]);
}

motherboard();
