function tau = tau_area(steptime,initialvalue,finalvalue,times,values)
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    K = ganho(steptime,initialvalue,finalvalue,times,values);
    t = times(find(times >= steptime & times <= ts));
    val_steptime = values(find(times == steptime));
    y = K*finalvalue + val_steptime - values(find(times >= steptime & times <= ts));
    A0 = trapz(t,y);
    tau = A0/K;
end