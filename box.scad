$fn = 100;

width = 100;
length = 120;
height = 80;
corner_radius = 30;
thickness = 1;

module rounded_cube(x, y, z) {
  minkowski() {
    cube(
      [
        x - corner_radius * 2,
        y - corner_radius * 2,
        z - corner_radius
      ]
    );
    sphere(corner_radius);
  }
}

difference() {
  translate([corner_radius, corner_radius, corner_radius]) {
    rounded_cube(width, length, height);
  }
  translate(
    [
      corner_radius + thickness,
      corner_radius + thickness,
      corner_radius + thickness
    ]
  ) {
    rounded_cube(width - thickness * 2, length - thickness * 2, height);
  }
  translate([0, 0, height]) {
    cube([width, length, corner_radius]);
  }
}
