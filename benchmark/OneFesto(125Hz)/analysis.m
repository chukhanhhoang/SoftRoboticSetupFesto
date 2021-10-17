clc; close all; clear;
D0 = load('repeating_take3_40s.mat');
D1 = load('sweep_take4_20s.mat');

t0 = D0.data.Time;
U0 = D0.data.Data;
t1 = D1.data.Time;
U1 = D1.data.Data;

o1 = Veab2kPa(U0(1,2));
o2 = Mpr2kPa(U0(1,3));

plot(t0,(Veab2kPa(U0(:,2))-o1) - (Mpr2kPa(U0(:,3))-o2),'linew',3);

%%
subplot(2,2,1);
plot(t0,Veab2kPa(U0(:,1)),'--','linew',3); hold on;
plot(t0,Veab2kPa(U0(:,2))-o1,'linew',3); 
plot(t0,Mpr2kPa(U0(:,3))-o2,'linew',3);  

subplot(2,2,3);
plot(t0,Mpr2kPa(U0(:,3)) - Veab2kPa(U0(:,1)),'linew',3);  
axis([0,t0(end),-40,40]);
%%
subplot(2,2,2);
plot(t1,Veab2kPa(U1(:,1)),'--','linew',3); hold on;
plot(t1,Veab2kPa(U1(:,2))-o1,'linew',3); 
plot(t1,Mpr2kPa(U1(:,3))-o2,'linew',3);  

subplot(2,2,4);
plot(t1,Mpr2kPa(U1(:,3)) - Veab2kPa(U1(:,1)),'linew',3);  
axis([0,t1(end),-40,40]);
%% conversion functions
function y = Veab2kPa(x)
y = 100*((x-5)/5);
end

function y = Mpr2kPa(x)
y = (x-1e3)/10;
end