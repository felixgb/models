module triangle(width, height) {
  points = [
    [0, 0],
    [0, height],
    [width, 0]
  ];
  polygon(points);
}

module tri_sep_square(width, height, sep_width) {
  triangle(width, height);
  translate([width + sep_width, height, 0]) {
    rotate(180) {
      triangle(width, height);
    }
  }
}

module repeating_triangles(width, height, sep_width, num_triangles) {
  assert(num_triangles % 2 == 0, "num_triangles must be even!");
  for (i = [1 : 2 : num_triangles]) {
    translate([i * (width + sep_width), 0, 0]) {
      tri_sep_square(width, height, sep_width);
      mirror([1, 0, 0]) {
        tri_sep_square(width, height, sep_width);
      }
    }
  }
}

module tri_beam(width, height, sep_width, num_triangles) {
  width_without_sep = width - (sep_width * num_triangles);
  triangle_width = width_without_sep / num_triangles;
  repeating_triangles(triangle_width, height, sep_width, num_triangles);
}

module truss(width, height, sep_width, num_triangles) {
  strut_thickness = sep_width / 2;
  beam_height = height - strut_thickness * 2;
  beam_width = width - strut_thickness * 2;
  difference() {
    square([beam_width + 2 * strut_thickness, beam_height + 2 * strut_thickness]);
    translate([strut_thickness, strut_thickness, 0]) {
      tri_beam(beam_width, beam_height, sep_width, num_triangles);
    }
  }
}

module truss_3d(width, height, sep_width, num_triangles) {
  linear_extrude(sep_width / 2) {
    truss(width, height, sep_width, num_triangles);
  }
}

module truss_beam(width, height, sep_width, num_triangles) {
  truss_3d(width, height, sep_width, num_triangles);
  translate([0, sep_width / 2, 0]) {
    rotate([90, 0, 0]) {
      truss_3d(width, height, sep_width, num_triangles);
    }
  }
  translate([0, height, height]) {
    rotate([180, 0, 0]) {
      truss_3d(width, height, sep_width, num_triangles);
    }
  }
  translate([0, height - sep_width / 2, height]) {
    rotate([270, 0, 0]) {
      truss_3d(width, height, sep_width, num_triangles);
    }
  }
}
