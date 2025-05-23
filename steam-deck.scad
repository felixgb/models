$fn = 25;
deck_width = 116.5;
deck_thickness = 19;
deck_length = 200;

keyboard_width = 120;
keyboard_thickness_front = 20;
keyboard_thickness_back = 40;
keyboard_length = 10;

holder_length = 120;

wall_thickness = 2;
strap_thickness = 10;

module clip() {
  corner_radius = 0.25;
  overhang_top = 5;
  overhang_bottom = 3.3;

  module triangle(s) polygon([[0, 0], [s, 0], [0, s]]);

  module clip_overhang() {
    triangle(overhang_top);
    mirror([0, 1, 0]) triangle(overhang_bottom);
  }

  module clip_bar() {
    translate([wall_thickness, deck_thickness, 0])
      clip_overhang();
    square([wall_thickness, deck_thickness + overhang_top]);
  }

  module clips() {
    translate([0, wall_thickness, 0]) {
      clip_bar();
      translate([deck_width + wall_thickness * 2, 0, 0])
        mirror([1, 0, 0])
          clip_bar();
    }
    square([deck_width + wall_thickness * 2, wall_thickness]);
  }

  linear_extrude(strap_thickness) clips();
}

module hinge() {
  $fn = 50;

  threshold = 0.2;

  hinge_width = 10;
  segment_count = 7;

  segment_width = hinge_width / segment_count;
  attach_length = strap_thickness * 2;

  module outer() {
    difference() {
      cylinder(r = wall_thickness * 2, h = segment_width - threshold);
      cylinder(r = wall_thickness * 1, h = segment_width - threshold);
    }
    translate([0, -(wall_thickness * 2), 0]) {
      cube([attach_length, wall_thickness, segment_width - threshold]);
    }
    difference() {
      translate([0, -(wall_thickness * 2), 0])
        cube([attach_length, wall_thickness, segment_width]);
      cylinder(r = wall_thickness * 2 + (threshold * 2), h = segment_width);
    }

    mirror([1, 0, 0])
      difference() {
        translate([0, -(wall_thickness * 2), 0])
          cube([attach_length, wall_thickness, segment_width]);
        cylinder(r = wall_thickness * 2 + threshold, h = segment_width);
      }
  }

  module outer_solid()
    cylinder(r = wall_thickness * 2, h = segment_width - threshold);

  module segment_group() {
    outer();
    outer_solid();
    translate([0, 0, segment_width])
      mirror([1, 0, 0])
        outer();
  }

  module inner()
    cylinder(r = wall_thickness * 1 - threshold, h = hinge_width);

  module assemble() {
    for (i = [0 : 2 : segment_count - 2]) {
      translate([0, 0, segment_width * i]) segment_group();
    }
    translate([0, 0, segment_width * (segment_count - 1)]) {
      outer();
      outer_solid();
    }
    inner();
  }

  translate([0, 0, wall_thickness * 2])
    rotate(90, [1, 0, 0])
      assemble();
}

module keyboard_clip() {
  width = 98;
  back_height = 13.8;
  front_height = 8;

  module blank()
    difference() {
      square([width, back_height]);
      polygon(
        [
          [0, 0],
          [width, 0],
          [width, back_height - front_height],
          [0, 0],
        ]
      );
    }

  module triangle(s) polygon([[0, 0], [s, 0], [0, s]]);

  module surround()
    polygon(
      [
        [0, 0],
        [width + wall_thickness * 2, (back_height - front_height)],
        [width + wall_thickness * 2, back_height + wall_thickness],
        [0, back_height + wall_thickness],
      ]
    );

  module assemble() {
    translate([0, back_height + wall_thickness, 0])
      triangle(wall_thickness * 2);
    translate([width + wall_thickness * 2, back_height + wall_thickness, 0])
      mirror([1, 0, 0])
        triangle(wall_thickness * 2);
    difference() {
      surround();
      translate([wall_thickness, wall_thickness, 0]) blank();
    }
  }

  linear_extrude(strap_thickness)
    assemble();
}

module angle() {
  strap_length = 80;

  module side() {
    cube([strap_length, wall_thickness * 2, wall_thickness]);
    cube([strap_length, wall_thickness, wall_thickness + strap_thickness]);
  }

  side();
  translate([strap_length, 0, 0])
    rotate(45, [0, 0, 1])
      side();

}

// angle();
// translate([0, 10, 0]) angle();
// 
mirror([1, 0, 0]) keyboard_clip();
// 
translate([30, 0, 0]) rotate(45, [0, 0, 1]) clip();
difference() {
  cube([15, 19.8, strap_thickness]);
  cube([13, 17.8, strap_thickness]);
}
translate([-102, 0, 0]) {
  cube([202, wall_thickness, strap_thickness]);
  cube([wall_thickness, 6, strap_thickness]);
}
translate([100, 0, 0])
  cube([wall_thickness, 72, strap_thickness]);

