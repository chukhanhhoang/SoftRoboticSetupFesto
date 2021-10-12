include <roundsquare.scad>;
//include <VEAB.scad>;
include <powersupply.scad>;
include <baseframe.scad>;

$fn=40;

W = 125;  // width of base plate
R = 3;    // corner radius base plate
D = 5;    // thickness of walls
T = 8;    // thickness bottom plateau
H = 5;
O = 12; // side hole offset


color([0.4,0.4,0.4]);
rotate([0,0,180]){
    difference(){
hull(){
for(j = [0:1]){
translate([W/2+1,-W/2 + O,2*D + j*40]){
    rotate([0,90,0]){
    //cylinder(0.65*D,D,D);
}}}
}
for(j = [0:1]){
translate([W/2+1,-W/2 + O,2*D + j*40]){
    rotate([0,90,0]){
    translate([0,0,-1]){
    cylinder(2*D,2.2,2.2);}
    translate([0,0,0.35*D]){cylinder(0.5*D,3,3);}
}}}
}
}
// render components
translate([0,0,-3*D]){
//powersupply(W);
    }

rotate([0,0,-90]){
translate([-W/2+D,-W/2-D+89,18]){
//include <pi.scad>;
}
}

// render the powerplug
rotate([0,0,90]){
    
translate([W/2-40,W/2-W-D-1,25]){
    rotate([90,0,0]){
    color([0.24,0.24,0.34]){
    //import("powerplug.stl");
    }
    }
}
}

// render the open-frame 
color([0.4,0.4,0.4])
render()
{
    
    Centerframe(W,R,D,T,H,O,Nm = [1,3,4],Rm = 1.4);
    piMount(W,D);

    translate([0,0,-35]){
        //Centerframe(W,R,D,T,H,O);
    }
    
    translate([0,0,40]){
        //Centerframe(W,R,D,T,H,O, Nm = [1,2,3], Nb = [1,4]);
    }
    
    translate([0,0,100]){
        rotate([0,0,0]){
        //Centerframe(W,R,D,T,H,O);
        }
    }
    
    translate([0,0,155]){
        rotate([180,0,0]){
        //Centerframe(W,R,D,T,H,O, );
        }
    }
    
}

module piMountTower(){
    difference(){
    cylinder(12+D,4.25,4.25);
    translate([0,0,4*D]){
        rotate([0,180,0]){
    cylinder(10,1.4,1.4);}}}
}

module piMount(W,D){
        translate([-W/2+D+21,W/2-D,0]){
        piMountTower();
    }
    
    translate([-W/2+D+21+58,W/2-D,0]){
        piMountTower();
    }
    
    translate([-W/2+D+21,W/2-D - 49,0]){
        hull(){
        cylinder(D,5,5);
        translate([-20,0,D/2]){
        cube([10,18,D],center = true);}}
        piMountTower();
    }
}