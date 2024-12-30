
module slider() {
    translate([0,-(rotating_mechanism_thickness + wall) / 2,0])
    rotate([270,0,0])
    difference() {
        union() {
            slider_axis();

            translate([0, 0, rotating_mechanism_thickness + wall])
            slider_axis();

            slider_floor();
        }

        slider_diff_module();
    }
}

module slider_floor() {
    difference() {
        translate([diameter / 2, (slider_wall_thickness) / 2, 0])
        rotating_square(slider_length, wall, rotating_mechanism_thickness + 2 * wall);
        shaft_cover_cover(thickness = rotating_mechanism_thickness);
    }
}

module slider_axis() {
    union() {
        rotating_square(diameter / 2 + slider_length, 10, wall);
        shaft_cover_cover(thickness = wall);
    }
}

module rotating_square(x,y,thickness) {
    linear_extrude(thickness) {
        translate([0, -y / 2])
        square([x, y]);
    }
}

module slider_diff_module() {
    shaft_cover(thickness = thickness + 2 * wall);
}
