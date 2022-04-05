
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//

use <../utils/common.scad>;

// Local colors (approximate)

COLOR_HOUSING = [0.1, 0.1, 0.9, 0.5];
COLOR_MOTOR = [0.6, 0.6, 0.6];
COLOR_MOTOR_CAP = [0.1, 0.1, 0.1];


SERVO_AXIS_OFFSET = 22.5/2 - 11.6/2;
SERVO_MOTOR_OFFSET = 20.6/2 - 8.1/2;
SERVO_HOUSING_TOP_HEIGHT = 10.9;
SERVO_HOUSING_CENTER_HEIGHT = 10.4;

// Parts

module servo_9g__housing_top()
{
    color(COLOR_HOUSING) difference(){
        union(){
            translate([0, 0, 3.4]) cube([22.6, 12.1, 6.7],center=true);
            translate([0, 0, 1.3]) cube([32.3, 12, 2.5],center=true);
            translate([-SERVO_AXIS_OFFSET, 0, 1]) cylinder(h=SERVO_HOUSING_TOP_HEIGHT-1, d=11.6);
        }
        cube([20.61, 10.11, 2*5.7], center=true);
        translate([-SERVO_AXIS_OFFSET, 0, 0]) cylinder(h=SERVO_HOUSING_TOP_HEIGHT-1, d=9.6);
        translate([-SERVO_AXIS_OFFSET, 0, 0]) cylinder(h=SERVO_HOUSING_TOP_HEIGHT+1, d=5);
        
        mirror_copy([1, 0, 0]){
            translate([-27.9/2, 0, 0]) cylinder(h=10, d=2);
            translate([-31.9/2, 0, 0]) cube([4, 1, 10], center=true);
        }
    }
}

module servo_9g__housing_center()
{
    color(COLOR_HOUSING) translate([0, 0, -5.2]) difference() {
        cube([22.6, 12.1, SERVO_HOUSING_CENTER_HEIGHT], center=true);
        translate([0, 0, -1]) cube([20.6, 10.1, SERVO_HOUSING_CENTER_HEIGHT], center=true);
        translate([SERVO_MOTOR_OFFSET, 0, 0]) cylinder(h=30, d=4, center=true);
        translate([-SERVO_AXIS_OFFSET, 0, 0]) cylinder(h=30, d=8, center=true);
    }
}

module servo_9g__housing_bottom()
{
    color(COLOR_HOUSING) translate([0, 0, -2.7]) difference() {
        cube([22.6, 12.1, 5.3], center=true);
        translate([0, 0, 1]) cube([20.6, 10.1, 5.3], center=true);
        translate([-10, 0, 2.7]) cube([20, 3.5, 2], center=true);
    }
}

module servo_9g__motor()
{
    color(COLOR_MOTOR) translate([0, 0, -0.2]) mirror([0, 0, 1]) union(){
        translate([0, 0, 0.9]) difference(){
            intersection(){
                cylinder(h=11.2, d=10);
                cube([8, 20, 30], center=true);
            }
            translate([0, 4, 12]) cube([1, 5, 2], center=true);
        }
        cylinder(d=3.8, h=3);
    }
    color(COLOR_MOTOR_CAP) translate([0, 0, -11.2]) mirror([0, 0, 1]) intersection(){
        cylinder(h=2, d=9.9);
        cube([7.9, 20, 30], center=true);
    }
}

module servo_9g__potentiometer()
{
    color(COLOR_MOTOR_CAP) mirror([0, 0, 1]) translate([0, 0, 0.1]) cylinder(h=4, d=10);
}

module servo_9g()
{
    translate([0, 0, -SERVO_HOUSING_TOP_HEIGHT]){
        translate([SERVO_AXIS_OFFSET + SERVO_MOTOR_OFFSET, 0, 0]) servo_9g__motor();
        servo_9g__potentiometer();
        translate([SERVO_AXIS_OFFSET, 0, 0]) servo_9g__housing_center();
        translate([SERVO_AXIS_OFFSET, 0, 0]) servo_9g__housing_top();
    }
    translate([0, 0, -SERVO_HOUSING_TOP_HEIGHT-SERVO_HOUSING_CENTER_HEIGHT]){
        translate([SERVO_AXIS_OFFSET, 0, 0]) servo_9g__housing_bottom();
    }
}

servo_9g($fn=30);
