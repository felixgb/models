$fn = 100;
shaft_inner_diameter = 11;
shaft_flange_depth = 4;
shaft_depth = 30;

knob_outer_diameter = 45;
shaft_outer_diameter = 22.5;

module top_knob()
  translate([0, 0, shaft_depth])
    sphere(r = knob_outer_diameter / 2);

module outer()
  hull() {
    top_knob();
    cylinder(r = shaft_outer_diameter / 2, h = shaft_depth);
  }

module inner_shaft_profile(diameter, flage_depth)
  rotate(45, [0, 0, 1]) {
    circle(flage_depth);
    square(
      [diameter, flage_depth],
      center = true
    );
    square(
      [flage_depth, diameter],
      center = true
    );
  }

module outer_with_shaft() {
  difference() {
    outer();
    linear_extrude(shaft_depth)
      inner_shaft_profile(shaft_inner_diameter, shaft_flange_depth);
  }
}

// outer_with_shaft();
module glyphs() {
  text_size = 6;
  translate([0, text_size * 1.5, 0])
    text(
      "135↑",
      spacing = 1.5,
      font = "DejaVu Sans Mono",
      size = text_size,
      halign = "center",
      valign = "center"
    );
  translate([0, -text_size * 1.5, 0])
    text(
      "246R",
      spacing = 1.5,
      font = "DejaVu Sans Mono",
      size = text_size,
      halign = "center",
      valign = "center"
    );
  translate([-1.5, 0, 0])
    text(
      "├─┼─┼─┐",
      spacing = 0.75,
      font = "DejaVu Sans Mono",
      size = text_size,
      halign = "center",
      valign = "center"
    );
}

module glyphs_3d()
  intersection() {
    translate([0, 0, shaft_depth + (knob_outer_diameter / 2) - 10])
      linear_extrude(40)
        glyphs();
    top_knob();
  }

module finalize()
  color("blue")
    difference() {
      outer_with_shaft();
      glyphs_3d();
    }

color("white") glyphs_3d();
finalize();
