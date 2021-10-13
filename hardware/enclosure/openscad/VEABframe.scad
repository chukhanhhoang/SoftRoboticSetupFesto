include <roundsquare.scad>;
include <baseframe.scad>;
include <roundsquare.scad>;
//import("bridge.stl");

$fn=20;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;
O = 12; // side hole offset


color([0.4,0.4,0.4])
render(){
    
    difference(){
    union(){
    Centerframe(W,R,D,T,H,O,Nm = [],Nb = []);
    translate([0,0,1]){cube([W-O,W-O,2],center =  true);}}
    
    for(ii = [0:5]){
    translate([-0.5*W +23,0,0]){
    translate([0.5*W/4*(ii),0,0]){
    hull(){
    translate([0,W/3,0]){cylinder(8,2,2,center = true);}
    translate([0,-W/3,0]){cylinder(8,2,2,center = true);}
    }    }    }}
    
    }
}