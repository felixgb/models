$fn = 100;
shaft_inner_diameter = 11;
shaft_flange_depth = 4.5;
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

module inner_shaft_profile()
  rotate(45, [0, 0, 1]) {
    circle(shaft_flange_depth);
    square(
      [shaft_inner_diameter, shaft_flange_depth],
      center = true
    );
    square(
      [shaft_flange_depth, shaft_inner_diameter],
      center = true
    );
  }

module outer_with_shaft() {
  difference() {
    outer();
    linear_extrude(shaft_depth)
      inner_shaft_profile();
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
      "456R",
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

module glyphs_3d() {
  // linear_extrude(1)
  //   difference() {
  //     circle(shaft_outer_diameter / 2 - 1);
  //     inner_shaft_profile();
  //   }
  intersection() {
    translate([0, 0, shaft_depth + (knob_outer_diameter / 2) - 10])
      linear_extrude(40)
        glyphs();
    top_knob();
  }
}

module finalize()
  color("blue")
    difference() {
      outer_with_shaft();
      glyphs_3d();
    }

color("white") glyphs_3d();
finalize();

//finalize();
// outer_with_shaft();
// translate([0, 0, shaft_depth + (knob_outer_diameter / 2)])
//   #glyphs();

