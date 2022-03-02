close all;
clear all;

%% Variables
m = 0.111;
R = 0.015;
g = -9.8;
L = 1.0;
d = 0.03;
J = 9.99e-6;

%% SS2 to x = [r rdot]
x10 = [0 0]';
s = tf('s');
A1 = [
    0 1;
    0 0
    ];
B1 = [0 -m*g*d/L/(J/R^2+m)]';
C1 = [1 0];
D1 = 0;
ss1 = ss(A1,B1,C1,D1);



%% Estimation of dynamic constants
PO = 0.05;
ts = 3;
zeta = abs(log(PO))/(sqrt(pi^2+log(PO)^2));
wn = 4/(zeta*ts);
p = roots([1 2*wn*zeta wn^2]);

%% Estimation of control 1 parameters
Ar1 = [A1 zeros(2,1);-C1 0];
Br1 = [B1;0];

p1 = [p;-50];
K1 = place(Ar1,Br1,p1);
Ki1 = -K1(3);
K1 = K1(1:2);

xi10 = 0;

%% SS2 to x = [r rdot alpha alphadot]
x20 = [0 0 0 0]';
A2 = [
   0 1 0 0
   0 0 -m*g/(J/(R^2)+m) 0
   0 0 0 1
   0 0 0 0
   ];
B2 = [0 0 0 1]';
C2 = [1 0 0 0]; 
D2 = 0;
ss2 = ss(A2,B2,C2,D2);

%% Estimation of control 2 parameters
Ar2 = [A2 zeros(4,1);-C2 0];
Br2 = [B2;0];

p2 = [p;-10;-20;-30];
K2 = place(Ar2,Br2,p2);
Ki2 = -K2(5);
K2 = K2(1:4);

xi20 = 0;

%% Simulation
out = sim('space_state.slx');

%% Plots

% Velocity
figure
plot(out.y1)
hold on
plot(out.y2)
legend({'$\omega_1(t)$','$\omega_2(t)$'},'Interpreter','latex')
title('Velocidade do motor')
xlabel('$t$','Interpreter','latex')
ylabel('$\omega(t)$','Interpreter','latex')
saveas(gcf,'imgs/y.png')

% Control
figure
plot(out.u1)
hold on
plot(out.u2)
legend({'$u_1(t)$','$u_2(t)$'},'Interpreter','latex')
title('Sinal de Controle')
xlabel('$t$','Interpreter','latex')
ylabel('$u(t)$','Interpreter','latex')
saveas(gcf,'imgs/u.png')
