% IR_script1.m
% 20230218 Div Bolar MD, PHD UCSD

addpath ./NIfTI_20140122/

% Inversion Recovery %
TI_IR = [  120; 200; 350; 400; 600; 800; 1000; 1200; 1400; 1600; 1800; 2000; 2500; 3000]';

filenames = dir('./IR_NIFTI/*.nii');

cd IR_NIFTI/

for i = 1:numel(filenames)
    IR_data(i) = load_nii(filenames(i).name)
end

cd ..

%%
    close all
    
    t= tiledlayout(2,7);
for j = 1:length(IR_data)
        nexttile
        image(IR_data(j).img);
        colormap ("gray");  axis square
        curTI = ['TI = ' num2str(TI_IR(j))];
        title(curTI)
end

title(t,'Agar phantom vs TI for Inversion Recovery Sequence', 'FontSize', 20)
% set(gcf, 'Position', [ 56        1103        2349         942])



