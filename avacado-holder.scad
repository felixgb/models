$fn = 100;
avacado_diameter = 50;
dish_diameter = 69;
corner_radius = 10;

// linear_extrude(height = 60, twist = 90, slices = 60) {
//    difference() {
//      offset(r = 10) {
//       square(20, center = true);
//      }
//      offset(r = 8) {
//        square(20, center = true);
//      }
//    }
//  }

module hexagon(center_x, center_y, size) {
  function hex_vertex(i) =
    let (angle_deg = 60 * i - 30)
      [
        round(center_x + size * cos(angle_deg)),
        round(center_y + size * sin(angle_deg))
      ];

  points = [ for (i = [1 : 6]) hex_vertex(i) ];
  polygon(points);
}

// rotate(30, [0, 0, 1])
//   difference() {
//     offset(r = 5)
//       hexagon(0, 0, 25);
//     offset(r = 4)
//       hexagon(0, 0, 25);
//   }
// cube([20, 50, 20]);

linear_extrude(2)
  difference() {
    circle((dish_diameter / 2) + 2);
    circle((dish_diameter / 2 - 2));
  }

for (a = [30 : 60 : 359])
rotate(a, [0, 0, 1])
  translate([-35, -1, 0])
    cube([6, 2, 2]);

translate([0, 0, 2])
  linear_extrude(2)
    difference() {
      circle(dish_diameter / 2);
      circle((dish_diameter / 2) - 2);
    }

linear_extrude(2)
  difference() {
    offset(r = 5)
      hexagon(0, 0, 25);
    offset(r = 3)
      hexagon(0, 0, 25);
  }

// start = (dish_diameter / 2) / 1.5;
// linear_extrude(height, twist = 120, slices = 120, scale = 1.5)
//   difference() {
//     offset(r = 10)
//       hexagon(0, 0, start);
//     offset(r = 8)
//       hexagon(0, 0, start);
//   }
