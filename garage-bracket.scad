$fn = 25;

height = 70;
base_width = 70;
thickness = 2.5;
washer_diameter = 30;
top_width = washer_diameter;

screw_hole_diameter = 7.5;
hook_hole_diameter = 7.5;

washer_edge_spacing = thickness * 2 + washer_diameter / 2;

module side_profile() {
  points = [
    [0, 0],
    [base_width, 0],
    [top_width, height],
    [0, height],
  ];
  difference() {
    linear_extrude(thickness)
      polygon(points);

    translate([washer_edge_spacing, height - washer_edge_spacing, 0])
      hook_hole();
  }
}

module hook_hole() {
  cylinder(
    thickness,
    r1=hook_hole_diameter / 2,
    r2=hook_hole_diameter / 2
  );
}

module screw_hole() {
  cylinder(
    thickness,
    d=screw_hole_diameter
  );
}

module base() {
  difference() {
    cube([base_width * 1.5, thickness, base_width]);

    translate([(base_width / 4), thickness, (base_width / 4)])
      rotate(90, [1, 0, 0])
        screw_hole();

    translate([(base_width / 4), thickness, 3 * (base_width / 4)])
      rotate(90, [1, 0, 0])
        screw_hole();

    translate([base_width / 2, thickness, 0])
      rotate(90, [1, 0, 0])
        linear_extrude(thickness)
          polygon(
            [
              [thickness, base_width],
              [base_width, thickness],
              [base_width, base_width]
            ]
          );
  }
}

module assemble() {
  translate([-base_width / 2, 0, 0])
    base();

  translate([0, thickness, 0])
    side_profile();

  translate([thickness, thickness, 0])
    rotate(270, [0, 1, 0])
      side_profile();
}

// base();
assemble();
mirror([0, 1, 0])
  assemble();
