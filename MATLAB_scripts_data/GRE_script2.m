% GRE_script2.m
% 20230218 Div Bolar MD, PHD UCSD

close all;
filenames = dir('./GRE_NIFTI/*.nii');

cd GRE_NIFTI/

for i = 1:numel(filenames)
    GRE_data(i) = load_nii(filenames(i).name)
end

cd ..



% Gradient Echo EPI %
TE_GRE = [  20; 30; 40; 50; 60; 70; 80; 90; 100; 120; 140; 160]';

figure

forROIdrawing = GRE_data(1).img;
imagesc(GRE_data(1).img);
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

for k = 1:length(GRE_data)
    meanSI_GRE(k) = mean ( GRE_data(k).img(mask)) ;
end
    

%%
% Now, you have your mean signal intensity for the ROI across all TEs
meanSI_GRE

% And your TEs
TE_GRE

%%  Plot SI versus TE
figure
plot (TE_GRE, meanSI_GRE, 'bo'); hold 
plot(TE_GRE, meanSI_GRE, 'r-')

title ('SI versus TE -- Gradient Echo', 'FontSize', 18)
xlabel(' TI (ms)', 'FontSize', 14)
ylabel('SI (AU)', 'FontSize', 14)

% -----------------------------------


%%
% Modify your MATLAB code to solve for T2* (T2 star) relaxation.  What value do you find?


curve = meanSI_GRE;
maxi = max(curve);

xdata = TE_GRE;
ydata = curve;

fun = @(x, xdata) x(1)*exp(-xdata/x(2))+x(3)*exp(-xdata/x(2));


x0 = [180,200,100];
x = lsqcurvefit(fun,x0,xdata,ydata)


times = linspace(xdata(1),xdata(end));
figure; plot(times, fun(x,times));hold on; plot(xdata,meanSI_GRE);
legend('fit','original')













