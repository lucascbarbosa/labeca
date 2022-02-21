clear all;
close all;
load('motor.mat');
%% Variables
syms K_i s 
K_r = sym('K_r',[1 2]);
% noise
noise_power = 0;
% reference
steptime = 0;
initialvalue = 0;
finalvalue = 1;
% initial state 
x0 = [1;0];

%% Estimation of dynamic constants
PO = 0.1;
ts = 0.2;
zeta = abs(log(PO))/(sqrt(pi^2+log(PO)^2));
wn = 4/(zeta*ts);
p = roots([1 2*wn*zeta wn^2]);

%% Estimation of gain
A_r = [A zeros(2,1);-C 0];
B_r = [B;0];

p = [p;-50];
K = place(A_r,B_r,p);
K_r = K(1:2);
K_i = -K(3);
out = sim('realimentacao_estados.slx',2);

%% Plots
% u
figure;
plot(out.u.time,out.u.signals.values)
xlabel('$t$','Interpreter','latex');
ylabel('$u(t)$','Interpreter','latex');
title('Sinal de controle');
saveas(gcf,'imgs/u.png');

% W x R
figure;
plot(out.W.time,out.W.signals.values)
hold on;
yline(finalvalue,'label','Reference');
xlabel('$t$','Interpreter','latex');
ylabel('$\omega(t)$','Interpreter','latex');
title('Velocidade do motor CC');
saveas(gcf,'imgs/w.png');

