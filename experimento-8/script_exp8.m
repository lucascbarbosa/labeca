close all;
clear all;

%% Variables
m = 0.111;
R = 0.015;
g = -9.8;
L = 1.0;
d = 0.03;
J = 9.99e-6;

%% Transfer function to x = [r rdot]

s = tf('s');
A1 = [
    0 1;
    0 0
    ];
B1 = [0 -m*g*d/L/(J/R^2+m)]';
C1 = [1 0];
D1 = 0;
ss1 = ss(A1,B1,C1,D1);
[NUM1,DEN1] = ss2tf(A1,B1,C1,D1);
G1 = tf(NUM1,DEN1);

%% Estimation of dynamic constants
PO = 0.05;
ts = 3;
zeta = abs(log(PO))/(sqrt(pi^2+log(PO)^2));
wn = 4/(zeta*ts);
p1 = roots([1 2*wn*zeta wn^2]);

%% Estimation of control 1 parameters
Kp1 = wn^2/NUM1(3);
Td1 = (2*zeta*wn)/NUM1(3);


%% Transfer function to x = [r rdot alpha alphadot]
A2 = [
   0 1 0 0
   0 0 -m*g/(J/(R^2)+m) 0
   0 0 0 1
   0 0 0 0];
B2 = [0 0 0 1]';
C2 = [1 0 0 0];
D2 = 0;
ss2 = ss(A2,B2,C2,D2);
[NUM2,DEN2] = ss2tf(A2,B2,C2,D2);
G2 = tf(NUM2,DEN2);