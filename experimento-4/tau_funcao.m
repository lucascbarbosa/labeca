function tau = tau_funcao(steptime,initialvalue,finalvalue,times,values);
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    values_ss = [];
    j = 1;
    val_steptime = values(find(times == steptime));
    times_steptime = times(find(times > steptime));
    for i=1:length(times_steptime)
        time = times_steptime(i);
        if time >= ts 
            values_ss(j) = values(i);
            j = j+1;
        end
    end
    Vt_ss = sum(values_ss)/length(values_ss);
    idxs = find(values>=0.63*(Vt_ss-val_steptime)+val_steptime);
    tau = times(idxs(1)) - steptime;
end