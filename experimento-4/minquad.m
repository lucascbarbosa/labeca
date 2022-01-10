function Lcoef = minquad(x,b,grau)
A=[];
x=transpose(x);
b=transpose(b);
for k = 0:grau
    A=[A x.^(grau-k)];
end
A=A; 
Lcoef=(transpose(A)*A)\transpose(A)*b;
end