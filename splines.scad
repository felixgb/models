points3d = [
  [0, 0, -10],
  [0, 0, 0],
  [140, -40, 180],
  [140, -40, 200],
];


downpipe_size = 70;
gutter_size = 50;

module downpipe_connector() {
  bottom = points3d[len(points3d) - 2];
  translate(bottom) {
    translate([0, 0, 20]) {
      difference() {
        linear_extrude(20)
          difference() {
            square([downpipe_size + 2, downpipe_size + 2], center = true);
            square([downpipe_size, downpipe_size], center = true);
          }
          translate([0, -(downpipe_size / 2) - 2, 10])
            rotate(90, [0, 0, 1])
              rotate(90, [0, 1, 0])
                cylinder(r = 1.5, h = 4);
        }
      }
    difference() {
      hull() {
        translate([0, 0, 20])
          cube([downpipe_size + 2, downpipe_size + 2, 0.01], center = true);
        cube([gutter_size + 2, gutter_size + 2, 0.01], center = true);
      }
      hull() {
        translate([0, 0, 20])
          cube([downpipe_size, downpipe_size, 0.01], center = true);
        cube([gutter_size, gutter_size, 0.01], center = true);
      }
    }
  }
}

downpipe_connector();

function sliding_2(xs) =
  [for (i = [0 : len(xs) - 2]) [xs[i], xs[i + 1]]];

function sliding_3(xs) =
  [for (i = [0 : len(xs) - 3]) [xs[i], xs[i + 1], xs[i + 2]]];

function sliding_4(xs) =
  [for (i = [0 : len(xs) - 4]) [xs[i], xs[i + 1], xs[i + 2], xs[i + 3]]];

function cumsum(list, i = 0, acc = []) =
  i >= len(list) ? acc :
  cumsum(list, i + 1, concat(acc, [i == 0 ? list[0] : acc[i-1] + list[i]]));

function lerp_knot(pa, pb, ta, tb, t) = 
  pa + (t - ta) / (tb - ta) * (pb - pa);

function catmull_rom_segment(P0, P1, P2, P3, t0, t1, t2, t3, steps) = [
  for (i = [0 : steps])
    let(
      t = t1 + i * (t2 - t1) / steps,
      A1 = lerp_knot(P0, P1, t0, t1, t),
      A2 = lerp_knot(P1, P2, t1, t2, t),
      A3 = lerp_knot(P2, P3, t2, t3, t),
      B1 = lerp_knot(A1, A2, t0, t2, t),
      B2 = lerp_knot(A2, A3, t1, t3, t),
      C = lerp_knot(B1, B2, t1, t2, t)
    ) C
];

function catmull_rom_spline(ps, alpha = 1, steps = 10) =
  let(
    intervals = [
      for (window = sliding_2(ps))
        pow(norm(window[1] - window[0]), alpha)
    ],
    knots = concat([0], cumsum(intervals)),
    segments = [
      for (i = [0 : len(ps) - 4])
        let(
          seg = sliding_4(ps)[i],
          P0 = seg[0], P1 = seg[1], P2 = seg[2], P3 = seg[3],
          t0 = knots[i], t1 = knots[i+1], t2 = knots[i+2], t3 = knots[i+3]
        )
        catmull_rom_segment(P0, P1, P2, P3, t0, t1, t2, t3, steps)
    ]
  )
  [for (segment = segments) for (point = segment) point];

module tube(p1, p2) {
  module profile(s)
    cube([s, s, 0.001], center=true);

  module shape(s)
    hull() {
      translate(p1) profile(s);
      translate(p2) profile(s);
    }

  difference() {
    shape(gutter_size + 2);
    shape(gutter_size);
  }
}

module catmull_rom(ps, diameter = 1) {
  spline_points = catmull_rom_spline(ps);
  for (window = sliding_2(spline_points)) {
    tube(window[0], window[1]);
  }
}

// tube([0, 0, 0], [50, 0, 50]);
// color("blue") simple();
color("red") catmull_rom(points3d, 2);
