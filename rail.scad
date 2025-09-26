include <screw-hole.scad>;

$fn = 100;
wall_thickness = 2;
pipe_diameter = 15.4;
wall_standoff = 25;
screw_plate_offset = 10;
bracket_length = 20;

module screw_plate()
  translate(
    [
      wall_standoff,
      -(pipe_diameter + screw_plate_offset),
      0
    ]
  ) square([wall_thickness, pipe_diameter * 2 + screw_plate_offset * 2]);

module outer() {
  screw_plate();
  hull() {
    circle(r=wall_thickness + pipe_diameter / 2);
    translate(
      [
        wall_standoff,
        -(pipe_diameter),
        0
      ]
    ) {
      square([wall_thickness, pipe_diameter * 2]);
    }
  }
}

module with_hole() {
  difference() {
    outer();
    circle(r=pipe_diameter / 2);
  }
}

module screws() {
  module rscrew()
    rotate(90, [0, -1, 0])
      screw_hole(1.8);

  translate(
    [
      wall_standoff,
      pipe_diameter + screw_plate_offset - 5,
      5
    ]
  ) rscrew();
  translate(
    [
      wall_standoff,
      -(pipe_diameter + screw_plate_offset - 5),
      5
    ]
  ) rscrew();
  translate(
    [
      wall_standoff,
      -(pipe_diameter + screw_plate_offset - 5),
      bracket_length - 5,
    ]
  ) rscrew();
  translate(
    [
      wall_standoff,
      pipe_diameter + screw_plate_offset - 5,
      bracket_length - 5,
    ]
  ) rscrew();
}

module finish() {
  difference() {
    linear_extrude(bracket_length) {
      with_hole();
    }
    screws();
  }
}

angle = 135 - 90;

module center_screw_base() {
  translate(
    [
      wall_standoff,
      -(pipe_diameter),
      0
    ]
  ) {
    rotate(angle, [0, 0, -1])
        #square([wall_thickness, pipe_diameter * 2 + 6]);
  }
}

module center_outer() {
  hull() {
    circle(r=wall_thickness + pipe_diameter / 2);
    translate(
      [
        wall_standoff,
        -(pipe_diameter),
        0
      ]
    ) {
      rotate(angle, [0, 0, -1])
        square([wall_thickness, pipe_diameter * 2]);
    }
  }
}

module center_screws() {
  translate(
    [
      wall_standoff,
      -(pipe_diameter),
      0
    ]
  ) {
    rotate(angle, [0, 0, -1])
      rotate(90, [0, -1, 0]) {
        translate([5, pipe_diameter, 23])
          screw_hole(2);
        translate([15, pipe_diameter, 23])
          screw_hole(2);
      }
  }
}

module finish_center() {
  difference() {
    linear_extrude(20)
      difference() {
        center_outer();
        circle(r=pipe_diameter / 2);
      }
    center_screws();
  }
}



// finish_center();

finish();
