$fn = 180;
use <torus.scad>;

GOUGE=1.41;
BASE=8;

module vertical(a, h0, h1) {
  translate([0,0,BASE + 2 + 6 * h0]) {
    linear_extrude(6 * (h1 - h0)) {
      rotate([0,0,a])
      translate([0,10,0])
      circle(r = GOUGE);
    }
  }
}

module horizontal(a0, a1, h) {
  translate([0,0,BASE + 2 + 6 * h]) {
    rotate([0, 0, (a1 + a0) / 2])
      torus(GOUGE, 10, endstops = 1, angle = (a1 - a0), $fn = $fn);
  }
}

module maze() {
  horizontal(0, 120, 0);
  horizontal(60, 120, 1);
  horizontal(0, 60, 2);
  horizontal(0, 120, 3);

  vertical(0, 3, 6);
  vertical(0, 0, 2);

  vertical(60, 1, 2);

  vertical(120, 1, 3);
}

difference() {
  union() {
    cylinder(36, d=20);
    cylinder(BASE - 0.1, d=23);
  }
  translate([0,0,2]) {
    cylinder(60, d=15);
  }
  maze();
  rotate([0, 0, 180]) maze();
}
