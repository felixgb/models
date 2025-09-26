$fn = 90;

h = 10;   // lifter min height
l = 150;  // lifter length
w = 23;   // lifter width
d = 450;  // disc diameter

difference() {
  translate([-w/2 - 2, -l/2, 0])
    cube([w + 1.5, l, 2.5 * h]);
  translate([-w/2, 0, d/2 + h])
    rotate([0,90,0])
      cylinder(w, d=d);
  translate([0,l * .4,0])
    cylinder(20, d=10);
}
