include <baseframe.scad>;
include <roundsquare.scad>;
//include <VEAB.scad>;
include <powersupply.scad>;

$fn=20;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;    // height of base thickness
O = 12;   // side hole offset

// render the open-frame 
Centerframe(W,R,D,T,H,O);
    