use <ic--mekanizma.scad>;

$fn = 100; // Çemberin düzgünlüğü
diameter = 80; // Dairenin çapı
angle = 50; // Pizza dilimi açısı (her iki yöne simetrik olarak)
wall = 4;

depth = 35 + wall * 2 + 1;

outer_diameter = diameter + wall; // Dış çemberin çapı

module part_wall_with_slice(diameter = diameter) {
    linear_extrude(wall) {
        difference() {
            union() {
                difference() {
                    pizza_slice(diameter = diameter);
                    pizza_slice(cut_angle = 47, diameter = diameter + 10);
                }
                circle(8,  $fn = $fn);
            }

            circle(4.5,  $fn = $fn);
        }
    }
}

module part_wall() {
    linear_extrude(wall) {
        difference() {
            union() {
                pizza_slice();
                circle(8,  $fn = $fn);
            }

            circle(4.5,  $fn = $fn);
        }
    }
}

module pizza_slice(cut_angle = angle, diameter = diameter) {
        intersection() {
            circle(d = diameter); // Ana daire
            polygon(points = [
                [0, 0], 
                [diameter * 1.5 * cos(-cut_angle), diameter * 1.5 * sin(-cut_angle)],
                [diameter * 1.5 * cos(cut_angle), diameter * 1.5 * sin(cut_angle)]
            ]); // Dilim kesici üçgen
        }
    
}

module pizza_wall(angle = angle, diameter = diameter, outer_diameter = outer_diameter) {
    difference() {
        intersection() {
            // Dış çember
            circle(d = outer_diameter);
            // Pizza dilimini sınırlayan açı
            polygon(points = [
                [0, 0], 
                [outer_diameter * cos(-angle), outer_diameter * sin(-angle)],
                [outer_diameter * cos(angle), outer_diameter * sin(angle)]
            ]);
        }
        // İç çemberi çıkararak duvar oluştur
        circle(d = diameter);
    }
}

module top_part() {
    linear_extrude(wall) {
        pizza_wall(diameter = diameter - wall * 2, outer_diameter = diameter);
    }

    //part_wall_with_slice(diameter = diameter - wall);

    linear_extrude(wall) {
        difference() {
            union() {
                difference() {
                    pizza_slice(diameter = diameter);
                    //pizza_slice(cut_angle = 47, diameter = diameter + 10);
                }
                circle(8,  $fn = $fn);
            }

            circle(4.5,  $fn = $fn);
        }
    }

    // asil par.a vvuarina tutturmak icin
    union() {
        translate([0, 0, wall])
        linear_extrude(wall) {
            pizza_wall(diameter = diameter - wall, outer_diameter = outer_diameter + wall);
        }
    
        linear_extrude(wall) {
            pizza_wall(diameter = outer_diameter, outer_diameter = outer_diameter + wall);
        }
    }
}


//part_wall_with_slice(diameter = diameter - wall);

module hopper_v2() {
    linear_extrude(height = 20) {
    difference() {
        union() {
                difference() {
                    pizza_slice(cut_angle = 47, diameter = diameter - wall);
                    pizza_slice(cut_angle = 45, diameter = diameter - wall * 2);
                }

                circle(8,  $fn = $fn);
            }
        circle(4.5,  $fn = $fn);

        }                          
    }
}

module top_part_v2() {
    part_wall();
    linear_extrude(wall) {
        pizza_wall(angle = 60);
    }
    linear_extrude(depth) {
        pizza_wall(angle = 60);
    }
}
module hopper() {

hopper_size = 85;
chord_length = 2 * 40 * sin(30);

difference() {
    // dis yuzey
    translate([depth+35, 0, 0])
    rotate([0, 270, 0])
    linear_extrude(
        height = depth, 
        scale=[
            (chord_length + 2 * wall) / (hopper_size + 2 * wall), 
            (chord_length + 2 * wall) / (hopper_size + 2 * wall)
        ]
    ) {
        square([hopper_size + wall, hopper_size + wall], center = true);
    }


    // ic kesit
translate([depth+35, 0, 0])
rotate([0, 270, 0])
linear_extrude(height = depth, scale=[chord_length / hopper_size, chord_length / hopper_size]) {
    square([hopper_size, hopper_size], center = true);
}

    translate([0,0,-50])
linear_extrude(100) {
pizza_slice(cut_angle = 30);
}

}
}

translate([0,0, 35 + 4])
top_part();

//pizza_wall(angle = 30, diameter = diameter + 10);
top_part_v2();

//pizza_slice(cut_angle = 45, diameter = diameter - 4);



/*
linear_extrude(depth) {
    difference() {
        pizza_wall(angle = 60);
        pizza_wall(angle = 30, diameter = diameter);
    }
}
*/

/*
width = 81;

alt_genislik = 35;
alt_genislik2 = 50;

difference() {


translate([30, 0, 0])
rotate([0, 270, 0])
difference() {
    linear_extrude(
        height = 30, 
        scale=[
            (alt_genislik + 4) / (width + 4), 
            (alt_genislik2 + 4) / (width + 4)
            ]
        ) {
        square([width + 4, width + 4]);
    } 

    translate([2, 2])
    linear_extrude(height = 30, scale=[alt_genislik / width, alt_genislik2 / width]) {
        square([width, width]);
    } 
}
*/
    /*

    translate([-31, 28, 0])
    linear_extrude(69) {
        pizza_slice();
    }
}
    */

    