include <utils.scad>
include <cone.scad>
include <rotating-case.scad>
include <rotating-mechanism.scad>

wall = 2;

diameter = 100;
thickness = 35;

rotating_mechanism_thickness = 35;

module main() {
    adapter_height = 7;
    adapter_translate = (diameter / 2) - 7;

    union() {
        union() {
            //translate([0,thickness / 2,0])
            //mirror([0,0,1])
            //rotate([90, 90, 0])
            rotating_case(diameter = diameter, thickness = thickness);

            //translate([0, -2, adapter_translate])
            //translate([0, -4, adapter_translate + adapter_height])
            //cone(40, 50, rotating_mechanism_thickness, 85, 85, wall * 2);
       }
    }
} 

main();

