function tau = tau_area(steptime,initialvalue,finalvalue,times,values)
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    t1 = times(find(times <= steptime));
    K = ganho(steptime,initialvalue,finalvalue,times,values);
    y1 = K*initialvalue - values(find(times <= steptime));
    A0_1 = trapz(t1,y1);
    t2 = times(find(times >= steptime & times <= ts));
    y2 = K*finalvalue - values(find(times >= steptime & times <= ts));
    A0_2 = trapz(t2,y2);
    A0 = A0_1 + A0_2;
    tau = A0/K;
end