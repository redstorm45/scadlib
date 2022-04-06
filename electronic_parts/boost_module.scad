
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//

use <../utils/common.scad>;


COLOR_BOOST_PLATE = [0.15, 0.15, 0.8];
COLOR_BOOST_POTENTIOMETRE = [0.3, 0.3, 0.98];
COLOR_BOOST_IC = [0.1, 0.1, 0.1];
COLOR_BOOST_COIL = [0.7, 0.5, 0.1];
COLOR_BOOST_METAL = [0.6, 0.6, 0.6];

module boost_converter(){
    // main plate
    color(COLOR_BOOST_PLATE) difference(){
        plate(l=27.94, w=2.54*6.5, t=1.0);
        translate([2.54*5, 2.54*2.75, -0.5]) cylinder(r=0.5, h=2);
        translate([2.54*5, -2.54*2.75, -0.5]) cylinder(r=0.5, h=2);
        translate([-2.54*5, -2.54*2.75, -0.5]) cylinder(r=0.5, h=2);
        translate([-2.54*5, 2.54*2.75, -0.5]) cylinder(r=0.5, h=2);
    }
    
    // potentiometre
    color(COLOR_BOOST_POTENTIOMETRE) translate([-5, -2.8, 0.5]) difference(){
        plate(l=10, w=10, t=5);
        translate([0, 5, -0.1]) plate(l=8, w=1, t=6);
    }
    color(COLOR_BOOST_METAL) translate([-8.5, -7, 4]) rotate([90, 0, 0]) cylinder(d=2.3, h=2.2);
    
    // coil
    translate([5, 3, 0.5]) {
        color(COLOR_BOOST_COIL) translate([0, 0, 1]) cylinder(r=3, h=3);
        color(COLOR_BOOST_IC){
            cylinder(r=4, h=1.5);
            translate([0, 0, 3.5]) cylinder(r=4, h=1.0);
        }
    }
    
    // diode
    color(COLOR_BOOST_IC) translate([-5, 4, 0.5]) plate(l=4, w=2.5, t=2.2);
    // circuit
    color(COLOR_BOOST_IC) translate([5, -4, 0.5]) plate(l=1.5, w=2.5, t=1.6);
    
    // usb port
    color(COLOR_BOOST_METAL) translate([12.5, 0, 1.0]) plate(l=5, w=6, t=2.5);
}

boost_converter($fn=20);
