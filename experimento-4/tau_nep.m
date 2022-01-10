function tau = tau_nep(steptime,initialvalue,finalvalue,times,values);
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    t = times(find(times <= ts));
    y = values(1:length(t));
    val_steptime = values(find(times == steptime));
    K = ganho(steptime,initialvalue,finalvalue,times,values);
    Vt_ss = K*(finalvalue-initialvalue) + val_steptime;
    idxs = find(values >= Vt_ss);
    idx = idxs(1);
    tr = times(idx);
    t = times(find(times >= steptime & times < tr)) - steptime;
    y = values(find(times >= steptime & times < tr)) - val_steptime;
    b = [];
    for i=1:length(y)
        b(i) = log(Vt_ss/(Vt_ss-y(i)));
    end
    a = polyfit(t,b,1);
%     plot(t,b);
%     hold on;
%     plot(t,y);
    a = a(1);
    tau = 1/a;
end