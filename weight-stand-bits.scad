$fn = 50;
include <screw-hole.scad>

wood_length = 1000;
bottom_length = 500;

wood_x = 64;
wood_y = 39;
wood_depth = 25;
wall_thickness = 2;

bottom_angle = acos((bottom_length / 2) / wood_length);
top_angle = 2 * asin((bottom_length / 2) / wood_length);

screw_radius = 2 / 2;

module trapazoid(bottom_width, top_width, height) {
  h = bottom_width / 2;
  j = top_width / 2;
  polygon(
    [
      [0, 0],
      [bottom_width, 0],
      [h + j, height],
      [h - j, height]
    ]
  );
}

module connector(angle) {
  hypot = wood_y + wall_thickness * 2;
  theta = angle / 2;
  opp = sin(theta) * hypot;
  adj = cos(theta) * hypot;

  module top_rotatation(gap) {
    children(0);
    translate([0, gap, 0])
      rotate(angle, [-1, 0, 0])
        children(0);
  }

  module box_shape() {
    difference() {
      cube(
        [
          wood_x + wall_thickness * 2,
          wood_y + wall_thickness * 2,
          wood_depth
        ]
      );
      translate(
        [
          0,
          (wood_y + wall_thickness * 2) / 2,
          (wood_depth + wall_thickness * 2) / 2
        ]
      ) {
        rotate(90, [0, -1, 0])
          screw_hole(screw_radius);
        translate([wood_x + wall_thickness * 2, 0, 0])
          rotate(90, [0, 1, 0])
            screw_hole(screw_radius);
      }
      translate([wall_thickness, wall_thickness, wall_thickness])
        cube([wood_x, wood_y, wood_depth]);
    }
  }

  module top_inner_gap() {
    hull() {
      top_rotatation(wall_thickness) {
        cube(
          [
            wood_x + wall_thickness * 2,
            wall_thickness,
            wood_depth
          ]
        );
      }
    }
  }

  rotate(90, [0, 0, 1])
    rotate(90, [1, 0, 0])
      linear_extrude(wall_thickness)
        trapazoid(adj * 2, wall_thickness * 2, opp);
  translate([wood_x + wall_thickness, 0, 0])
    rotate(90, [0, 0, 1])
      rotate(90, [1, 0, 0])
        linear_extrude(wall_thickness)
          trapazoid(adj * 2, wall_thickness * 2, opp);

  module boxes() {
    top_rotatation(wood_y + wall_thickness * 2) {
      box_shape();
    }
    translate([0, wood_y + wall_thickness, 0])
      top_inner_gap();
  }

  rotate(angle / 2, [1, 0, 0])
    boxes();
}

connector(bottom_angle);
