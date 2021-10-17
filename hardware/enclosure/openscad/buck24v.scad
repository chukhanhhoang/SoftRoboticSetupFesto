$fn = 30;
Wb = 17;
Lb = 50;
Hb = 12;
D = 3;

buckholder(Wb,Lb,Hb);

module buckholder(Wb,Lb,Hb,D = 3){
difference(){
translate([0,0,Wb/2]){
rotate([0,90,0]){
difference(){
cube([Wb+D,Lb+D,Hb+D],center = true);
cube([2*Wb,Lb,Hb],center = true);
}}}

for(i=[-1,1]){
translate([0,i*Lb/2,14]){
cube([1.25*D,Wb/2,15],center =true);
}}
}

translate([0,0,-.5]){
cube([Hb,Lb,2],center=true);
}
}