include <baseframe.scad>;
include <roundsquare.scad>;
//include <VEAB.scad>;
include <powersupply.scad>;

$fn=40;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;
O = 12;  // side hole offset

// render the open-frame 

    Centerframe(W,R,D,T,H,O, Nb = [1,4]);
    
    rotate([0,0,90]){
    difference(){
    VEABholderClip(W,D);
    
    translate([48.0,-4.5,15]){
    rotate([90,0,90]){
    linear_extrude(0.5){
        mirror([0,0,0]){
        //text("B",size = 10);
            }
        }
    }}
    }
    }

   


    //VEABholder(W,D);
    

module VEABholder(W,D){
    
    difference(){
        union(){
            difference(){
translate([W/2-O-D-3.5,-9,D]){
    cube([4.5,18,5*D]);
    translate([-2,0,23]){cube([3,5,2]);}
    translate([-4,0,0]){cube([21.75,18,5]);}
    translate([-4,0,0]){cube([4.5,2,7]);}
    }
}

hull(){
translate([W/2-O+1,7.5,D]){
cylinder(D,5,5);}
translate([W/2-O+1,-7,D]){
cylinder(D,5,5);}
}
}

    Screwhole(W,D);

    translate([0,-15,0]){Screwhole(W,D);}
}

    
}

module VEABholderClip(W,D){
    
    difference(){
        union(){
            difference(){
translate([W/2-O-D+1,-5,D]){
    
    difference(){
    union(){
    cube([2,10,5*D]);
    translate([-3,0,23]){cube([5,10,4]);}
    translate([-2,0,0]){cube([15,10,5]);}
    //translate([-4,0,0]){cube([4.5,2,5]);}
    }
         
    translate([-3,0,25]){rotate([0,-10,0]){cube([8,10,2]);}}
    }
    
    }
}

hull(){
translate([W/2-O,7.5,D]){
cylinder(D,5,5);}
translate([W/2-O,-7,D]){
cylinder(D,5,5);}
}
}

    Screwhole(W,D);

    translate([0,-15,0]){Screwhole(W,D);}
}

    
}

module Screwhole(W,D){

        translate([W/2-12,7.5,2*D-3]){
        cylinder(3,3,3);
        translate([0,0,-3]){cylinder(6,1.75,1.75);}
        }
    }