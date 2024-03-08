% IR_script2.m
% 20230218 Div Bolar MD, PHD UCSD

% Inversion Recovery %
close all;
TI_IR = [  120; 200; 350; 400; 600; 800; 1000; 1200; 1400; 1600; 1800; 2000; 2500; 3000]';

tTi = [120 200 350 400 600 800 1000 1400 1600 1800 2000 2500 3000 4000 5000 6000 7000 9000];
intensity_white = [81 63 32 23 7 31 51 80 90 98 105 117 123 131 134 134 135 133];
intensity_CSF = [118 168 140 116 87 102 82 49 13 20 9 28 53 71 99 118 136 158];
intensity_grey = [96 89 65 58 32 15 7 36 50 61 71 91 105 123 133 139 141 144];




figure
forROIdrawing = IR_data(j).img;
image(IR_data(j).img);
colormap ("gray");  axis square

% -----------------------------------------
% Use "drawcircle"to selective a decent size ROI from center of image. 

display('**********************')
display('***** Draw ROI! ******')
display('**********************')

title('Draw ROI!', 'FontSize', 18)

ROI = drawcircle(gca);  %% PLEASE INTERACT WITH IMAGE
mask = createMask(ROI);

% ------------------------------------

% This applies the mask you just created to ALL the images in the series

for k = 1:length(IR_data)
    meanSI_IR(k) = mean ( IR_data(k).img(mask)) ;
end
    

%%
% Now, you have your mean signal intensity for the ROI across all TIs
meanSI_IR

% And your TIs
TI_IR

%%  Plot SI versus TI
figure
plot (TI_IR, meanSI_IR, 'bo'); hold 
plot(TI_IR, meanSI_IR, 'r-')

title ('SI versus TI -- Inversion Recovery', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)

% -----------------------------------

% flip curve 
[mini,I] = min(meanSI_IR);
if mini>=0
    meanSI_IR(1:I-1) = -meanSI_IR(1:I-1);
elseif mini <0
    meanSI_IR(1:I) = -meanSI_IR(1:I);
end

figure; 
plot (TI_IR, meanSI_IR, 'bo'); hold 
plot(TI_IR, meanSI_IR, 'r-')

title ('SI versus TI -- Inversion Recovery', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)


% solve for T1


curve = meanSI_IR;

xdata = TI_IR;
ydata = curve;

fun = @(x, xdata) x(1)*exp(-xdata/x(2))+x(3)*(1-exp(-xdata/x(2)));

x0 = [180,200,100];
x = lsqcurvefit(fun,x0,xdata,ydata)


times = linspace(xdata(1),xdata(end));
figure; plot(times, fun(x,times),'b');hold on; plot(xdata,curve,'r-');
legend('fit','original')









