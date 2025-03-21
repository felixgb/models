$fn = 100;

use <fun-shapes.scad>;
use <truss-beam.scad>;

slot_depth = 5;
corner_radius = 2;
wall_thickness = 1;

slot_width_basis = 30;

module slotted_open_front(width, depth, height) {

  module top_female_slot() {
    n_slots = width / slot_width_basis;
    for (i = [0 : n_slots - 1]) {
      translate([(i * slot_width_basis) + slot_depth * 2, depth + corner_radius, height])
        rotate(90, [1, 0, 0])
          linear_extrude(depth)
            trapazoid(
              slot_width_basis - slot_depth * 5,
              slot_width_basis - slot_depth * 4,
              slot_depth / 2
            );
    }
  }

  module left_female_slot() {
    n_slots = height / slot_width_basis;
    for (i = [0 : n_slots - 1]) {
      translate([slot_depth / 2, depth + corner_radius, (i * slot_width_basis) + slot_depth * 2.5])
        rotate(270, [0, 1, 0])
          rotate(90, [1, 0, 0])
            linear_extrude(depth)
              trapazoid(
                slot_width_basis - slot_depth * 5,
                slot_width_basis - slot_depth * 4,
                slot_depth / 2
              );
    }
  }

  module right_male_slot() {
    n_slots = height / slot_width_basis;
    for (i = [0 : n_slots - 1]) {
      translate([width + slot_depth / 2 - 0.5, depth, (i * slot_width_basis) + slot_depth * 2.5 + 0.5])
        rotate(270, [0, 1, 0])
          rotate(90, [1, 0, 0])
            linear_extrude(depth - corner_radius)
              trapazoid(
                slot_width_basis - slot_depth * 5 - 1,
                slot_width_basis - slot_depth * 4 - 1,
                slot_depth / 2 - 0.5
              );
    }
  }

  module bottom_male_slot() {
    n_slots = width / slot_width_basis;
    for (i = [0 : n_slots - 1]) {
      translate([(i * slot_width_basis) + slot_depth * 2 + 0.5, depth, 0.5])
        rotate(90, [1, 0, 0])
          linear_extrude(depth - corner_radius)
            trapazoid(
              slot_width_basis - slot_depth * 5 - 1,
              slot_width_basis - slot_depth * 4 - 1,
              slot_depth / 2 - 0.5
            );
    }
  }

  module profile() {
    minkowski() {
      square([width - corner_radius * 2, height - corner_radius * 2]);
      circle(corner_radius);
    }
  }

  module outer_box() {
    translate([corner_radius, depth, corner_radius + slot_depth / 2])
      rotate(90, [1, 0, 0])
        linear_extrude(depth)
          profile();
  }

  module inner_box() {
    translate(
      [
        slot_depth / 2 + wall_thickness,
        0,
        slot_depth / 2 + wall_thickness,
      ]
    )
      cube(
        [
          width - (slot_depth / 2) - wall_thickness * 2,
          depth - 1,
          height - (slot_depth / 2) - wall_thickness * 2,
        ]
      );
  }

  right_male_slot();
  bottom_male_slot();
  difference() {
    outer_box();
    inner_box();
    top_female_slot();
    left_female_slot();
  }
}

angled_stand_depth = 120;
angled_stand_width = 30;

module angled_stand() {
  module top_rail() {
    n_slots = angled_stand_width / slot_width_basis;
    for (i = [0 : n_slots - 1]) {
      translate([(i * slot_width_basis) + slot_depth * 2 + 0.5, corner_radius, 30 + slot_depth / 2 - 0.5])
        rotate(270, [1, 0, 0])
          linear_extrude(angled_stand_depth - corner_radius)
            trapazoid(
              slot_width_basis - slot_depth * 5 - 1,
              slot_width_basis - slot_depth * 4 - 1,
              slot_depth / 2 - 0.5
            );
    }
  }

  difference() {
    rotate(-12, [1, 0, 0]) {
      translate([0, 0, 30 - slot_depth / 2])
        cube([angled_stand_width, angled_stand_depth, slot_depth / 2]);
      top_rail();
      translate([10, 0, 0])
        rotate(270, [0, 1, 0])
          truss_beam(30 - slot_depth / 2, 10, 2, 4);
      cube([10, 10, slot_depth]);
      translate([angled_stand_width, 0, 0])
        rotate(270, [0, 1, 0])
          truss_beam(30 - slot_depth / 2, 10, 2, 4);
      translate([angled_stand_width - 10, 0, 0])
        cube([10, 10, slot_depth]);
    }
    mirror([0, 0, 1])
      cube([angled_stand_width, angled_stand_depth + 20, 30]);
  }

}

// angled_stand();
slotted_open_front(30, 120, 90);
