clear all; close all;


tTi = [120 200 350 400 600 800 1000 1400 1600 1800 2000 2500 3000 4000 5000 6000 7000 9000];
intensity_white = [81 63 32 23 7 31 51 80 90 98 105 117 123 131 134 134 135 133];
intensity_CSF = [118 168 140 116 87 102 82 49 13 20 9 28 53 71 99 118 136 158];
intensity_grey = [96 89 65 58 32 15 7 36 50 61 71 91 105 123 133 139 141 144];





intensity(1,:) = intensity_white;
intensity(2,:) = intensity_CSF;
intensity(3,:) = intensity_grey;
xdata = tTi;


for i = 1:size(intensity,1)
    curve = intensity(i,:);

    [mini,I] = min(curve);
    if mini>=0
        curve(1:I-1) = -curve(1:I-1);
    elseif mini <0
        curve(1:I) = -curve(1:I);
    end
   
    % figure;
    % plot (tTi, curve, 'bo'); 
    % hold on
    % plot(tTi, curve, 'r-');
    % title ('SI versus TI -- Inversion Recovery', 'FontSize', 18)
    % xlabel(' TI (ms)', 'FontSize', 14)
    % ylabel('SI (AU)', 'FontSize', 14)


    curve = [-81 -63 -32 -23 7 31 51 80 90 98 105 117 123 131 134 134 135 133];;




    ydata = curve;
    
    fun = @(x, xdata) x(1)*exp(-xdata/x(2))+x(3)*(1-exp(-xdata/x(2)));
    
    x0 = [100,800,150];
    x = lsqcurvefit(fun,x0,xdata,ydata)
    
    
    times = linspace(xdata(1),xdata(end));
    figure; plot(times, fun(x,times),'b');hold on; plot(xdata,curve,'r-');
    legend('fit','original')
    title ('SI versus TI -- Inversion Recovery ', 'FontSize', 18)
    xlabel(' TI (ms)', 'FontSize', 14)
    ylabel('SI (AU)', 'FontSize', 14)

end









