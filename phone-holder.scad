use <truss-beam.scad>

module phone_holder(width, height, depth) {

  module holding_bit(phone_thickness) {
    difference() {
      cube([height, width, height]);
      translate([0 - 0.1, height, 0 - 0.1]) {
        cube([height + 0.2, width - (height * 2), height + 0.2]);
      }
      translate([height / 2 - phone_thickness / 2, 0 - 0.1, height / 3]) {
        rotate([0, 20, 0]) {
          cube([phone_thickness, 100, 100]);
        }
      }
      translate([-phone_thickness, 0 - 0.1, 0]) {
        rotate([0, 20, 0]) {
          cube([phone_thickness, 100, 100]);
        }
      }
    }
  }

  holding_bit(8);
  //truss_beam(60, 20, 2, 6);
  translate([height * 2, height, 0,]) {
    rotate([0, 0, 90]) {
      truss_beam(width - height * 2, height, 2, 2);
    }
  }
  translate([height, 0, 0]) {
    truss_beam(depth, height, 2, 6);
  }
  translate([height, width - height, 0]) {
    truss_beam(depth, height, 2, 6);
  }
}

phone_holder(60, 20, 40);
