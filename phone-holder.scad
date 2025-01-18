$fn = 20;
difference() {
    difference() {
      minkowski() {
        cube([5, 10, 2], center = true);
        sphere(1);
      }
      translate([0, 0, -2]) {
        cube([10, 12, 2], center = true);
      }
    }
    translate([-1, 3, 1]) {
        rotate([20, 0, 0]) {
            cube([10, 1.5, 3], center = true);
        };
    };
}
