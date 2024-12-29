padding = 0;

module rotating_case(diameter, thickness) {
    outside_shaft_size = (thickness + 6 * case_wall);
    echo(str("outside_shaft_size = ", outside_shaft_size));
    
    difference() {
        union() {
            translate([0, (thickness + (2 * case_wall)) / 2, 0])
            rotate([90,0,0]) {
                // Edge walls
                case_wall(case_edge, diameter, thickness, case_wall, padding);

                // Walls fills
                case_wall_fill(left_edge, right_edge, case_edge, edge_wall_thickness, edge_wall_diameter, case_wall);    
            }

            translate([0,0, (diameter / 2) - 10])
            square_adapter(
                15,
                third_side(edge_wall_diameter, 180 - (left_edge + right_edge)), 
                thickness,
                case_wall * 2
            );

            // outside shaft
            translate([0, outside_shaft_size / 2, 0])
            rotate([90,0,0])
            linear_extrude(outside_shaft_size) {
                circle(d = 12, $fn = 100);
        }
        }
        // diff parts
        diff_module(diameter, padding, thickness, edge_wall_diameter, left_edge, right_edge, case_wall);
    }

    /*
    translate([0, thickness /2, 0])
    color([0.1, 0.1, 0.1])
    rotate([90,0,0])
    rotating_mechanism(diameter, thickness, 8, 12);
    */
}

module case_wall(edge, diameter, thickness, wall, padding) {
    mirror([1, 0, 0])
    translate([0, 0, wall/ 2]) {
        pieSlice(edge, (diameter + padding) / 2, wall);

        translate([0, 0, thickness + wall]) {
            pieSlice(edge, (diameter + padding) / 2, wall);
        }
    }
}

module case_wall_fill(left_edge, right_edge, case_edge, edge_wall_thickness, edge_wall_diameter, wall) {
    // 90 degree side of wall
    translate([0, 0, edge_wall_thickness / 2]) {
        edge_wall(left_edge, edge_wall_diameter, wall, edge_wall_thickness);
    }

    mirror([1, 0, 0])
    translate([0, 0, edge_wall_thickness / 2])
    difference() {
        edge_wall(right_edge, edge_wall_diameter, wall, edge_wall_thickness);
        edge_wall(180 - case_edge, edge_wall_diameter + 3, wall + 10, edge_wall_thickness);                
    }
}

module square_adapter(thickness, x, y, wall) {
    translate([-(x + wall) / 2, -(y + wall) / 2, 0]) {
        difference() {
            linear_extrude(height = thickness) {
                square([x + wall, y + wall]);
            }   

            translate([wall / 2, wall / 2, 0])
            linear_extrude(height = thickness) {
                square([x, y]);
            }   
        } 
    }
}

module diff_module(diameter, padding, thickness, edge_wall_diameter, left_edge, right_edge, wall) {
    outside_shaft_size = (thickness + 6 * case_wall);
    
    rotate([90,0,0])
    pieSlice(180, (diameter + padding) / 2, thickness);
    cube(
        size=[
            third_side(edge_wall_diameter, 180 - (left_edge + right_edge)), 
            thickness,
            100
        ], 
        center=true
    );


    translate([0, outside_shaft_size / 2, 0])
    rotate([90,0,0])
    linear_extrude(outside_shaft_size) {
        circle(d = 8, $fn = 100);
    }
}
