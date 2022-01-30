clear all;
close all;
load('motor.mat');

% sample times
h = 0.01;
h_motor = 1e-4;

% initial state
x0=[1;0];

% noise
noise_power = 1e-6;

% PRBS settings
h_PRBS = h;
gain_PRBS = 5;

% motor paramaters
Kt = 0.15;
Ka = 8.52;
Kg = 8.52;
K = 1.28;

out = sim('exp6_diagrama.slx',20);