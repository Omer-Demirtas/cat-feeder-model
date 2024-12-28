// Açıyı $t parametresine göre hesapla
start_angle = $t * 360;  // 360 derece döngü

// Animasyonlu pizza kesimi
pizza_cut(diameter = 100, thickness = 35, start_angle = start_angle, end_angle = start_angle + 90);

module pizza_cut(diameter = 100, thickness = 35, start_angle = 0, end_angle = 45) {
    difference() {
        linear_extrude(height = thickness) {
            union() {
                difference() {
                    circle(d = diameter, $fn = 100);
                    polygon(points = [
                        [0, 0], 
                        [diameter * cos(start_angle), diameter * sin(start_angle)],
                        [diameter * cos(end_angle), diameter * sin(end_angle)]
                    ]);
                }
            }
        }
    }
}
