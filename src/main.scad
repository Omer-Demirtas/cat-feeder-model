include <cone.scad>
include <shaft.scad>
include <utils.scad>
include <slider.scad>
include <rotating-case.scad>
include <rotating-mechanism.scad>

wall = 2;
padding = 0;
diameter = 100;
thickness = 35;

case_wall = 2;
case_edge = 150;
left_edge = 60;
right_edge = 60;

edge_wall_thickness = thickness + (2 * case_wall);
edge_wall_diameter = (diameter + (case_wall* 2) + padding) / 2;

rotating_mechanism_thickness = 35;

outside_shaft_size = (rotating_mechanism_thickness + 4 * case_wall);

/* SLIDER */
slider_wall_thickness = 10;
slider_length = 30;
 
module main() {
    adapter_height = 7;
    adapter_translate = (diameter / 2) - 10 + 15;

    union() {
        union() {
            //translate([0,thickness / 2,0])
            //mirror([0,0,1])
            //rotate([90, 90, 0])
            rotating_case(diameter = diameter, thickness = thickness);

            slider();

            translate([0, -wall, adapter_translate])
            cone(
                40, 
                third_side(edge_wall_diameter, 180 - (60 + 60)), 
                rotating_mechanism_thickness, 
                85,
                85,
                wall * 2
            );
       }
    }
} 

//slider();
main();
//main_with_slice();

module main_with_slice() {
    difference() {
        main();
        translate([0,-50,0])
        cube(size=[100, 100, 100], center=true);            
    }
}