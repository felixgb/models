$fn = 100;
diameter = 6;
radius = diameter / 2;
outer_to_flat = 4.53;
depth = 6;
knob_height = 20;
knob_width = 20;

module shaft() {
  difference() {
    translate([radius, radius, 0]) {
      cylinder(depth, r = radius);
    }

    translate([0, outer_to_flat, 0 - 0.1]) {
      cube([depth, depth, depth + 0.2]);
    }
  }
}

// module centered_shaft() {
//   #translate([depth, - radius, radius]) {
//     rotate(90, [0, 0, 1]) {
//       rotate(270, [1, 0, 0]) {
//         shaft();
//       }
//     }
//   }
// }

module centered_shaft() {
  translate([0, -0, 0]) {
    rotate(90, [0, 0, 1]) {
      rotate(270, [1, 0, 0]) {
        cylinder(10, r = 9.75);
        for (i = [0:90:360])
          rotate(i, [0, 0, 1])
            translate([9.50, 0, 0.5])
              minkowski() {
                cylinder(9, r = 0.3);
                sphere(0.3);
            }
      }
    }
  }
}


module dodecahedron(size) {
    phi = (1 + sqrt(5)) / 2;

    points = [
      [1, 1, 1],
      [1, 1, -1],
      [1, -1, 1],
      [1, -1, -1],
      [-1, 1, 1],
      [-1, 1, -1],
      [-1, -1, 1],
      [-1, -1, -1],
      [0, 1 / phi, phi],
      [0, 1 / phi, -phi],
      [0, -1 / phi, phi],
      [0, -1 / phi, -phi],
      [1 / phi, phi, 0],
      [1 / phi, -phi, 0],
      [-1 / phi, phi, 0],
      [-1 / phi, -phi, 0],
      [phi, 0, 1 / phi],
      [phi, 0, -1 / phi],
      [-phi, 0, 1 / phi],
      [-phi, 0, -1 / phi]
    ];


    // for (i = [0 : len(points) - 1]) {
    //   p = points[i];
    //   translate(p * 50) {
    //     color("#0000ff") {
    //       text(str(i), size = 10);
    //     }
    //   }
    // }

    faces = [
        [8, 10, 6, 18, 4],
        [0, 16, 2, 10, 8],
        [2, 16, 17, 3, 13],
        [10, 2, 13, 15, 6],
        [15, 13, 3, 11, 7],
        [18, 6, 15, 7, 19],
        [4, 18, 19, 5, 14],
        [0, 8, 4, 14, 12],
        [0, 12, 1, 17, 16],
        [14, 5, 9, 1, 12],
        [5, 19, 7, 11, 9],
        [1, 9, 11, 3, 17],
    ];

    resize([size, 0, 0], auto = true) {
      rotate(116.565 / 2, [0, 1, 0]) {
        polyhedron(points = points, faces = faces);
      }
    }
}

translate([0, 0, 20]) {
  rotate(90, [0, 1, 0]) {
    dodecahedron(40);
      translate([-20, 0, 0]) {
        centered_shaft();
      }
    }
}


