$fn = 90;

d = 51;   // frame size
h = 12;   // hole diameter
c = 51;   // clip length
C = 24;   // clip diameter
w = 5;    // body width
H = h;    // body height

union() {
  difference() {
    cube([d + 2 * w, d + 2 * w, H], center = true);
    cube([d, d, H + 1], center = true);
    translate([-d/2, 0, 0])
      cube([d, d - 8, H + 1], center = true);
  }
  translate([d / 2, 0, 0])
    rotate([0, -90, 0])
      cylinder(8, d = h);
  intersection() {
    translate([d / 2 + w, 0, 0])
        translate([0, 0, -C/2 + h/2])
          rotate([0, 90, 0])
            union() {
              cylinder(c, d = C);
              translate([0, 0, c])
                cylinder(2, d = C + 8);
            }
    translate([-150, -d / 2, -H / 2])
      cube([300, d, 2 * H]);
  }
}
