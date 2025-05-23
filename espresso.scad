$fn = 90;

eps = 0.01;

h = 65;
d1 = 51.74 + 0.5;     // cup diameter
d2 = 18.7;            // tray hole diameter
w2 = 49.67;           // tray hole outside distance

r2 = (w2 - d2) / 2;   // tray hole offset

module main() {
  cylinder(h, d2 = w2, d1 = d1 + 2);
  for (x = [-r2, r2])
    translate([x, 0, h])
      cylinder(3, d=d2 - .2);
}

module lockring() {
  difference() {
    cylinder(4, d = d1 + 4);
    translate([0,0,-eps])
      cylinder(5, d = d1 + .2);
  }
}

// difference() {
//   main();
//   translate([0,0,-1])
//     lockring();
// }

lockring();
