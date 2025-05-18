$fn = 200;

wall_t = 1;

width = 60;
depth = 40;
height = 40;
curve = 12;
handle_width = depth - (curve * 2);

module smoothed_cube(w, d, h, r)
  translate([r, r, r])
    minkowski() {
      cube([w - r * 2, d - r * 2, h - r * 2]);
      sphere(r);
    }

module scoop()
  difference() {
    smoothed_cube(width, depth, height, curve);
    translate([wall_t, wall_t, wall_t])
      smoothed_cube(width - wall_t * 2, depth - wall_t * 2, height - wall_t * 2, curve);
    translate([0, 0, height - curve])
      cube([width, depth, height]);
  }

module handle_curve()
  difference() {
    cube([handle_width, handle_width, handle_width]);
    translate([handle_width, handle_width, handle_width])
      rotate(90, [1, 0, 0])
        cylinder(handle_width, r=handle_width);
  }

module handle() {
  hull() {
    cube([handle_width, handle_width, curve]);
    translate([width * 1.5, handle_width / 2, curve / 2])
      rotate(90, [0, 1, 0])
        cylinder(handle_width, r=curve / 2);
  }
  translate([width * 1.5 + handle_width, (handle_width / 2) + curve, curve / 2])
    rotate(90, [0, 0, -1])
      hook();
}

module hook() {
  translate([-curve, 0, 0])
    sphere(curve / 2);
  rotate_extrude(180)
    translate([curve, 0, 0])
      circle(curve / 2);
}

module assemble() {
  translate([width, curve, 0])
    mirror([1, 0, 0])
      handle_curve();
  translate([width, curve, curve])
    handle_curve();
  translate([width, curve, 0])
    handle();
  scoop();
}

// hook();

assemble();
