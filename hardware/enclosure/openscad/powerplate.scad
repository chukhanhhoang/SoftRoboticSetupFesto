$fn = 30;

wb = 17+1;
lb = 37+1;
hb = 4;

difference(){
union(){
cube([82,83,1]);

translate([0,83-lb-2,0]){
translate([wb+2,lb+2,hb]*0.5){
difference(){
cube([wb+2,lb+2,hb],center = true);
cube([wb,lb,hb],center = true);
}}}}


for(ii = [0,1,2,3]){
translate([27.5 + ii*15,10,0]){
hull(){
cylinder(1,2,2);
translate([0,83-20,0]){
cylinder(1,2,2);
}}}}

}