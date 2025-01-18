module hexagon(center_x, center_y, size) {
  function hex_vertex(i) =
    let (angle_deg = 60 * i - 30)
      [round(center_x + size * cos(angle_deg)), round(center_y + size * sin(angle_deg))];

  points = [ for (i = [1 : 6]) hex_vertex(i) ];
  polygon(points);
}

module inset_hexagon(center_x, center_y, size, thickness) {
  difference() {
    hexagon(center_x, center_y, size + thickness);
    hexagon(center_x, center_y, size - thickness);
  }
}

module hex_grid(size) {
  thickness = 2;
  for (x = [0 : size : 50]) {
    for (y = [0 : size : 50]) {
      let (row_offset = ((y / size) % 2) * (sqrt(3) / 2) * size)
        inset_hexagon(thickness + x * sqrt(3) + row_offset, thickness + y * (3 / 2), size, thickness);
    }
  }
}

module border(size, thickness) {
  x_size = round(sqrt(3) * size * 6);
  y_size = round((sqrt(3) * size * 4.5) - thickness / 2);
  difference() {
    square([x_size + thickness, y_size + thickness], center = false);
    translate([thickness, thickness, 0]) {
      square([x_size - thickness, y_size - thickness], center = false);
    }
  }
}

border(10, 4);
hex_grid(10);
