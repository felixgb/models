$fn = 50;

top_radius = 10;
bottom_radius = 20;

case_thickness = 15;
wall_thickness = 2;

gap = 0.5;
axle_radius = 4;

wheel_thickness = case_thickness - (2 * wall_thickness) - (2 * gap);

length = 35;

module case_profile() {
  translate([top_radius, bottom_radius, 0])
    hull() {
      circle(top_radius);
      translate([length, 0, 0])
        circle(bottom_radius);
    }
}

module case() {
  difference() {
    linear_extrude(case_thickness) {
      case_profile();
    }
    translate([length + top_radius, bottom_radius, 0]) {
      cylinder(case_thickness, r=(axle_radius + gap));
      translate([0, 0, wall_thickness])
        wheel_negative();
    }
  }
  translate([top_radius + length + bottom_radius - (axle_radius / 2), bottom_radius, case_thickness / 2])
    cube([axle_radius * 0.75, axle_radius * 2, case_thickness], center=true);
}

module wheel_profile_negative() {
    wheel_negative_thickness = wheel_thickness + (gap * 2);
    square([bottom_radius, wheel_negative_thickness]);
    translate([bottom_radius, wheel_negative_thickness / 2, 0]) {
      circle(wheel_thickness / 2);
      square([wall_thickness * 4, wheel_negative_thickness], center=true);
    }
}

module wheel_negative() {
  rotate_extrude()
    wheel_profile_negative();
}

module wheel_profile() {
  difference() {
    square([bottom_radius, wheel_thickness]);
    translate([bottom_radius, wheel_thickness / 2, 0]) {
      circle(wheel_thickness / 2);
      square([wall_thickness * 4, wheel_thickness], center=true);
    }
  }
}

module wheel() {
  translate([0, 0, wall_thickness + gap])
    rotate_extrude()
      wheel_profile();
  cylinder(case_thickness, r=axle_radius);
}

module hole() {
  translate([top_radius, bottom_radius, 0]) {
    cylinder(case_thickness, r=(top_radius - wall_thickness * 3));
    // translate([0, bottom_radius, case_thickness / 2])
    //   rotate(90, [1, 0, 0])
    //     cylinder(100, r=(top_radius - wall_thickness * 3));
  }
}

module assemble() {
  difference() {
    case();
    hole();
  }
  translate([length + top_radius, bottom_radius, 0])
    wheel();
}

// case();
translate([0, 0, length + top_radius + bottom_radius])
  rotate(90, [0, 1, 0]) assemble();
