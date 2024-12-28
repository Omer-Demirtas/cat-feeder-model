
module pizza_cut(bottom_padding = 0 , diameter = 100, cut_angle = 0, start_angle = 0, end_angle = 45, extension = 1.5, thickness = 35, bore_multipier = 6, cone_height = 50, $fn = 100) {
    animation_angle = $t * 360;

    translate([thickness / 2, 0, bottom_padding + diameter / 2])
    rotate([0, 270, 0])
    rotate([0, 0, (animation_angle + cut_angle) % 360])
    difference() {
        linear_extrude(height = thickness) {
            union() {
            difference() {
                // Daire
                circle(d = diameter, $fn = $fn);
                
                // Pizza dilimi şekliq
                polygon(points = [
                    [0, 0], 
                    [diameter * extension * cos(start_angle), diameter * extension * sin(   start_angle)],
                    [diameter * extension * cos(end_angle), diameter * extension * sin(end_angle)]
                ]);
                        
            }
        
            circle(6,  $fn = $fn);
        }
    }
        shelve_cut(bore_multipier = bore_multipier, thickness = thickness);
    }
}

module circle_with_circle_cut(bottom_padding = 0 , diameter = 100, cut_angle = 0, start_angle = 0, end_angle = 45, extension = 1.5, thickness = 35, bore_multipier = 6, cone_height = 50, $fn = 100) {
    animation_angle = $t * 360;

    translate([thickness / 2, 0, bottom_padding + diameter / 2])
    rotate([0, 270, 0])
    rotate([0, 0, (animation_angle + cut_angle)])
    difference() {
        linear_extrude(height = thickness) {
            union() {
            difference() {
                // Daire
                circle(d = diameter, $fn = $fn);
 
                translate([21, 0, 0])
                scale([3, 4, 1])
                    circle(d = 13, $fn = 100); // Elips
                        
            }
        
            circle(6,  $fn = $fn);
        }
    }
        shelve_cut(bore_multipier = bore_multipier, thickness = thickness);
    }
}

module shelve_cut(bore_multipier = 1, thickness) {
        translate([bore_multipier / -2, bore_multipier / -2, -2]) 
            cube([bore_multipier, bore_multipier, thickness + 4]);
}


module circle_part(diameter = 80, height = 10, angle = 90, bottom_padding = 0, extension = 1.5) {
    translate([-(diameter / 2), -( diameter / 2)])
    rotate_extrude(angle=angle)
    offset(r=2, $fn=100) offset(r=-2) square([diameter,height]);
}


circle_part();

//circle_with_circle_cut(diameter = 80, thickness = 35, start_angle = -45, end_angle = 45); 