$fn = 50;

segment_length = 9.7;
segment_height = 3.5;
hook_segment_width = 8.4;
bar_segment_inner_space = 9;
bar_segment_surround_width = 4.3;
bar_segment_width =
  bar_segment_inner_space + (bar_segment_surround_width * 2);
bar_radius = 0.5;

link_bar_diameter = 1;
link_bar_hole_diameter = 1.2;

segment_radius = segment_height / 2;
hook_inner_radius = 2;
hook_length = 5;
hook_thickness = 1;

module elipse_thing_profile(length, height) {
  radius = height / 2;
  hull() {
    translate([radius, radius, 0])
      circle(radius);

    translate([length - radius, radius, 0])
      circle(radius);
  }
}

module bar_hole() {
  translate([segment_radius, segment_radius, 0])
    cylinder(bar_segment_width, r1 = bar_radius, r2 = bar_radius);
}

module bar_link() {
  translate([segment_length - segment_radius, segment_radius, 0])
    cylinder(
      bar_segment_width,
      r1 = link_bar_diameter,
      r2 = link_bar_diameter
    );
}

module bar_segment_surrounds() {
  linear_extrude(bar_segment_surround_width)
    elipse_thing_profile(segment_length, segment_height);

  translate([0, 0, bar_segment_surround_width + bar_segment_inner_space])
    linear_extrude(bar_segment_surround_width)
      elipse_thing_profile(segment_length, segment_height);
}

module bar_segment() {
  bar_link();
  difference() {
    bar_segment_surrounds();
    bar_hole();
    translate([2.5, 0, 0])
      bar_hole();
  }
}

module move_hook_segment() {
  translate(
    [
      segment_length - segment_height,
      0,
      bar_segment_surround_width + (bar_segment_inner_space - hook_segment_width) / 2
    ]
  )
    children();
}

module hook_inner() {
  translate(
    [
      segment_length - hook_length - hook_thickness,
      segment_height / 2 - hook_inner_radius / 2,
      0
    ]
  ) {
    linear_extrude(hook_segment_width)
      elipse_thing_profile(hook_length, hook_inner_radius);
    translate([0, -(hook_inner_radius / 2), 0])
      cube(
        [
          hook_length * 0.5,
          hook_inner_radius,
          hook_segment_width
        ]
      );
  }
}

module hook_segment() {
  difference() {
    linear_extrude(hook_segment_width)
      elipse_thing_profile(segment_length, segment_height);
    hook_inner();
  }
}

bar_segment();
move_hook_segment() {
  difference() {
    hook_segment();
    translate([segment_radius, segment_radius, 0])
      cylinder(
        bar_segment_width,
        r1 = link_bar_hole_diameter,
        r2 = link_bar_hole_diameter
      );
  }
}
