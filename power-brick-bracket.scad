square_monitor_brick_size = [183, 85, 30];
wall_thickness = 2;
bracket_size = 20;

module power_brick_bracket(size) {
  size_with_walls = [for (d = size) d + (wall_thickness * 2)];

  module brick_negative() {
    translate([wall_thickness, wall_thickness, wall_thickness]) {
      cube(size);
    }
  }

  module surround() {
    cube(size_with_walls);
  }

  module intersecting_blocks() {
    y_size_ratio = 6;
    y_begin = (size_with_walls.y - (size_with_walls.y / y_size_ratio) * 2) / size_with_walls.y;
    translate([-wall_thickness, size_with_walls.y / y_size_ratio, -wall_thickness]) {
      cube(
        [
          size_with_walls.x + (wall_thickness * 4),
          size_with_walls.y * y_begin,
          size_with_walls.z + (wall_thickness * 4)
        ]
      );
    }
    x_size_ratio = 28;
    x_begin = (size_with_walls.x - (size_with_walls.x / x_size_ratio) * 2) / size_with_walls.x;
    translate([size_with_walls.x / x_size_ratio, -wall_thickness, wall_thickness]) {
      cube(
        [
          size_with_walls.x * x_begin,
          size_with_walls.y + (wall_thickness * 4),
          size_with_walls.z + (wall_thickness * 4)
        ]
      );
    }
  }

  module brackets(screw_diameter=8) {
    translate([size_with_walls.x / 2 - (bracket_size / 2), -bracket_size, 0]) {
      bracket();
    }
    translate([size_with_walls.x / 2 - (bracket_size / 2), size_with_walls.y, 0]) {
      bracket();
    }
  }

  // module bracket(screw_diameter=8) {
  //   //translate([bracket_size / 2, bracket_size / 2, 0])
  //    difference() {
  //      intersection() {
  //        translate([bracket_size / 2, bracket_size / 2, 0])
  //          //cylinder(wall_thickness, bracket_size / 2, bracket_size / 2);
  //          difference() {
  //            cylinder(wall_thickness, bracket_size / 2, bracket_size / 2);
  //            translate([-(bracket_size / 2), 0, -(wall_thickness / 2)])
  //              cube([bracket_size, bracket_size / 2, wall_thickness * 2]);
  //          }
  //        cube([bracket_size, bracket_size, wall_thickness]);
  //      }
  //      screwhole(bracket_size);
  //    }
  // }

  module bracket(screw_diameter=8) {
     difference() {
       cube([bracket_size, bracket_size, wall_thickness]);
       screwhole(bracket_size);
     }
  }


  module screwhole(screw_diameter=8) {
    translate([bracket_size / 2, bracket_size / 2, 0]) {
      cylinder(wall_thickness * 4, wall_thickness, wall_thickness, center = true);
    }
  }

  module go() {
    difference() {
      difference() {
        surround();
        intersecting_blocks();
      }
      brick_negative();
    }
    brackets(6);
  }

  go();
}

power_brick_bracket(square_monitor_brick_size);
