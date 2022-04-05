
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//

use <../utils/common.scad>;
use <pin_headers.scad>;


COLOR_NANO_REV3_PLATE = [0.15, 0.15, 0.8];
COLOR_NANO_REV3_MICROCONTROLLER = [0.1, 0.1, 0.1];
COLOR_NANO_REV3_BUTTON = [0.65, 0.65, 0.65];
COLOR_NANO_REV3_USB = [0.75, 0.75, 0.75];


module nano_rev3(has_spi=true, has_pins=true){
    if(has_pins){
        translate([0, 2.54*3, 0]) pin_header(15, center=true);
        translate([0, -2.54*3, 0]) pin_header(15, center=true);
    }
    color(COLOR_NANO_REV3_PLATE)  difference(){
        plate(l=2.54*17+0.2, w=2.54*7, t=1.5);
        if(!has_pins){
            for(i=[0: 14]){
                translate([2.54*(i-7), 2.54*3, -1]) cylinder(r=0.6, h=3);
                translate([2.54*(i-7), -2.54*3, -1]) cylinder(r=0.6, h=3);
            }
        }
    }
    if(has_spi){
        translate([-2.54*7, 0, 1.5]) rotate([0, 0, 90]) mirror([0, 0, 1]) pin_header(3, center=true);
        translate([-2.54*8, 0, 1.5]) rotate([0, 0, 90]) mirror([0, 0, 1]) pin_header(3, center=true);
    }
    
    color(COLOR_NANO_REV3_MICROCONTROLLER) translate([5, 0, 1.3]) rotate([0, 0, 45]) plate(7, 7, 1.2);
    color(COLOR_NANO_REV3_BUTTON) translate([-3.5, 0, 2.0]) union(){
        cylinder(h=3.5, r=1.2, center=true);
        cube(size=[3, 4, 2.7], center=true);
    }
    color(COLOR_NANO_REV3_USB) union(){
        translate([17.5, 0, 2.5]) cube(size=[8, 8, 4], center=true);
        translate([19.5, 0, 1.5]) rotate([90, 0, 90]) linear_extrude(5) polygon([[3, 0], [3, 1], [4, 2], [4, 3], [-4, 3], [-4, 2], [-3, 1], [-3, 0]]);
    };
}

module nano_rev3__demo()
{
    translate([0, -45, 0]) nano_rev3(has_pins=false, has_spi=false);
    translate([0, -15, 0]) nano_rev3(has_pins=false);
    translate([0, 15, 0]) nano_rev3(has_pins=true);
    translate([0, 45, 0]) nano_rev3(has_pins=true, has_spi=false);
}

nano_rev3__demo($fn=20);