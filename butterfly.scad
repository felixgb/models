$fn = 100;
height = 130;
depth = 10;
width = 35;
half_width = width / 2;
wall_thickness = 2;
inner_gap = 0.4;
blade_width = depth - (wall_thickness * 2) - (inner_gap * 2);

radius = (width / 4) - 0.5;

// cube([width, depth, height]);
module handle_profile() {
  translate([radius, radius, 0]) {
    minkowski() {
      square(
        [
          height - (radius * 2),
          half_width - (radius * 2),
        ]
      );
      circle(radius);
    }
  }
}

module half_handle() {
  bd = half_width / 2;

  module dots() {
    num_dots = 7;
    dot_dist = floor((height - bd * 2) / num_dots);
    for (i = [1 : num_dots]) {
      translate([(dot_dist * i) + bd, bd, 0])
        cylinder(depth, r1=wall_thickness * 2, r2=wall_thickness * 2) ;
    }
  }

  difference() {
    linear_extrude(depth)
      handle_profile();

    translate([0, wall_thickness, wall_thickness])
      cube(
        [
          height - wall_thickness * 2,
          half_width - wall_thickness,
          depth - wall_thickness * 2,
        ]
      );

    translate([bd, bd, 0])
      cylinder(depth, r1=wall_thickness, r2=wall_thickness);

    translate([0, 0, wall_thickness])
      cube([bd * 2, half_width, depth - (wall_thickness * 2)]);

    dots();
  }

  translate([bd, bd, 0])
    cylinder(depth, r1=wall_thickness - inner_gap, r2=wall_thickness - inner_gap);
}

module blade() {
  difference() {
    linear_extrude(blade_width)
      translate([radius, radius, 0])
        offset(r=radius)
          square(
            [
              height - (wall_thickness + inner_gap) - radius * 2,
              half_width - radius
            ]
          );
    translate(
      [
        height - (wall_thickness + inner_gap) - radius - depth,
        0,
        blade_width
      ]
    )
      rotate(20, [0, 1, 0])
        cube([100, half_width + radius, 100]);
  }
}

module blade_profile() {
  length = 110;
  exposed = 30;
  height = 18;
  thickness = 0.5;
  hole_radius = 5.5 / 2;

  %linear_extrude(thickness) {
    difference() {
      square([length, height]);
      translate([11.5, 5.5 + hole_radius, 0])
        circle(hole_radius);
    }
  }
}

module snap_blade() {
  difference() {
    linear_extrude(blade_width)
      translate([radius, radius, 0])
        offset(r=radius)
          square(
            [
              70,
              half_width - (radius)
            ]
          );
  }
}

module half() {
  half_handle();
  translate([0, wall_thickness + inner_gap, wall_thickness + inner_gap])
    snap_blade();
}

module assemble() {
  blade_y = ((width) / 2) - (18 / 2);
  rotate(270, [0, 1, 0]) {
    difference() {
      union() {
        half();
        translate([0, inner_gap + half_width * 2, 0]) {
          // mirror([0, 1, 0]) {
          //   half();
          // }
        }
      }
      translate([12, blade_y, blade_width - 1]) {
        #blade_profile();
        translate([50, 1, -2]) cube([40, 16, 2]);
        translate([0, 0, -2]) cube([50, 18, 2]);
      }
    }
  }
}

assemble();

// module half_blade() {
//   minkowski() {
//     scale([2, 1])
//       circle(half_width);
//     square(
//       [
//         height - wall_thickness * 2,
//         0.1offsetoffset
//       ]
//     );
//   }
// }

