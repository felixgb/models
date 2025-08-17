$fn = 180;
use <torus.scad>;

GOUGE=1.41;

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

cylinder(3, d=14.9);
difference() {
  cylinder(30, d=23);
  translate([0,0,2]) {
    cylinder(40, d=20.2);
  }
}
translate([20/2,0,32 - 4])
  sphere(r = (GOUGE - 0.1));
translate([-20/2,0,32 - 4])
  sphere(r = (GOUGE - 0.1));
