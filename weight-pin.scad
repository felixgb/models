$fn = 100;

module negative_fillit_base(top, bottom) {
  radius = bottom - top;
  rotate_extrude()
    difference() {
      square([bottom, radius]);
      translate([bottom, radius, 0])
        circle(radius);
    };
}

module fillit_top(top, bottom) {
  radius = bottom - top;
  rotate_extrude() {
    square([top, radius]);
    translate([top, 0, 0]) {
      difference() {
        circle(radius);
        translate([-radius, -radius, 0])
          square([radius * 2, radius]);
      }
    }
  }
}

module screw_hole(screw_radius) {
  length = 100;
  head_radius = screw_radius * 2;
  rotate(180, [1, 0, 0]) {
    cylinder(head_radius, r1=head_radius, r2=screw_radius);
    cylinder(length, r=screw_radius);
  }
}

base_thickness = 5;
base_width = 63;
base_height = 80;

screw_radius = 3.5 / 2;

pin_depth = 50;
pin_radius = 25;

module base() {
  base_width_step = base_width / 4;
  base_height_step = base_height / 10;
  difference() {
    cube([base_width, base_height, base_thickness]);
    translate([base_width_step, base_height_step, base_thickness])
      screw_hole(screw_radius);
    translate([base_width_step * 3, base_height_step, base_thickness])
      screw_hole(screw_radius);
    translate([base_width_step, base_height_step * 9, base_thickness])
      screw_hole(screw_radius);
    translate([base_width_step * 3, base_height_step * 9, base_thickness])
      screw_hole(screw_radius);
  }
}

module pin() {
  negative_fillit_base(pin_radius, pin_radius + 5);
  cylinder(pin_depth, r=pin_radius);
  translate([0, 0, pin_depth])
    fillit_top(pin_radius - 5, pin_radius);
}

module assemble() {
  base();
  translate([base_width / 2, base_height / 2, base_thickness])
    pin();
}

assemble();
