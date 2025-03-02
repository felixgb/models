$fn = 100;

// height is 2 * bearing_radius
bearing_radius = 5;
bearing_radius_allowance = 0.8;
num_bearings = 25;
wall_thickness = 1;

function calculate_run_radius(num_bearings, bearing_radius) =
  bearing_radius / sin(180 / num_bearings);

r = calculate_run_radius(num_bearings, bearing_radius);

module frame() {
  translate([bearing_radius * 2, bearing_radius, 0]) {
    difference() {
      square([bearing_radius * 2 + wall_thickness * 2, bearing_radius * 2], center=true);
      square([bearing_radius, bearing_radius * 2], center=true);
    }
  }
}

module run_outline() {
  translate([0, 0, 0]) {
    difference() {
      frame();
      translate([bearing_radius * 2, bearing_radius, 0]) {
        circle(bearing_radius);
      }
    }
  }
}

module run() {
  rotate_extrude(angle=360) {
    translate([r - (bearing_radius * 2), 0, 0]) {
      run_outline();
    }
  }
}
// run_outline();
run();

angle = 360 / num_bearings;
for (i = [angle : angle : 360]) {
  x = r * cos(i);
  y = r * sin(i);
  translate([x, y, bearing_radius]) {
    #sphere(bearing_radius - bearing_radius_allowance);
  }
}
