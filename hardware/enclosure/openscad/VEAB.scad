// render VEAB
union(){
translate([0,20,9+2*D]){
rotate([0,0,90]){
translate([0,0,0]){
    
color([0.95,0.75,0.75]){
cube([53,84,18], center= true);
}}}

translate([84/2-8,-53/2,0]){
rotate([90,0,0]){cylinder(8,3.5,3.5);}

translate([-84+20,0,0]){
rotate([90,0,0]){cylinder(2,4,4);}}

translate([-84+15,53+2,0]){
rotate([90,0,0]){cylinder(2,4,4);}}

translate([-84+25,53+2,0]){
rotate([90,0,0]){cylinder(2,4,4);}}
}
}
}