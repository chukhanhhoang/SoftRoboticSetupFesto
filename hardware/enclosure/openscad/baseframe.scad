module Centerframe(W,R,D,T,H,O, Nb = [0,1,2,3], Nm = [0,1,2,3], Rm = 2.2){ 
   
    difference(){
    union(){
    base(W,R,D,T);
    translate([0,0,D]){
        base(W,R,H,D);
    }
    
    sideHoleSupports(5,W,D,O);
    }
    
    translate([0,0,-4*D]){
    sideHoleSupports(Rm,W,3*D,O);
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
            bottomHoleSupport(R,W,D,Rm);
        }
    }
    
    for(i = Nm){
        rotate([0,0,90*i]){
            midHoleSupports(0.95*R,W,D,Rm);
        }
    }
    
}

module midHoleSupports(R,W,D,Rm){
    translate([0,-W/2+4,D/2]){
    difference(){
        union(){
    translate([-12,2,0]){baseRectangle(10,R,D);}
    translate([-5,2,0]){baseRectangle(10,R,D);}
    translate([2,2,0]){baseRectangle(10,R,D);}
    translate([0,2,0]){baseRectangle(10,R,D);}
    translate([-10,2,0]){baseRectangle(10,R,D);}
    }
    translate([-7.5,8,-D]){cylinder(2*D,Rm,Rm);}
    translate([7.5,8,-D]){cylinder(2*D,Rm,Rm);}
    }
    }
}   

module sideHoleSupports(R,W,D,O){
    for(j = [0:3]){
        rotate([0,0,90*j]){
    for(i = [0:1]){
    translate([W/2-D,-W/2 + O + i*(W-2*O),2*D]){
        rotate([0,90,0]){
        cylinder(D,R,R);
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

module bottomHoleSupport(R,W,D,Rm){
    
    translate([W/2-R+1,W/2-R+1,D/2]){
    rotate([0,0,180]){
        difference(){
            baseRectangle(O+3,5,D);
            translate([O-2,O-2,0]){
            cylinder(2*D,Rm*0.9,Rm*1.1,center = true);
    }
    }
    }
    }
}

module baseRectangle(W,R,D){
    translate([0,0,-D/2]){
    linear_extrude(D){
        rounded_square(W,R);
    }
    }
}
