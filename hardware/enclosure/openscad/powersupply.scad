// render powerbox
$fn = 30;

//powersupply(1);

module powersupply(W){
//W1 = 36;
//W2 = 99;
//W3 = 97;    
W1 = 30;
W2 = 82;
W3 = 99;    
    
difference(){
rotate([0,90,0]){
color([0.75,0.75,0.99]){
cube([W1,W2,W3], center= true);
}
}

union(){
translate([-99/2-.01,-40.5-2,-15.5]){cube([14,80,26]);}

translate([-99/2+4.5,-40.5+5.5,10.1]){cylinder(5,3.5/2,3.5/2);}

translate([99/2-2,+40.5 - 6.5,-20.1]){cylinder(50,3.5/2,3.5/2);
    translate([0,-3.5/2,0]){cube([3.5,3.5,50]);}
    }

translate([99/2-15,30.5,0]){rotate([-90,0,0]){cylinder(15,1.5,1.5);}}
translate([-99/2+10,30.5,0]){rotate([-90,0,0]){cylinder(15,1.5,1.5);}}    
    
}
}


}
