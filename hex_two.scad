width = 4;
height = 4;
half_width = width / 2;
one_quarter_height = height * 0.25;
three_quarter_height = height * 0.75;

module hexagon(size) {
  points = [
    [half_width, 0],
    [width, one_quarter_height],
    [width, three_quarter_height],
    [half_width, height],
    [0, three_quarter_height],
    [0, one_quarter_height]
  ];
  polygon(points);
}

module inset_hexigon() {
  // #hexagon();
  // translate([-0.5, -0.5, 0]) {
  //   scale([1.25, 1.25, 1]) {
  //     hexagon();
  //   }
  // }
  difference() {
    translate([-0.5, -0.5, 0]) {
      scale([1.25, 1.25, 1]) {
        hexagon();
      }
    }
    translate([0.5, 0.5, 0]) {
      scale([0.75, 0.75, 1]) {
        hexagon();
      }
    }
  }
}

module hexagon_grid() {
  for (y = [0 : 20]) {
    if (y % 2 == 0) {
      for (x = [0 : 40]) {
        translate([x * width, (y * three_quarter_height), 0]) {
          inset_hexigon();
        }
      }
    } else {
      for (x = [0 : 39]) {
        translate([x * width + half_width, (y * three_quarter_height), 0]) {
          inset_hexigon();
        }
      }
    }
  }
}

border_thickness = 5;

// module border() {
//   difference() {
//     translate([-border_thickness, -border_thickness, 0]) {
//       square(
//         [
//           11 * width + border_thickness * 2,
//           11 * three_quarter_height + (border_thickness * 2)
//         ]
//       );
//     }
//     #translate([border_thickness, border_thickness, 0]) {
//       square(
//         [
//           11 * width - border_thickness * 2,
//           11 * three_quarter_height
//         ]
//       );
//     }
//   }
// }

module border() {
  difference() {
    square(
      [
        41 * width + border_thickness * 2,
        21 * three_quarter_height + 1 + border_thickness * 2
      ]
    );
    translate([border_thickness, border_thickness, 0]) {
      square(
        [
          41 * width,
          21 * three_quarter_height + 1
        ]
      );
    }
  }
}

module hex_grid_with_border() {
  border();
  translate([border_thickness, border_thickness, 0]) {
    hexagon_grid();
  }
}

module wall() {
  translate([0, 5, 0]) {
    rotate([90, 0, 0]) {
      linear_extrude(5) {
        hex_grid_with_border();
      }
    }
  }
}

module base() {
  cube(
    [
      41 * width + border_thickness * 2,
      41 * width + border_thickness * 2,
      //41 * three_quarter_height + 1 + border_thickness * 2,
      5
    ]
  );
}

wall();
translate([0, 41 * width + border_thickness, 0]) {
  wall();
}
translate([5, 0, 0]) {
  rotate([0, 0, 90]) {
    wall();
  }
}
translate([41 * width + border_thickness + border_thickness, 0, 0]) {
  rotate([0, 0, 90]) {
    wall();
  }
}
base();

