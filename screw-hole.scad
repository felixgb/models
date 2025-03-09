module screw_hole(screw_radius) {
  length = 100;
  head_radius = screw_radius * 2;
  rotate(180, [1, 0, 0]) {
    cylinder(head_radius, r1=head_radius, r2=screw_radius);
    cylinder(length, r=screw_radius);
  }
}


