function centroid(p1, p2, p3) =
  [
    (p1.x + p2.x + p3.x) / 3,
    (p1.y + p2.y + p3.y) / 3
  ];

function tetrahedron_height(edge_length) = (sqrt(6) * edge_length) / 3;

module triangle(side_length) {
  half_side = side_length / 2;

  a = sqrt(side_length * side_length - half_side * half_side);

  points = [
    [0, a / 2],
    [half_side, -(a / 2)],
    [-half_side, -(a / 2)],
  ];

  c = centroid(points[0], points[1], points[2]);

  translate([-c.x, -c.y, 0]) {
    polygon(points);
  }
}

module tetrahedron(edge_length) {
  half_edge = edge_length / 2;

  a = sqrt(edge_length * edge_length - half_edge * half_edge);
  height = tetrahedron_height(edge_length);

  points = [
    [0, a / 2, 0],
    [half_edge, -(a / 2), 0],
    [-half_edge, -(a / 2), 0],
  ];

  c = centroid(points[0], points[1], points[2]);
  half_height = height / 4;
  top = [c.x, c.y, half_height];
  echo(height);
  echo(half_height);
  faces = [
    [2, 1, 0],
    [2, 3, 1],
    [0, 3, 2],
    [1, 3, 0],
  ];
  translate([-c.x, -c.y, 0]) {
    polyhedron(points = concat(points, [top]), faces = faces);
  }
}

thickness = 2;

module inner_shape(edge_length, inner_edge_length) {
  linear_extrude(thickness) {
    triangle(inner_edge_length);
  }
  translate([0, 0, thickness / 2]) {
    linear_extrude(thickness / 2) {
      triangle(inner_edge_length + thickness * 2);
    }
  }
}

module inside(edge_length, inner_edge_length) {
  difference() {
    tetrahedron(edge_length);
    translate([-(edge_length / 2), -(edge_length / 2), thickness]) {
      cube([edge_length * 2, edge_length * 2, edge_length * 2]);
    }
    inner_shape(edge_length, inner_edge_length);
    // linear_extrude(edge_length * 2) {
    //   triangle(inner_edge_length);
    // }
    // translate([0, 0, thickness / 2]) {
    //   linear_extrude(edge_length * 2) {
    //     triangle(inner_edge_length + thickness * 2);
    //   }
    // }
  }
}
// inside(50, 35);

tetrahedron(10);

module spaced() {
  for (i = [0 : 0]) {
    translate([i * 36, 0, 0]) {
      if (i % 2 == 0) {
        children();
      } else {
        mirror([0, 1, 0]) {
          children();
        }
      }
    }
  }
}

// spaced() {
// 
//   translate([0, 0, thickness]) {
//     mirror([0, 0, 1]) {
//       inner_shape(49.0, 34.0);
//     }
//   }
// }
// 
