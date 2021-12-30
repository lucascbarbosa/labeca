function [Lw,LgGw] = entrada(n,f1,f2,K,Tau)
Ln=0:n-1;
Llogf=exp(log(f1)+Ln*(log(f2)-log(f1))/(n-1)); % passo de frequencia numa escala log
Lw=2*pi*Llogf;
G=tf(K,[Tau 1]);
LgGw=[];

for w0 = Lw
    LgGw=[LgGw 20*log10(abs(evalfr(G,w0*1i)))];
end
end