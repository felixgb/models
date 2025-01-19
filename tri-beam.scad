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

num_triangles = 10;

module tri_overrun(width, height, sep) {
  truss_3d(width, height, sep, num_triangles);
  rotate(240, [1, 0, 0]) {
    translate([0, -height, 0]) {
      truss_3d(width, height, sep, num_triangles);
    }
  }
  translate([0, height, 0]) {
    rotate(120, [1, 0, 0]) {
      truss_3d(width, height, sep, num_triangles);
    }
  }
  female_end(height, sep);
  translate([width - sep / 2, 0, 0]) {
    male_end(height, sep);
  }
}

module clipping_cubes(width, height, sep) {
  translate([0, height, 0]) {
    rotate(30, [1, 0, 0]) {
      cube([width, height, height * 2]);
    }
  }
  rotate(-30, [1, 0, 0]) {
    mirror([0, 1, 0]) {
      translate([0, 0, 0]) {
        cube([width, height, height * 2]);
      }
    }
  }
  translate([0, 0, -1]) {
      cube([width, height, sep]);
  }
}

module female_end(height, sep) {
  key_size = height / 3;
  hypot = height;
  a = height / 2;
  c = sqrt(hypot * hypot - a * a);
  difference() {
    cube([sep / 2, height, height]);
    translate([sep / 2 / 2, height / 2, sep]) {
      key(height, sep);
    }
  }
}

module male_end(height, sep) {
  key_size = height / 3;
  hypot = height;
  a = height / 2;
  c = sqrt(hypot * hypot - a * a);
  thickness = sep / 2;
  cube([thickness, height, height]);
  translate([thickness * 3, height / 2, sep]) {
    difference() {
      scale([4, 0.8, 0.8]) {
        key(height, sep);
      }
      translate([-thickness, 0, thickness / 2]) {
        cube([thickness * 3, height, thickness], center = true);
      }
    }
  }
}

module key(height, sep) {
  key_size = height / 3;
  cube([sep / 2, key_size, sep], center = true);
  translate([0, 0, key_size / 2 - sep / 2]) {
    cube([sep / 2, sep, key_size], center = true);
  }
}

module go() {
  difference() {
    tri_overrun(100, 15, 3);
    clipping_cubes(100, 15, 1.5);
  }
}

go();

translate([0, 20, 0]) {
  go();
}

translate([0, 40, 0]) {
  cube([1.5, 15, 1.5]);
}

// import("tri-beam.stl");
