padding = 0;

module rotating_case(diameter, thickness) {
    case_wall = 2;
    case_edge = 150;
    left_edge = 60;
    right_edge = 60;

    edge_wall_thickness = thickness + (2 * case_wall);
    edge_wall_diameter = (diameter + (case_wall* 2) + padding) / 2;
    
    translate([0,(thickness + case_wall) / 2,0])
    rotate([90,0,0]) {
        // Edge walls
        case_wall(case_edge, diameter, thickness, case_wall, padding);

        // Walls fills

        case_wall_fill(left_edge, right_edge, case_edge, edge_wall_thickness, edge_wall_diameter, case_wall);    
    }

    square_adapter(2, third_side(diameter / 2, left_edge + right_edge), thickness, case_wall);

/*
    color([0.1, 0.1, 0.1])
    translate([0, 0, case_wall])
    rotating_mechanism(diameter, thickness);
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

