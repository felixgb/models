$fn = 100;
rail_height = 21.8;
rail_width = 15.2;
wall_thickness = 3;
rail_tunnel_length = 50;
bracket_height = rail_tunnel_length + (rail_tunnel_length / 2);
screw_radius = 2;

module rail_hole(rail_width, rail_height) {
  rail_radius = rail_width / 2;
  hull() {
    translate([rail_radius, rail_radius, 0]) {
      circle(rail_radius);
    }
    translate([rail_radius, rail_height - rail_radius, 0]) {
      circle(rail_radius);
    }
  }
}

module rail_tunnel(rail_width, rail_height) {
  linear_extrude(rail_tunnel_length) {
    rail_hole(rail_width, rail_height);
  }
}

module bracket() {
  rail_radius = (rail_width + wall_thickness) / 2;
  difference() {
    linear_extrude(wall_thickness) {
      rail_hole(
        rail_width + wall_thickness,
        bracket_height,
      );
    }
    translate([rail_radius, rail_radius / 1.5, 0]) {
      cylinder(wall_thickness, r1=screw_radius, r2=screw_radius);
    }
    translate([rail_radius, bracket_height - (rail_radius / 1.5), 0]) {
      cylinder(wall_thickness, r1=screw_radius, r2=screw_radius);
    }
  }
}

module triangle(width, height) {
  points = [
    [0, 0],
    [0, height],
    [width, 0]
  ];
  polygon(points);
}

module corner_support() {
  mirror([1, 0, 0]) {
    rotate(-90, [0, 1, 0]) {
      linear_extrude(wall_thickness) {
        triangle(rail_height * 2, rail_height * 2);
      }
    }
  }
}

module block_section() {
  bracket();
  translate([0, (rail_height + wall_thickness) / 2, 0]) {
    rail_tunnel(rail_width + wall_thickness, rail_height + wall_thickness);
  }
  translate([0, rail_height + wall_thickness, 0]) {
    corner_support();
  }
}

module assemble() {
  difference() {
    block_section();
    translate([wall_thickness / 2, (rail_height + wall_thickness) / 2 + wall_thickness / 2, 0]) {
      rail_tunnel(rail_width, rail_height);
    }
    mirror([0, 0, 1]) {
      cube([100, 100, 100]);
    }
  }
}

assemble();
