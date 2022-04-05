
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//


COLOR_HEADER_PLASTIC = [0.2, 0.2, 0.2];
COLOR_HEADER_METAL = [0.7, 0.7, 0.75];


function pin_header__mirror_point_xy(p, cx=0, cy=0) = [2*cx-p[0], 2*cy-p[1]];
function pin_header__flatten(l) = [for(a=l) for(b=a) b];

function pin_header__make_side_points_for_header(n=1, edge=0.1) = pin_header__flatten(
        [for(i=[0: n-1])
            [[0.5, edge+i], [0.5, 1+i-edge], [0.5-edge, 1.0+i]]]
        );
function pin_header__make_points_for_header(n=1, edge=0.1) = concat(
        [[0.5-edge, 0]],
        pin_header__make_side_points_for_header(n, edge),
        [[-0.5+edge, n]],
        [for(e=pin_header__make_side_points_for_header(n, edge)) pin_header__mirror_point_xy(e, cy=n/2)]
    );

module pin_header(length=1, center=false, angled=false){
    translate([center?-1.27*length: 0, 0, -3]) {
        color(COLOR_HEADER_PLASTIC) linear_extrude(3) scale(2.54) rotate([0, 0, -90]) polygon(pin_header__make_points_for_header(length, 0.2));
        
        color(COLOR_HEADER_METAL) for(i=[0:length-1]){
            if(angled){
                translate([1.27+2.54*i, 0, 2.5]) union(){
                    cube(size=[0.6, 0.6, 8], center=true);
                    translate([0, 0, -4]) rotate([0, 90, 0]) cylinder(r=0.3, h=0.6, center=true);
                    translate([0, 4.5, -4]) cube(size=[0.6, 9, 0.6], center=true);
                }
            }else{
                translate([1.27+2.54*i, 0, 0]) cube(size=[0.6, 0.6, 12], center=true);
            }
        }
    }
}

module pin_header__demo()
{
    translate([0, 0, 0]) pin_header(length=8, center=false, angled=false);
    translate([0, 20, 0]) pin_header(length=5, center=true, angled=false);
    
    translate([0, 40, 0]) pin_header(length=8, center=false, angled=true);
    translate([0, 60, 0]) pin_header(length=5, center=true, angled=true);
}

pin_header__demo($fn=20);
