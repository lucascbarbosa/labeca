function tau = tau_area(steptime,initialvalue,finalvalue,times,values)
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    K = ganho(steptime,initialvalue,finalvalue,times,values);
    t = times(find(times >= steptime & times <= ts));
    val_steptime = values(find(times == steptime));
    Vt_ss = K*(finalvalue-initialvalue) + val_steptime;
    y = Vt_ss - values(find(times >= steptime & times <= ts));
    A0 = trapz(t,y);
    tau = A0/(Vt_ss - val_steptime);
end