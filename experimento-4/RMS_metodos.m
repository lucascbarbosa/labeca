function [metodo,RMS]= RMS_metodos(time,samples,Vt_real,Vt_fun,Vt_area,Vt_nep,Vt_bode)
    Vt_real_avg = [];
    for i=samples+1:length(Vt_real)
        Vt_real_avg(i-samples)= mean(Vt_real(i-samples:i-1));
    end

    Vt_fun_avg = [];
    for i=samples+1:length(Vt_fun)
        Vt_fun_avg(i-samples)= mean(Vt_fun(i-samples:i-1));
    end
    RMS_fun = sqrt(mean((Vt_real_avg-Vt_fun_avg).^2));
    
    Vt_area_avg = [];
    for i=samples+1:length(Vt_area)
        Vt_area_avg(i-samples)= mean(Vt_area(i-samples:i-1));
    end
    RMS_area = sqrt(mean((Vt_real_avg-Vt_area_avg).^2));

    Vt_nep_avg = [];
    for i=samples+1:length(Vt_nep)
        Vt_nep_avg(i-samples)= mean(Vt_nep(i-samples:i-1));
    end
    RMS_nep = sqrt(mean((Vt_real_avg-Vt_nep_avg).^2));

    Vt_bode_avg = [];
    for i=samples+1:length(Vt_bode)
        Vt_bode_avg(i-samples)= mean(Vt_bode(i-samples:i-1));
    end
    RMS_bode = sqrt(mean((Vt_bode_avg-Vt_nep_avg).^2));
    
    RMS = min([RMS_fun RMS_area RMS_nep RMS_bode]);
    metodos = ["funcao" "area" "nep" "bode"];
    metodo = metodos(find([RMS_fun RMS_area RMS_nep RMS_bode]==RMS));
    
    plot(Vt_real_avg);
    hold on;
    plot(Vt_fun_avg);
    hold on;
    plot(Vt_area_avg);
    hold on;
    plot(Vt_nep_avg);
    hold on;
    plot(Vt_bode_avg);
    xlabel('amostras');
    ylabel('MM50 de V_t');
    legend(["V_{t_{real}}" "V_{t_{fun}}" "V_{t_{area}}" "V_{t_{nep}}" "V_{t_{bode}}"],'FontSize',14)
end