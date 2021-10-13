include <roundsquare.scad>;
//include <VEAB.scad>;

$fn=50;

W = 70;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 5;    // thickness bottom plateau
H = 5;
O = 12; // side hole offset

difference(){
union(){
difference(){
union(){Centerframe(W,R,D,T,H,O, Nm = [], Nb = []);
translate([0,0,2*D]){base(W,R,D,0.5*T);}}
    for(i = [0:1]){
        rotate([0,0,90*i]){
translate([-15,0,1.25*D]){cube([30,2*W,2*D+0.1]);}}}
//translate([0,0,-4*D]){sideHoleSupports(2.2,W,3*D,O,alpha = 1.2);}
}	

    for(i = [0:3]){
        rotate([0,0,90*i]){
        translate([W/2-9,W/2-9,1.5*D]){baseRectangle(9,0.5*R,3*D);}
    }
    }
}

    for(i = [0:3]){
        rotate([0,0,90*i]){
        translate([W/2-O/3,W/2-O/3,2*D-1]){cylinder(6.2,2.2,2.2);}
    }}
}

difference(){
translate([0,0,1]){cube([W-O/2,W-O/2,2],center = true);}
for( ii = [0:2]){
rotate([0,0,120*ii]){
translate([0,14,0]){cylinder(8,1.5,1.5,center = true);}

rotate([0,0,60]){
translate([0,35/2,0]){cylinder(8,5,5,center = true);}}
}

}
cylinder(8,8,8,center = true);
}

///////////////////////////////////////////////
///////////////////////////////////////////////
module Centerframe(W,R,D,T,H,O, Nb = [0,1,2,3], Nm = [0,1,2,3]){ 
   
    difference(){
    union(){
    base(W,R,D,T);
    translate([0,0,D]){
        base(W,R,H,D);
    }
   
    
    //sideHoleSupports(5,W,D,O);
    }
    
    translate([0,0,-4*D]){
    //sideHoleSupports(2.2,W,3*D,O,alpha = 1.2);
    }
    
    for(i = [0:3]){
        rotate([0,0,90*i]){
        translate([-(0.85*W-2*O-10)/2,W/2-D-0.5*D,D]){ 
        cube([0.85*W-2*O-10,D,1.5*D]);}}
    }
    
    for(i = [0:3]){
    rotate([0,0,90*i]){
    union(){
    translate([-12-(0.5*W-2*O-14.5),W/2-D-0.5*D-D,3]){ 
    cube([0.5*W-2*O-14.5,2*D,1.5*D]);}
    translate([12,W/2-D-0.5*D-D,3]){ 
    cube([0.5*W-2*O-14.5,2*D,1.5*D]);}}}
    }
    
    }
    
    for(i = Nb){
        rotate([0,0,90*i]){
            bottomHoleSupport(0.85*R,W,D);
        }
    }
    
    for(i = Nm){
        rotate([0,0,90*i]){
            midHoleSupports(0.9*R,W,D);
        }
    }
    
}

module midHoleSupports(R,W,D){
    translate([0,-W/2+4,D/2]){
    difference(){
        union(){
    translate([-12,1,0]){baseRectangle(10,R,D);}
    translate([-5,1,0]){baseRectangle(10,R,D);}
    translate([2,1,0]){baseRectangle(10,R,D);}
    translate([0,1,0]){baseRectangle(10,R,D);}
    translate([-10,1,0]){baseRectangle(10,R,D);}
    }
    translate([-7.5,7,-D]){cylinder(2*D,2.2,2.2);}
    translate([7.5,7,-D]){cylinder(2*D,2.2,2.2);}
    }
    }
}   

module sideHoleSupports(R,W,D,O,alpha = 1){
    for(j = [0:3]){
        rotate([0,0,90*j]){
    for(i = [0:1]){
    translate([W/2-D,-W/2 + O + i*(W-2*O),2*D]){
        rotate([0,90,0]){
        cylinder(alpha*D,R,R);
        }
    }
    }
    }   
}
}

module base(W,R,D,T){
    
    translate([-W/2,-W/2,0]){
    translate([0,0,D/2]){
    difference(){
    baseRectangle(W,R,D);
    
    translate([T,T,0]){
    baseRectangle(W-2*T,0.8*R,2*D);}
    }
    }
    }
}

module bottomHoleSupport(R,W,D){
    
   
    translate([W/2-R+1,W/2-R+1,D/2]){
    rotate([0,0,180]){
        difference(){
            baseRectangle(O+3,5,D);
            translate([O-1.5,O-1.5,0]){
            cylinder(2*D,2,2.25,center = true);
    }
    }
    }
    }
}

module baseRectangle(W,R,D){
    translate([0,0,-D/2]){
    linear_extrude(D){
        rounded_square(W,0.75*R);
    }
    }
}