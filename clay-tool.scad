$fn = 100;

num_horizontal_ridges = 13;
num_vertical_ridges = 20;
ridge_angle = 360 / num_horizontal_ridges;
ridge_width = 1;
ridge_depth = 15;
vert_ridge_spacing = 5.5;
inner_radius = ridge_depth - (ridge_width);

height = num_vertical_ridges * (ridge_width + vert_ridge_spacing);
wall_width = 1;

module ridges() {
  difference() {
    linear_extrude(height) {
      for (i = [0 : num_horizontal_ridges]) {
        rotate(i * ridge_angle, [0, 0, 1]) {
          translate([0, -(ridge_width / 2), 0]) {
            square([ridge_depth, ridge_width]);
          }
        }
      }
      circle(inner_radius);
    }
  }
}

module rings() {
  for (i = [0 : num_vertical_ridges]) {
    translate([0, 0, i * (ridge_width + vert_ridge_spacing)]) {
      cylinder(ridge_width, r1 = ridge_depth, r2 = ridge_depth);
    }
  }
}

difference() {
  union() {
    ridges();
    rings();
  }
  cylinder(
    height + ridge_width,
    r1 = (inner_radius - wall_width),
    r2 = (inner_radius - wall_width)
  );
}
