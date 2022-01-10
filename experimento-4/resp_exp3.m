function [Wc_exp,Tau_exp,K_exp] = resp_exp3(Lw,Lg,grau)
%% Ass BF
wbf = Lw(find(Lw<1));
gbf= Lg(find(Lw<1));
Dbf=round(minquad(log10(wbf),gbf,1),3);
dbf=Dbf(1)*log10(Lw)+Dbf(2);
%% Ass HF
whf = Lw(find(Lw>10));
ghf= Lg(find(Lw>10));
Dhf=round(minquad(log10(whf),ghf,1),3);
dhf=Dhf(1)*log10(Lw)+Dhf(2);

%% Poly 4
Cpoly=[];
Poly=[round(minquad(log10(Lw),Lg,grau),3)];
for i =0:grau
    Cpoly(:,i+1)=(Poly(i+1)*log10(Lw).^(grau-i));
end
Poly=sum(transpose(Cpoly));

%% plot
figure(2)
leg=["Resposta","Ass BF","Ass HF"];
semilogx(Lw,Lg,'b--','LineWidth', 1.5);
hold on
plot(Lw,dbf,'r');
plot(Lw,dhf,'r');
plot(Lw,Poly,'k','LineWidth', 1.5)
R2=fitlm(Lg,Poly).Rsquared.Ordinary;
leg=[leg 'poly4, R²='+string(R2)];
legend(leg)

%% valor de Wc, Tau e K
[diff,idw]=min(abs(Poly-dbf+3)); 
Wc_exp=Lw(idw);
Kdb=Poly(idw);
Tau_exp=1/Wc_exp;
K_exp=10^((3+Kdb)/20);

txt = {'Wc_e_x_p='+string(Wc_exp),'Tau_e_x_p='+string(Tau_exp),'K_e_x_p='+string(K_exp)};
text(1,-50,txt)
hold off

end