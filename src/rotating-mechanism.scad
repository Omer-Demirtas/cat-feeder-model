
module rotating_mechanism(diameter, thickness, shaft_inside, shaft_outside) {
    linear_extrude(thickness) {
        difference() {
            union() {
                circle_angle_cut(diameter = diameter, left_angle = 45, right_angle = 45);
                shaft_cover_circle(shaft_outside);
            }
            shaft_space(shaft_inside);
        }
    }
}

module shaft_space(diameter) {
    circle(d = diameter, $fn=100);
}

module shaft_cover_circle(diameter) {
    circle(d = diameter, $fn = 100);
}