module hollow_square_huni() {
    difference() {
        // Dış huni (100x100'den 50x50'ye geçiş)
        linear_extrude(height=100, scale=[0.5, 0.35]) {
            square([100, 100], center=true);
        }

        // İç kısmı oyar (90x90'dan 40x40'a geçiş)
        translate([0, 0, 0]) // İç kısmı yukarıda başlat
            linear_extrude(height=100, scale=[0.4, 0.25]) {
                square([90, 90], center=true); // İç kısmı 90x90'dan başlatıyoruz
            }
    }
}

hollow_square_huni();