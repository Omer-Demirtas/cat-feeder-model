module shaft(thickness = outside_shaft_size) {
    linear_extrude(thickness) {
        circle(d = 8, $fn = 100);
    }
}

module shaft_cover(thickness = outside_shaft_size) {
    linear_extrude(thickness) {
        circle(d = 12, $fn = 100);
    }
}

module shaft_cover_cover(thickness = outside_shaft_size) {
    linear_extrude(thickness) {
        circle(d = 16, $fn = 100);
    }
}