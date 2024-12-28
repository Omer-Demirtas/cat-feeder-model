use <ic--mekanizma.scad>;

wall_tickness = 4;


// Cone parameters

cone_wall_tickness = wall_tickness;

top_squeare_width = 81;
top_squeare_height = 81;

bottom_squeare_width = 50;
bottom_squeare_height = 35;

top_bottom_inside_width_rate =  (bottom_squeare_width / top_squeare_width);
top_bottom_inside_height_rate = (bottom_squeare_height / top_squeare_height);

top_bottom_out_width_rate =  ((bottom_squeare_width + (cone_wall_tickness* 2)) / (top_squeare_width + (cone_wall_tickness* 2)));
top_bottom_out_height_rate = ((bottom_squeare_height + (cone_wall_tickness* 2)) / (top_squeare_height + (cone_wall_tickness* 2)));

echo(str("top_bottom_out_width_rate = ", top_bottom_out_width_rate));

cone_depth = 20;
cone_wall_depth = 10;

// Main Body

main_body_x = 4;
main_body_y = bottom_squeare_width + cone_wall_tickness * 2;
main_body_z = 100;

main_body_food_channel_y = 50;
main_body_food_channel_z = 50;

// Circle parameters

circle_x = 35;
circle_z = 80;

// System bottom paddings

circle_bp = main_body_z - circle_z;
main_boddy_bp = 0;
cone_bp = main_boddy_bp + main_body_z;
cone_wall_bp = cone_bp + cone_depth;

module cone(bottom_padding = 0) {
    translate([0, 0, bottom_padding + cone_depth])
    rotate([0, 180, 0]) {
        difference() {
            // Dış huni (100x100'den 50x50'ye geçiş)
            linear_extrude(
                height=cone_depth, 
                scale=[top_bottom_out_width_rate, top_bottom_out_height_rate]) 
            {
                square([
                    top_squeare_width + (cone_wall_tickness * 2),
                    top_squeare_height + (cone_wall_tickness * 2)
                ], center=true);
            }

            // İç kısmı oyar (90x90'dan 40x40'a geçiş)
            linear_extrude(height=cone_depth, scale=[top_bottom_inside_width_rate, top_bottom_inside_height_rate]) {
                square([
                    top_squeare_width,
                    top_squeare_height
                ], center=true);
            }
        }
    }
}

module cone_wall(bottom_padding = 0) {
    translate([0, 0, bottom_padding + cone_wall_depth / 2])
    difference() {
        // Dış çerçeve (110x110, 10 mm yükseklik)
        cube([
            top_squeare_width + (wall_tickness * 2), 
            top_squeare_height + (wall_tickness * 2), 
            cone_wall_depth
        ], center=true);

        // İç çerçeve (100x100, 10 mm yükseklik)
        cube([
            top_squeare_width, 
            top_squeare_height, 
            cone_wall_depth
        ], center=true);
    }
}

module main_body(bottom_padding = 0, wall_ranage = 10) {
    translate([0, 0, bottom_padding + (main_body_z / 2)])
    union() {
        // left side
        translate([-((wall_ranage / 2) + (cone_wall_tickness / 2)), 0, 0]) {
            cube([main_body_x, main_body_y, main_body_z], center = true);
            // TODO y ekseninde 1  birim fazla gidiyor
            translate([0, main_body_y, main_body_z - main_body_food_channel_z - (main_body_z / 2) + (main_body_food_channel_z / 2)])
            //cube([main_body_x, main_body_food_channel_y, main_body_food_channel_z], center = true);
            rotate([0, 270, 0])
            circle_part(diameter = main_body_y, angle = 90, height = 7);
        }

        // right side 
        translate([((wall_ranage / 2) + (cone_wall_tickness / 2)), 0, 0]) {
            cube([main_body_x, main_body_y, main_body_z], center = true);
            // TODO y ekseninde 1  birim fazla gidiyor
            translate([0, main_body_y, main_body_z - main_body_food_channel_z - (main_body_z / 2) + (main_body_food_channel_z / 2)])
            cube([main_body_x, main_body_food_channel_y, main_body_food_channel_z], center = true);
        }
    }   
}

difference() {
    union() {
        cone(bottom_padding = cone_bp);

cone_wall(bottom_padding = cone_wall_bp);

main_body(bottom_padding = main_boddy_bp, wall_ranage = bottom_squeare_width);

pizza_cut(cut_angle = 0,diameter = circle_z, bottom_padding = circle_bp, thickness = circle_x, start_angle = -45, end_angle = 45); 


}
// kesit
translate([50, 0, 0])
cube([100, 199, 500], center = true);
}


