
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//


use <../utils/common.scad>;


COLOR_MOTOR_N10_CLAMP = [0.7, 0.2, 0.6];
COLOR_MOTOR_N10_REDUCTOR = [0.9, 0.8, 0.0];
COLOR_MOTOR_N10_BLOCK = [0.6, 0.6, 0.6];
COLOR_MOTOR_N10_CAP = [0.1, 0.1, 0.1];
COLOR_MOTOR_N10_AXLE = [0.7, 0.7, 0.7];


module motor_n10__reductor(simplified=false){
    plate_radius=(simplified)? 0 : 0.5;
    
    color(COLOR_MOTOR_N10_REDUCTOR) union(){
        if(!simplified) translate([0, 0, -0.7]) tube(h=1.2, rin=1.51, rout=2);
        mirror([0, 0, 1]) difference(){
            rounded_plate(l=11.75, w=9.75, t=0.5, r=plate_radius);
            translate([0, 0, -0.25]) cylinder(h=1, r=1.51);
        }
        translate([0, 0, -5]) mirror([0, 0, 1]) union(){
            translate([0, 2.375, 0]) rounded_plate(l=11.75, w=5, t=0.5, r=plate_radius);
            translate([-2.375, 0, 0]) rounded_plate(l=7, w=9.75, t=0.5, r=plate_radius);
        }
        translate([0, 0, -8.2]) mirror([0, 0, 1]) difference(){
            rounded_plate(l=11.75, w=9.75, t=0.5, r=plate_radius);
            translate([0, 0, -0.5]) cylinder(h=2, r=2);
        }
        translate([4, 2.5, -0.1]) mirror([0, 0, 1]) cylinder(h=8.5, r=1.5);
        translate([-4, -2.5, -0.1]) mirror([0, 0, 1]) cylinder(h=8.5, r=1.5);
    }
}

module motor_n10__axle(simplified=false){
    color(COLOR_MOTOR_N10_AXLE) union(){
        difference(){
            translate([0, 0, -1]) cylinder(h=11, r=1.5);
            if(!simplified)
                rotate(45, [0, 0, 1]) translate([1.5, 0, 6]) cube(size=[1, 3, 10], center=true);
        }
        if(!simplified) translate([0, 0, -2.0]) cylinder(h=1.3, r=3);
    }
}

module motor_n10__block(simplified=false){
    color(COLOR_MOTOR_N10_BLOCK) mirror([0, 0, 1]) union(){
        difference(){
            intersection(){
                cylinder(d=11.75, h=14);
                translate([0, 0, 7]) cube(size=[11.75, 9.75, 14], center=true);
            }
            if(!simplified){
                translate([2, 5, 7]) cube(size=[0.7, 1, 5], center=true);
                translate([-2, 5, 7]) cube(size=[0.7, 1, 5], center=true);
                translate([-2, -5, 7]) cube(size=[0.7, 1, 5], center=true);
                translate([2, -5, 7]) cube(size=[0.7, 1, 5], center=true);
            }
        }
        if(!simplified){
            translate([0, 0, 16]) difference(){
                union(){
                    translate([-3.5, 0, -1]) cube(size=[0.5, 1.5, 3.4], center=true);
                    translate([3.5, 0, -1]) cube(size=[0.5, 1.5, 3.4], center=true);
                }
                rotate(90, [0, 1, 0]) cylinder(h=20, r=0.5, center=true);
            }
        }
    }
}

module motor_n10__cap(simplified=false){
    color(COLOR_MOTOR_N10_CAP) mirror([0, 0, 1]) difference(){
        union(){
            intersection(){
                cylinder(d=11.75, h=1);
                translate([0, 0, 0.5]) cube(size=[11.75, 9.75, 1], center=true);
            }
            if(simplified)
                cylinder(h=2, r=2.5);
            else
                tube(h=2, rin=1, rout=2.5);
        }
        if(!simplified){
            translate([-6, 0, 0.5]) cube(size=[2.6, 1.5, 2], center=true);
            translate([-3.5, 0, 0.5]) cube(size=[0.54, 1.54, 2], center=true);
            translate([6, 0, 0.5]) cube(size=[2.6, 1.5, 2], center=true);
            translate([3.5, 0, 0.5]) cube(size=[0.54, 1.54, 2], center=true);
        }
    }
}

module motor_n10(simplified=false){
    motor_n10__reductor(simplified);
    translate([0, 0, -8.7-0.01]) motor_n10__block(simplified, $fn=$fn*2);
    translate([0, 0, -22.7-0.02]) motor_n10__cap(simplified);
    motor_n10__axle(simplified);
}

module motor_n10__clamp_side(){
    rotate([-90, 0, 0]) difference(){
        linear_extrude(4){
            hull(){
                translate([1, 0]) square([2, 10], center=true);
                translate([5, 3]) circle(r=2);
                translate([5, -3]) circle(r=2);
            }
        }
        translate([4, 0, -1]) cylinder(r=1.5, h=4);
        translate([4, 0, 2]) rotate([0, 0, 90]) cylinder(r=2.8, h=4, $fn=6);
    }
}

module motor_n10__clamp(ridges=false){
    color(COLOR_MOTOR_N10_CLAMP) union() {
        difference(){
            translate([0, 1, -10.01]) linear_extrude(10){
                hull(){
                    translate([0, -3.3]) square(size=[16, 5], center=true);
                    translate([6, 4]) circle(r=2);
                    translate([-6, 4]) circle(r=2);
                }
            }
            translate([0, -0.5, -5.01]) cube(size=[12, 11, 20], center=true);
        }
        if(ridges){
            translate([-6, 4.5, -4.45]) rotate([0, 0, 45]) cube(size=[2, 2, 1], center=true);
            translate([-6, 4.5, -6.05]) rotate([0, 0, 45]) cube(size=[2, 2, 1], center=true);
            translate([6, 4.5, -4.45]) rotate([0, 0, 45]) cube(size=[2, 2, 1], center=true);
            translate([6, 4.5, -6.05]) rotate([0, 0, 45]) cube(size=[2, 2, 1], center=true);
        }
        translate([6, -4.8, -5.01]) motor_n10__clamp_side();
        translate([-6, -4.8, -5.01]) mirror([1, 0, 0]) motor_n10__clamp_side();
    }
}


module motor_n10__demo()
{
    translate([0, 20, 0]) motor_n10__clamp($fn=20);
    translate([0, 0, 0]) motor_n10($fn=20);
    translate([20, 0, 0]) motor_n10(simplified=true, $fn=20);
}

motor_n10__demo();