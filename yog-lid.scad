$fn = 200;
lid_diameter = 35;
radius = lid_diameter / 2;
thickness = 5;
wall_height = 12;

module profile() {
  difference() {
    union() {
      minkowski() {
        square([radius - thickness / 4 + thickness / 2, wall_height]);
        circle(thickness / 4);
      }
    }
    translate([-thickness * 10, -thickness, 0])
      square(thickness * 10);
    translate([0, -thickness, 0]) {
      square([radius, wall_height + thickness]);
    }
  }
}

module lid() {
  translate([0, 0, thickness]) {
    rotate_extrude() {
      profile();
    }
  }
}

module handle() {
  handle_thickness = thickness / 2;
  translate([0, handle_thickness / 2, thickness * 2]) {
    rotate(90, [1, 0, 0]) {
      rotate_extrude(angle=180) {
        translate([thickness * 2, 0, 0]) {
          square([thickness, handle_thickness]);
        }
      }
    }
  }
}

// profile();
// handle();
translate([0, 0, wall_height + thickness + thickness / 4])
  rotate(180, [1, 0, 0])
    lid();
