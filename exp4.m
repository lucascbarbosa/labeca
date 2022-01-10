clear
close all
load("motor.mat")
% out => resposta degrau
% linsys => bode resposta

%% Variables exp2
steptime=0;
initialvalue=0;
finalvalue=5;
times=out.Vt1.time;
values=out.Vt1.signals.values;

%% fabricacao dos Tau e K do exp2
Tau_a=tau_area(steptime,initialvalue,finalvalue,times,values);
Tau_n=tau_nep(steptime,initialvalue,finalvalue,times,values);
Tau_fun=tau_funcao(steptime,initialvalue,finalvalue,times,values);
K_t=ganho(steptime,initialvalue,finalvalue,times, values);

%% fabricacao dos Tau e K do exp3 so do grau 4
grau=4;
[mag,phase,Lw] = bode(linsys1);
Lw=transpose(Lw);
Lg=[];
for k=1:length(mag)
    Lg=[Lg mag(:,:,k)];
end
Lg=20*log10(Lg);

[Wc_freq,Tau_freq,K_freq] = resp_exp3(Lw,Lg,grau);



