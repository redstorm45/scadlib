
//
// Licensed under the MIT license. See LICENSE file in the project root for details.
//


// Custom operations

module mirror_copy(L)
{
    children();
    mirror(L) children();
}


// Demo

mirror_copy([1, 0, 0]) translate([10, 0, 0]) rotate([0, 0, 10]) cube(10, center=true);
