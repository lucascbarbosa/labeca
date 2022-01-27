% Setup
clear all;
close all;
load('motor.mat');
h = 1e-3;
tempo_total = 5;
h_motor = h*1e-1;
PO = 0.1;
ts = 2;

% Estimation of dynamic constants
zeta = abs(log(PO))/(sqrt(pi^2+log(PO)^2));
wn = 4/(zeta*ts);

% DC motor parameters
K = 1.2;
tau = 0.1077;

% Noise
noise_power = 0;
noise_freq = h_motor;

% PI control parameters
Kp = (2*zeta*wn*tau-1)/K;
Fi = (wn^2*tau)/(Kp*K);
Ti = 1/Fi;

% Reference
R_steptime = 0;
R_initialvalue = 5;
R_finalvalue = 10;

% Initial variables
x0 = [0;0];

% Deadzone limit
M = 0;

% Run simulation
out = sim('exp5_diagrama.slx',tempo_total);

% Plot Vt and R
figure(1)
plot(out.Vtd.time/h,out.Vtd.signals.values)
hold on
plot(out.ref.time/h,out.ref.signals.values)
legend('V_t(t_k)','R(t_k)')
xlabel('k')
ylabel('Signal')
title('Discrete time reference and V_t')
saveas(gcf,'imgs/response_ref.png')

% Plot
figure(2)
plot(out.Wt.time,out.Wt.signals.values)
xlabel('t')
ylabel('$\omega_t$','Interpreter','latex','FontSize',16)
title('Continuous time angular velocity')
saveas(gcf,'imgs/wt.png')

