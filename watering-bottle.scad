$fn = 200;

include <BOSL2/std.scad>
include <BOSL2/bottlecaps.scad>

thickness = 1;
cap_height = 5;

module spout(bottom_r, top_r, height, off) {
  difference() {
    hull() {
      translate([off, 0, height - 1]) {
        rotate(30, [0, 1, 0]) {
          cylinder(1, r=top_r);
        }
      }

      cylinder(1, r=bottom_r);
    }
    hull() {
      translate([off, 0, height - 1]) {
        rotate(30, [0, 1, 0])
          cylinder(1.1, r=top_r - 1);
      }

      cylinder(1, r=bottom_r - 1);
    }
  }

  translate([off, 0, height - 1])
    rotate(30, [0, 1, 0])
      cover();

}

module cover() {
  difference() {
    cylinder(1, r=30);
    for (i = [1 : 5]) {
      for (h = [0 : (60 / i) : 360])
        rotate(h)
          translate([5 * i, 0, 0])
            cylinder(1.1, r=1);
    }
  }
}

translate([0, 0, -1]) {
  difference() {
    pco1881_cap(wall=1);
    translate([-50, -50, 0])
      cube([100, 100, 1]);
  }
}

translate([0, 0, 11.2]) {
  difference() {
    union() {
      translate([-4, 0, 20])
        rotate(70, [0, -1, 0])
          cylinder(30, r=5);
      spout(30.6 / 2, 30, 40, 30);
    }
    translate([-4, 0, 20]) {
      rotate(70, [0, -1, 0]) {
        translate([0, 0, -1])
          cylinder(35, r=4.5);
      }
    }
  }
}
