function tau = tau_area(steptime,initialvalue,finalvalue,times,values);
    S = stepinfo(times,values);
    ts = S.SettlingTime;
    t = times(find(times <= ts));
    y = values(1:length(t));
    A0 = trapz(t,y);
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
    tau = A0/Vt_ss;
end