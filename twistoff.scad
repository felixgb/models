$fn = 100;

inner_diameter = 52;
inner_height = 11;
wall = 1;
thread_depth = 1.5;

difference() {
  cylinder(inner_height + wall, d=inner_diameter + wall * 2);
  translate([0, 0, wall])
    cylinder(inner_height, d=inner_diameter);
}

module circles() {
  translate([inner_diameter - thread_depth, 0, inner_height - 1])
    cylinder(wall * 2, d=inner_diameter);

  translate([-inner_diameter + thread_depth, 0, inner_height - 1])
    cylinder(wall * 2, d=inner_diameter);

  translate([0, inner_diameter - thread_depth, inner_height - 1])
    cylinder(wall * 2, d=inner_diameter);

  translate([0, -inner_diameter + thread_depth, inner_height - 1])
    cylinder(wall * 2, d=inner_diameter);

}

module threads() {
  intersection() {
    circles();

    translate([0, 0, inner_height - wall])
      cylinder(wall * 2, d=inner_diameter);
  }
}

threads();
