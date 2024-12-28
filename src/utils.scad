/*
  a:angle
  r:radius
  h:height
*/
module pieSlice(a, r, h, $fn = 300) {
    rotate_extrude(angle = a) 
        translate([0, -h / 2]) 
        square([r, h]);
}

module edge_wall(angle, diameter, thickness, width) {
    mirror([1, 0, 0])
    difference() {
        pieSlice(angle, diameter, width);         // Dış katman
        pieSlice(angle + 10, diameter - thickness, width); // İç katman (kalınlık kadar azaltılmış)
    }
}

module circle_angle_cut(diameter = 50, left_angle = 60, right_angle = 60) {
    difference() {
        // Ana daire
        circle(d = diameter, $fn = 100);

        // Üçgenin noktalarını hesapla
        polygon(points = [
            [0, 0], // Orijinal köşe (orijin)
            [diameter, 0], // Eksen üzerindeki ikinci köşe (diameter kadar x ekseninde)
            [diameter * cos(left_angle), diameter * sin(left_angle)] // Üçüncü köşe (verilen açıya göre hesaplanacak)
        ]);

        mirror([0, 1, 0])
              // Üçgenin noktalarını hesapla
        polygon(points = [
            [0, 0], // Orijinal köşe (orijin)
            [diameter, 0], // Eksen üzerindeki ikinci köşe (diameter kadar x ekseninde)
            [diameter * cos(right_angle), diameter * sin(right_angle)] // Üçüncü köşe (verilen açıya göre hesaplanacak)
        ]);
    }
}

module angle_part_of_circle(diameter = 50, left_angle = 60, right_angle = 60) {
    difference() {
        circle(d = diameter, $fn = 100);
        circle_angle_cut(diameter, left_angle, right_angle);
    }
}

function third_side(a, theta) = sqrt(2 * a^2 - 2 * a^2 * cos(theta));