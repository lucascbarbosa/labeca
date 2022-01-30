clear all;
close all;
load('motor.mat');

% sample times
h = 1;
h_motor = 1e-4;

% initial state
x0=[1;0];

% noise
noise_power = 1e-6;

% PRBS settings
h_PRBS = h;
gain_PRBS = 1;
DC_PRBS = 4;

% motor paramaters
% Kt = 0.15;
% Ka = 8.52;
% Kg = 8.52;

% Simulate 
out = sim('exp6_diagrama.slx',20);

% Calculate matrices
Me = [out.Ia.signals.values out.Ue.signals.values];
Mm = [out.Vt.signals.values out.Um.signals.values];

% Apply OLS
xe = inv(Me'*Me)*Me'*out.Ia.signals.values;
xm = inv(Mm'*Mm)*Mm'*out.Vt.signals.values;

% Determine Phi and Gamma
Phie = xe(1);
Gammae = xe(2);

Phim = xm(1);
Gammam = xm(2);

% Estimate other parameters
Ra = (1-Phie)/Gammae;
La = -(Ra*h)/(log(Phie));
f = (1-Phim)/Gammam;
J = -(f*h)/(log(Phim));


