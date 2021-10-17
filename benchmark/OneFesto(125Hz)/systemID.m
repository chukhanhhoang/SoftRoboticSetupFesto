clc; clear; close all;
%D1 = load('repeating_take3_40s.mat');
D1 = load('sweep_take3_20s');

t = D1.data.Time;
U = D1.data.Data;

u =  Veab2kPa(U(:,1));
y =  Mpr2kPa(U(:,3));

Ts = t(2)-t(1);    % assuming uniform time grid
z  = iddata(y,u,Ts);

Y = fft(y);
U = fft(u);

model = tfest(z,3)
%bodemag(model);

compare(model,z); hold on;
plot(t,u)

%% conversion functions
function y = Veab2kPa(x)
y = 100*((x-5)/5);
end

function y = Mpr2kPa(x)
y = (x-1e3)/10;
end