
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