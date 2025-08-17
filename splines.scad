points = [
  [10, 0],
  [20, 10],
  [40, 20],
  [10, 30],
];

points2 = [
  [20, 0],
  [20, 10],
  [40, 30],
  [40, 40],
  [20, 40],
  [20, 60],
  [20, 80],
];

points3d = [
  [0, 0, 0],
  [10, 50, 50],
  [20, 0, 100],
  [-50, -50, 150],
  [-30, 0, 200],
  [0, 100, 250],
];

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

module line_segment_2d(p1, p2) {
  hull() {
    translate(p1) circle(d = 1);
    translate(p2) circle(d = 1);
  }
}

module simple() {
  for (window = sliding_2(points2)) {
    line_segment_2d(window[0], window[1]);
  }
}

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
    shape(65 + 2);
    shape(65);
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
