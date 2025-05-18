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

module keyboard_holder() {
  difference() {
    cube(
      [
        holder_length,
        deck_width + wall_thickness * 2,
        deck_thickness + wall_thickness * 2,
      ]
    );
    translate([0, wall_thickness, wall_thickness])
      cube(
        [
          deck_length,
          deck_width,
          deck_thickness,
        ]
      );
    translate([0, wall_thickness * 2, deck_thickness + wall_thickness])
      cube(
        [
          deck_length,
          deck_width - wall_thickness * 2,
          deck_thickness,
        ]
      );
    translate([strap_thickness, 0, 0])
      cube(
        [
          holder_length - strap_thickness * 2,
          deck_width * wall_thickness * 2,
          deck_thickness - strap_thickness + wall_thickness * 2,
        ]
      );
  };
}

module deck_holder() {
  difference() {
    cube(
      [
        holder_length,
        deck_width + wall_thickness * 2,
        deck_thickness + wall_thickness * 2,
      ]
    );
    translate([0, wall_thickness, wall_thickness])
      cube(
        [
          deck_length,
          deck_width,
          deck_thickness,
        ]
      );
    translate([0, wall_thickness * 2, deck_thickness + wall_thickness])
      cube(
        [
          deck_length,
          deck_width - wall_thickness * 2,
          deck_thickness,
        ]
      );
    translate([strap_thickness, 0, 0])
      cube(
        [
          holder_length - strap_thickness * 2,
          deck_width * wall_thickness * 2,
          deck_thickness - strap_thickness + wall_thickness * 2,
        ]
      );
  };
}

