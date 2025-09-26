width = 155;
wall_height = 70;
wall_thickness = 1;
bar_thickness = 5;
gap_thickness = 10;
spout_gap = 110;

module bar()
  square([width, bar_thickness]);

module wall()
  cube([width, wall_thickness, wall_height]);

module outer_walls() {
  wall();
  translate([wall_thickness, 0])
    rotate(90, [0, 0, 1])
      wall();
  translate([width, 0])
    rotate(90, [0, 0, 1])
      difference() {
        wall();
        cube([spout_gap, wall_thickness, wall_height]);
      }
  translate([0, width - wall_thickness])
      wall();
}

module grid() {
  for (i = [0 : bar_thickness + gap_thickness : width])
    translate([0, i])
      bar();
}

// outer_walls();
// linear_extrude(wall_thickness) {
//   grid();
//   translate([width, 0])
//     rotate(90, [0, 0, 1])
//       grid();
// }

module drain_spout() {
  inner_width = 65;
  short_length = 60;
  long_length = 110;

  module side_profiles() {
    square([short_length, wall_thickness]);
    translate([0, inner_width + wall_thickness])
      square([long_length, wall_thickness]);
  }

  module bottom()
    linear_extrude(wall_thickness)
      hull()
        side_profiles();

  module sides()
    linear_extrude(wall_thickness + inner_width)
      side_profiles();

  bottom();
  sides();
}

drain_spout();

