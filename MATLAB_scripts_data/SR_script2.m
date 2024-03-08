% SR_script2.m
% 20230218 Div Bolar MD, PHD UCSD
close all;
% Saturation Recovery %
TI_SR= [  110; 200; 400; 600; 800; 1000; 1200; 1400; 1600; 1800; 2000; 2500; 3000]';

figure

forROIdrawing = SR_data(j).img;
image(SR_data(j).img);
colormap ("gray");  axis square

% -----------------------------------------
% Use "drawcircle"to selective a decent size ROI from center of image. 

display('**********************')
display('***** Draw ROI! ******')
display('**********************')

title('Draw ROI!', 'FontSize', 18)

ROI = drawcircle(gca);  %% PLEASE INTERACT WITH IMAGE %%
mask = createMask(ROI);

% ------------------------------------

% This applies the mask you just created to ALL the images in the series

for k = 1:length(SR_data)
    meanSI_SR(k) = mean ( SR_data(k).img(mask)) ;
end
    

%%
% Now, you have your mean signal intensity for the ROI across all TIs
meanSI_SR

% And your TIs
TI_SR

%%  Plot SI versus TI
figure
plot (TI_SR, meanSI_SR, 'bo'); hold 
plot(TI_SR, meanSI_SR, 'r-')

title ('SI versus TI -- Saturation Recovery', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)

% -----------------------------------


%%
% Write MATLAB code that uses the expression for Saturation Recovery and fit for T1

curve = meanSI_SR;
maxi = max(curve);

xdata = TI_SR;
ydata = curve;

fun = @(x, xdata) x(1)*exp(-xdata/x(2))+x(3)*(1-exp(-xdata/x(2)));


x0 = [180,200,100];
x = lsqcurvefit(fun,x0,xdata,ydata)


times = linspace(xdata(1),xdata(end));
figure; plot(times, fun(x,times));hold on; plot(xdata,curve);
legend('fit','original')







