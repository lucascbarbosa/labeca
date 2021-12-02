function tau = tau_funcao(steptime,initialvalue,finalvalue,times,values);
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    values_ss = [];
    j = 1;
    for i=1:length(times)
        time = times(i);
        if time >= ts 
            values_ss(j) = values(i);
            j = j+1;
        end
    end
    Vt_ss = sum(values_ss)/length(values_ss);
    idxs = find(values>=0.63*Vt_ss);
    tau = times(idxs(1));
end