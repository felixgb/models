$fn = 100;
corner_radius = 3;
height = 38 * 2.5;
width = 38 * 2.5;
hole_radius = 25.5;
wall_thickness = 1;

// The fillable height
bottom_height = (height / 4) * 3;

outer_diameter = (hole_radius * 2) + (width * 2) - (wall_thickness * 4);
inner_diameter = (hole_radius * 2);
volume = PI * (bottom_height - wall_thickness) * (pow(outer_diameter / 2, 2) - pow(inner_diameter / 2, 2));
volume_in_ml = volume / 1000;
echo(volume_in_ml);
echo(volume_in_ml * 2);

module profile() {
  inner_width = width - corner_radius * 2;
  inner_height = height - corner_radius * 2;
  translate([corner_radius, corner_radius, 0])
    difference() {
      offset(r=corner_radius)
        square([inner_width, inner_height]);

      translate([wall_thickness, wall_thickness, 0])
        offset(r=corner_radius)
          square(
            [
              inner_width - wall_thickness * 2,
              inner_height - wall_thickness * 2
            ]
          );
    }
}

module bottom() {
  translate([wall_thickness, bottom_height - (wall_thickness), 0]) {
    square([wall_thickness, wall_thickness * 3]);
    mirror([0, 1, 0])
      triangle(wall_thickness, wall_thickness);
  }
  translate([width - wall_thickness * 2, bottom_height - (wall_thickness), 0]) {
    square([wall_thickness, wall_thickness * 3]);
    translate([wall_thickness, 0, 0])
      mirror([1, 0, 0])
        mirror([0, 1, 0])
          triangle(wall_thickness, wall_thickness);
  }

  difference() {
    profile();
    translate([0, bottom_height, 0])
      square([width, width]);
  }
}

module triangle(width, height) {
  polygon(
    [
      [0, 0],
      [width, 0],
      [0, height]
    ]
  );
}

module top() {
  difference() {
    profile();
    translate([0, 0, 0])
      square([width, bottom_height]);
  }
}

module assemble() {
  rotate_extrude()
    translate([hole_radius, 0, 0])
      bottom();
  // translate([100, 0, 0])
  // rotate_extrude()
  //   translate([hole_radius, 0, 0])
  //     top();
}

// bottom();
assemble();

