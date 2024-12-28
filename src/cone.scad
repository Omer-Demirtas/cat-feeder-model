
module cone(height, bottom_x, bottom_y, top_x, top_y, cone_wall) {
    top_case_height = 5;
    bottom_case_height = 10;

    top_x_wall = (top_x + cone_wall);
    top_y_wall = (top_y + cone_wall);

    bottom_x_wall = (bottom_x + cone_wall);
    bottom_y_wall = (bottom_y + cone_wall);


    translate([0, -bottom_y / 2, height])
    mirror([0, 0, 1])
    union() {
        difference() {
            union() {
                linear_extrude(
                    height = height, 
                    scale=[
                        (bottom_x + cone_wall) / (top_x + cone_wall), 
                        (bottom_y + cone_wall) / (top_y + cone_wall)
                        ]
                    ) {
                    square([(top_x + cone_wall) / 2, top_y + cone_wall]);
                }

                mirror([1, 0, 0])
                
                linear_extrude(
                    height = height, 
                    scale=[
                        (bottom_x + cone_wall) / (top_x + cone_wall), 
                        (bottom_y + cone_wall) / (top_y + cone_wall)
                        ]
                    ) {
                    square([(top_x + cone_wall) / 2, top_y + cone_wall]);
                }
            }

            translate([0, cone_wall / 2, 0])
            union() {
                linear_extrude(
                    height = height, 
                    scale=[
                        (bottom_x) / (top_x), 
                        (bottom_y) / (top_y)
                        ]
                    ) {
                    square([(top_x) / 2, top_y]);
                }

                mirror([1, 0, 0])
                
                linear_extrude(
                    height = height, 
                    scale=[
                        (bottom_x) / (top_x), 
                        (bottom_y) / (top_y)
                        ]
                    ) {
                    square([(top_x) / 2, top_y]);
                }
            }
        }

        // top adapter
        difference() {
            translate([-top_x_wall / 2, 0, -top_case_height]) {
                linear_extrude(height = top_case_height) {
                    square([top_x_wall, top_y_wall]);
                }   
            }

            translate([-top_x / 2, cone_wall / 2, -top_case_height]) {
                linear_extrude(height = top_case_height) {
                    square([top_x, top_y]);
                }   
            }
        }
    }
}

// Parametreler
kavanoz_cap = 80;           // Kavanozun dış çapı (mm)
kavanoz_duvar_kalinlik = 3; // Kavanozun duvar kalınlığı (mm)
kapak_yukseklik = 20;       // Kapak yüksekliği (mm)
vida_dis_araligi = 4;       // Vida dişleri aralığı (mm)
vida_dis_yukseklik = 1.5;   // Vida diş yüksekliği (mm)
kapak_duvar_kalinlik = 3;   // Kapak duvar kalınlığı (mm)
vida_tur_sayisi = 3;        // Vida dişinin tam tur sayısı

// Kapak gövdesi
module kapak_govde() {
    difference() {
        // Dış kapak kısmı
        cylinder(h = kapak_yukseklik, d = kavanoz_cap + kapak_duvar_kalinlik * 2);
        
        // İç boşluk (kavanozun oturacağı yer)
        translate([0, 0, kapak_duvar_kalinlik])
            cylinder(h = kapak_yukseklik, d = kavanoz_cap);
    }
}

// Vida dişleri
module vida_disleri(iceride = true) {
    pitch = kapak_yukseklik / vida_tur_sayisi;
    rotate_extrude(angle = 360)
        translate([kavanoz_cap / 2 + (iceride ? -vida_dis_yukseklik : vida_dis_yukseklik), 0, 0])
            square([vida_dis_araligi, vida_dis_yukseklik]);
}

// Vida dişli kapak
module vida_disli_kapak() {
    // Kapak gövdesi
    kapak_govde();
    
    // İç vida dişleri (kavanozun dış duvarına oturacak)
    translate([0, 0, kapak_duvar_kalinlik]) {
        vida_disleri(true);
    }
}