$fn = 200;
include <screw-hole.scad>

screw_radius = 2.8 / 2;

length = 30;
width = 20;
thickness = 2;

module plate() {
  difference() {
    union() {
      cube([length - width / 2, width, thickness]);
      translate([length - width / 2, width / 2, 0])
        cylinder(r=width / 2, h = thickness);
    }
    translate([length / 3, width / 3, thickness])
      screw_hole(screw_radius);
    translate([(length / 3) * 2, (width / 3) * 2, thickness])
      screw_hole(screw_radius);
  }
}

module triangle(width, height)
  polygon(
    [
      [0, 0],
      [width, 0],
      [0, height]
    ]
  );

module support()
  translate([thickness, width, thickness])
    rotate(90, [1, 0, 0])
      linear_extrude(thickness)
        triangle(length - width / 2 - thickness, length - width / 2 - thickness);

module assemble() {
  plate();
  mirror([1, 0, 0])
    rotate(90, [0, -1, 0])
      plate();
  support();
}


translate([0, 0, width])
  rotate(90, [-1, 0, 0])
    assemble();
