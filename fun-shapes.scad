module rounded_cube(x, y, z, corner_radius) {
  minkowski() {
    cube(
      [
        x - corner_radius * 2,
        y - corner_radius * 2,
        z - corner_radius * 2
      ]
    );
    sphere(corner_radius);
  }
}


module trapazoid(top, bottom, height) {
  assert(top < bottom, "top must be smaller than bottom");
  t = (bottom - top) / 2;
  points = [
    [t, height],
    [t + top, height],
    [bottom, 0],
    [0, 0],
  ];
  polygon(points);
}
