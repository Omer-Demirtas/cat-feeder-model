
module rotating_mechanism(diameter, thickness) {
    linear_extrude(thickness) {
        circle_angle_cut(diameter = diameter, left_angle = 45, right_angle = 45);
    }
}