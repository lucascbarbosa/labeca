clear all;
close all;
load('motor.mat');

% sample times
h = 1e-2;
h_motor = h*1e-3;

% initial state
x0=[1;0];

% noise
noise_power = 0;

% PRBS settings
gain_PRBS = 2;
DC_PRBS = 4;

% Simulate 
out = sim('exp6_diagrama.slx',10);

% Calculate matrices
Me = [out.Ia.signals.values out.Ue.signals.values];
Mm = [out.Vt.signals.values out.Um.signals.values];

% Apply LS
xe = inv(Me'*Me)*Me'*out.Ia.signals.values;
xm = inv(Mm'*Mm)*Mm'*out.Vt.signals.values;

% Determine Phi and Gamma
Phie = xe(1);
Gammae = xe(2);

Phim = xm(1);
Gammam = xm(2);

% Estimate other parameters
Ra_med = (1-Phie)/Gammae;
La_med = -(Ra*h)/(log(Phie));
f_med = (1-Phim)/Gammam;
J_med = -(f*h)/(log(Phim));


