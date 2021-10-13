include <roundsquare.scad>;
include <baseframe.scad>;
//include <VEAB.scad>;
//include <powersupply.scad>;
//import("bridge.stl");

$fn=50;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;
O = 12; // side hole offset

D1 = 35;
D2 = 40;

POWERBUTTON = true;

//Centerframe(W,R,D,T,H,O,Nm = [],Nb = []);
//translate([0,0,D1]){Centerframe(W,R,D,T,H,O,Nm = [],Nb = []);}

//translate([0,0,D1+D2]){Centerframe(W,R,D,T,H,O,Nm = [],Nb = []);}

bridge();



//mirror([0,1,0]){bridge();}


module cylinderOut(Dist,R,H=3,C = false){
    
    translate([W/2,W/2 - O,Dist-2.5+D+T]){
    rotate([0,90,0]){cylinder(H,R,R,center = C);}
    }
    
}

module bridge(){
    
difference(){
union(){
hull(){
cylinderOut(0,5);
cylinderOut(D1,5);
cylinderOut(D1+D2,5);
}
}

union(){
cylinderOut(0,2.2,H=20,C=true);
cylinderOut(D1,2.2,H=20,C=true);
cylinderOut(D1+D2,2.2,H=20,C=true);
}

translate([3,0,0]){
union(){
cylinderOut(0,3,H=3,C=true);
cylinderOut(D1,3,H=3,C=true);
cylinderOut(D1+D2,3,H=3,C=true);
}
}
}

if (POWERBUTTON){
difference(){
hull(){
translate([W/2,W/2 - O - 12 - 10,D1+D2/2-2.5+D+T]){
rotate([0,90,0]){
cylinder(3,12.5,12.5);
translate([0,12.5+10,3/2]){cube([25,5,3],center = true);}
}}}

translate([W/2+1,W/2 - O - 12 - 10,D1+D2/2-2.5+D+T]){
rotate([0,90,0]){
cylinder(5,8,8,center = true);}}

}}

}