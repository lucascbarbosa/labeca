function tau = tau_nep(steptime,initialvalue,finalvalue,times,values);
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
    idxs = find(values >= Vt_ss);
    idx = idxs(1);
    tr = times(idx);
    t = times(find(times < tr));
    y = values(find(times < tr));
    b = [];
    for i=1:length(y)
        b(i) = log(Vt_ss/(Vt_ss-y(i)));
        if Vt_ss <= y(i)
            disp(y(i));
        end
    end
    b = b(find(t>steptime));
    t = t(find(t>steptime));
    a = polyfit(t,b,1);
    a = a(1);
    tau = 1/a;
end