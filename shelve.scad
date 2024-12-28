module square_with_hole_and_nut(vida_deligi_cap = 3, govde_genisligi = 7, katman_yuksekligi = 1) {
    // İlk katman (parametrik yüksekliği olan)
    difference() {
        linear_extrude(height = 8) {
            square([24.85, 6.85], center = true);
        }

        // Delik
        translate([0, (govde_genisligi - vida_deligi_cap) / 2, 0]) {
            cylinder(d = vida_deligi_cap, h = 7, center = true, $fn = 50); // Delik (M3 için)
        }
        
        translate([0, 1, 2])
        linear_extrude(height = 3) {
            square([6, 6], center = true);
        }
        
    }
    
    //translate([0, 0, katman_yuksekligi])
    
    //dikdortgen_devami();
}

// İkinci obje: İçeride dikdörtgen bir kesit alanı olan yapı
module dikdortgen_devami(dikdortgen_genislik = 20, dikdortgen_yukseklik = 5, yukseklik = 5) {
    difference() {
        // Ana dikdörtgen prizma
        linear_extrude(height = yukseklik) {
            square([24.85, 6.85], center = true);
        }

        // İçerideki dikdörtgen kesit
        translate([0, 1, 1]) {
            linear_extrude(height = 3) {
                square([5.9, 5.9], center = true);
            }
        }
    }
}


union() {
    square_with_hole_and_nut();

    translate([0, 0, 7 + (50 / 2)]) {
        cube([5.85, 5.85, 50], center = true);
    }

}