$fn = 100;
height = 8;
radius = 8.2 / 2;

cylinder(r=radius, h=height);
for (i = [0 : 90 : 360]) {
  rotate(i) {
    translate([radius - 0.75, 0, 0]) {
      cylinder(r=1, h=height);
    }
  }
}
translate([0, 0, height])
  cylinder(r=radius + 1, h=0.5);
