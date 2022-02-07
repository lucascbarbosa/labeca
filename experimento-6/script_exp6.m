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
freq_PRBS = 2;
gain_PRBS = 10;
DC_PRBS = 4;

% Simulate 
out = sim('exp6_diagrama.slx',10);

% Calculate matrices
Ia = out.Ia.signals.values;
Vt = out.Vt.signals.values;
Ue = out.Ue.signals.values;
Um = out.Um.signals.values;
Me = [Ia(1:length(Ia)-1) Ue(1:length(Ue)-1) ];
Mm = [Vt(1:length(Vt)-1) Um(1:length(Um)-1)];

% Apply LS
Ia_delay = Ia(2:length(Ia));
Vt_delay = Vt(2:length(Vt));

xe = inv(Me'*Me)*Me'*Ia_delay;
xm = inv(Mm'*Mm)*Mm'*Vt_delay;

% Determine Phi and Gamma
Phie = xe(1);
Gammae = xe(2);

Phim = xm(1);
Gammam = xm(2);

% Estimate other parameters
Ra_med = (1-Phie)/Gammae;
La_med = -(Ra_med*h)/(log(Phie));
f_med = (1-Phim)/Gammam;
J_med = -(f_med*h)/(log(Phim));