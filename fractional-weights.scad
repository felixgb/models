$fn = 100;
corner_radius = 3;
width = 50;
hole_radius = 25;
wall_thickness = 2;

module profile() {
  difference() {
    offset(r=corner_radius)
      square(width, width);

    translate([wall_thickness, wall_thickness, 0])
      offset(r=corner_radius)
        square(width - wall_thickness * 2, width - wall_thickness * 2);
  }
}

module ring()
  rotate_extrude()
    translate([hole_radius + corner_radius, corner_radius, 0])
      profile();

ring();

