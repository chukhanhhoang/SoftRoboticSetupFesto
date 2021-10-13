$fn = 60;

difference(){
    hull(){
translate([0,10,2.5])cube([27,7,5],center = true);
cylinder(5,7,7);
    }
translate([0,0,-1])cylinder(10,9.2/2,9.2/2);
}