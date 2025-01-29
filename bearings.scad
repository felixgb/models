$fn = 100;

module frame() {
  square([40, 20]);
  translate([20, 10, 0]) {
    difference() {
      square([40, 25], center=true);
      square([15, 25], center=true);
    }
  }
}

module run_outline() {
  translate([0, 2.5, 0]) {
    difference() {
      frame();
      translate([20, 10, 0]) {
        circle(12.5);
      }
    }
  }
}

module run() {
  rotate_extrude(angle=360) {
    square([15, 25]);
    translate([15, 0, 0]) {
      run_outline();
    }
  }
}
difference() {
  run();
  cylinder(45, r1=15, r2=15);
}
for (i = [45 : 45 : 360]) {
  x = 35 * cos(i);
  y = 35 * sin(i);
  translate([x, y, 12.5]) {
    #sphere(12.2);
  }
}
