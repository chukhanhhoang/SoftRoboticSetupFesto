include <baseframe.scad>;
include <roundsquare.scad>;
include <roundsquare.scad>;
include <buck24v.scad>;
//include <VEAB.scad>;
include<powersupply.scad>;                                                                           

$fn=40;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;
O = 12;   // side hole offset
Wb = 17;  // buck width
Lb = 36;  // buck length
Hb = 7;   // buck height

color([0.4,0.4,0.4])
render(){

    Centerframe(W,R,D,T,H,O, Nm = [], Nb = [1,4]);
    
    translate([0,-10,4*D]){rotate([180,0,0]){
    //powersupply(W);
    }}
    
    translate([99/2-50,50,D]){
    rotate([0,-90,90]){
        //cube([25,48,12]);
        }
    }
  

      translate([-99/2+4.5,-10+82/2-5.5,0]){    
       difference(){
       hull(){
       cylinder(D,5,5);
       translate([-15,-7.5,0]){cube([5,15,D]);}}
       cylinder(D*3,2.2,2.2,center = true);
       }}
       
      rotate([0,0,180]){
      translate([-99/2+1.5,82/2+3,0]){    
       difference(){
       hull(){
       cylinder(D,5,5);
       translate([-14,-7.5,0]){cube([5,15,D]);}}
       cylinder(D*3,2.2,2.2,center = true);
       }}} 
   
   translate([-99/2+10,-51,15+D]){
   difference(){
   hull(){
   rotate([90,0,0]){cylinder(D,5,5);}
   translate([-7.5,-5,-2*D-10]){cube([15,5,5]);}}
   rotate([90,0,0]){cylinder(3*D,2.2,2.2,center =true);}}
   translate([-15,-10,-2*D-10]){cube([22.5,25,5]);}
   }
   
  difference(){ 
  translate([+99/2-15,-51,15+D]){
   difference(){
   hull(){
   rotate([90,0,0]){cylinder(D,5,5);}
   translate([-7.5,-5,-2*D-10]){cube([15,5,5]);}}
   rotate([90,0,0]){cylinder(3*D,2.2,2.2,center =true);}}
   translate([-7.5,-10,-2*D-10]){cube([30,25,5]);}
   }
   
   rotate([0,0,180]){
   translate([-99/2+1.5,82/2+3,0]){    
   cylinder(D*30,2.2,2.2,center = true);}
       }}
   
   difference(){
   hull(){
   translate([55,20,0]){cube([5,20,2*D]);
       translate([-6,10,0]){cylinder(2*D,5,5);}}}
   
   translate([-6+55-19.5,10+20-18.5,D]){cube([20,20,D]);}
   }
   
   
   translate([0,W/2-O,1.5]){
   rotate([0,0,90]){
    buckholder(Wb,Lb,Hb);
   }}
   
   
   
   }