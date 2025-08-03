$fn = 200;
gap_width = 2.5;

module shape() {
  square([100, 100]);
  translate([50, 0]) circle(r = 50);
}

module outline() {
  translate([-2 - gap_width, 20]) square([2, 30]);
  translate([-gap_width, 48]) square([gap_width, 2]);
  translate([94, 50]) square([6, 2]);
  difference() {
    shape();
    offset(delta = -2)
      shape();
    translate([0, 50])
      square([100, 100]);
  }
}

linear_extrude(8) {
  outline();
}
  // sphere(2);
