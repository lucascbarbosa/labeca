clear
close all

%% Fabricaçao entrada
n=200;
f1=10^(-3);
f2=10^1;
Tau=1;
K=1;
[w,gjwdb]=entrada(n,f1,f2,K,Tau);
%% Ass BF
wbf = w(find(w<1));
gbf= gjwdb(find(w<1));
Dbf=round(minquad(log10(wbf),gbf,1),3);
dbf=Dbf(1)*log10(w)+Dbf(2);
%% Ass HF
whf = w(find(w>1));
ghf= gjwdb(find(w>1));
Dhf=round(minquad(log10(whf),ghf,1),3);
dhf=Dhf(1)*log10(w)+Dhf(2);

%% Polynomio
LCpoly=[];
Cpoly=[];
for k = 1:4
    Poly=[round(minquad(log10(w),gjwdb,k),3)];
    for i =0:k
        Cpoly(:,i+1)=(Poly(i+1)*log10(w).^(k-i));
    end
    LCpoly(:,k)=sum(transpose(Cpoly));
end

%% Plots + coef regressao
LR2=[];
leg=["Resposta","Ass BF","Ass HF"];

figure(1);
semilogx(w,gjwdb,'+');
hold on;
plot(w,dbf,'r');
plot(w,dhf,'r');
for k = 1:4
    plot(w,LCpoly(:, k))
    R2=fitlm(gjwdb,LCpoly(:, k)).Rsquared.Ordinary;
    leg=[leg 'poly'+string(k)+' R²='+string(R2)];
    LR2=[LR2 R2];
end
legend(leg)
hold off;

%% valor de Wc, Tau e K

poly4=LCpoly(:, 4);
[diff,idw]=min(abs(poly4+3)); 
Wc=w(idw);
Kdb=poly4(idw);

Tau_exp=1/Wc
K_exp=10^(Kdb/20)
