
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//


module mirror_copy(L)
{
    children();
    mirror(L) children();
}

module repeat_displace(T, center=false)
{
    tx = T[0]; ty = T[1]; tz = T[2];

    module tr_mult(i){translate([tx*i, ty*i, tz*i]) children();}

    tr_mult((center)?-($children-1)/2:0) for(i=[0 : $children-1]) tr_mult(i) children(i);
}


// Demo

module operations__demo()
{
    translate([0, 0, 0]) mirror_copy([1, 0, 0]) translate([10, 0, 0]) rotate([0, 0, 10]) cube(10, center=true);

    translate([0, 20, 0]) repeat_displace([10, 0, 0], center=true){
        cube(10, center=true);
        cylinder(d=5, h=2, center=true, $fn=20);
        cube(5, center=true);
        sphere(d=8, $fn=20);
    }
}

operations__demo();
