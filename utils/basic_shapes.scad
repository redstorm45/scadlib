
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//

module plate(length=0, width=0, thickness=0, l=0, w=0, t=0){
    length_ =    (l>0)? l : length;
    width_ =     (w>0)? w : width;
    thickness_ = (t>0)? t : thickness;
    
    translate([0, 0, thickness_/2]) cube(size=[length_, width_, thickness_], center=true);
}

module rounded_plate(length=0, width=0, thickness=0, radius=0, l=0, w=0, t=0, r=0){
    length_ =    (l>0)? l : length;
    width_ =     (w>0)? w : width;
    thickness_ = (t>0)? t : thickness;
    radius_ =    (r>0)? r : radius;
    
    l1 = length_-2*radius_;
    l2 = width_-2*radius_;
    
    hull(){
        plate(length=l1, width=l2, thickness=thickness_);
        translate([-l1/2, -l2/2, 0]) cylinder(r=radius_, h=thickness_);
        translate([ l1/2, -l2/2, 0]) cylinder(r=radius_, h=thickness_);
        translate([ l1/2,  l2/2, 0]) cylinder(r=radius_, h=thickness_);
        translate([-l1/2,  l2/2, 0]) cylinder(r=radius_, h=thickness_);
    }
}

module tube(h=0, rin=0, rout=0, center=false, height=0, radius_in=0, radius_out=0){
    height_ = (h>0)? h : height;
    rin_ = (rin>0)? rin : radius_in;
    rout_ = (rout>0)? rout : radius_out;
    
    difference(){
        cylinder(h=height_, r=rout_, center=center);
        translate([0, 0, -1]) cylinder(h=height_+3, r=rin_, center=center);
    }
}


module basic_shapes_demo()
{
    translate([0, 0, 0]) plate(l=10, width=5, t=1);
    translate([0, 20, 0]) rounded_plate(length=10, w=5, t=1, r=1);
    translate([0, 40, 0]) tube(h=10, rin=5, rout=6, center=true);
}

basic_shapes_demo($fn=30);
