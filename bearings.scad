$fn = 100;

bearing_radius = 12.5;
bearing_radius_allowance = 0.3;
num_bearings = 6;

function calculate_run_radius(num_bearings, bearing_radius) =
  bearing_radius / sin(180 / num_bearings);

r = calculate_run_radius(num_bearings, bearing_radius);

module frame() {
  translate([20, 10, 0]) {
    difference() {
      square([30, bearing_radius * 2], center=true);
      square([15, bearing_radius * 2], center=true);
    }
  }
}

module run_outline() {
  translate([0, 2.5, 0]) {
    difference() {
      frame();
      translate([20, 10, 0]) {
        circle(bearing_radius);
      }
    }
  }
}

module run() {
  rotate_extrude(angle=360) {
    translate([r - 20, 0, 0]) {
      run_outline();
    }
  }
}
run_outline();
// run();

// angle = 360 / num_bearings;
// for (i = [angle : angle : 360]) {
//   x = r * cos(i);
//   y = r * sin(i);
//   translate([x, y, bearing_radius]) {
//     #sphere(bearing_radius - bearing_radius_allowance);
//   }
// }
