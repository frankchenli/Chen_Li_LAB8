close all;
clear all;

% T11 = 1300; % white matter
% T12 = 3100; % CSF
% T13 = 1576; % Grey matter
T11 = 700; % white matter
T12 = 3700; % CSF
T13 = 1350; % Grey matter


TR = 6000; 
Tro = 2000;

T1_1 = T12;
T1_2 = T13;

% Null WM and GM

Ti = 1:TR;

E1 = exp(-Ti/T1_1);
ER = 0;
E2 = (1-ER)./(2*(1-E1));
firts_Ti_2 = -T1_1*log(E2);

clear E1 ER E2;


E1 = exp(-Ti/T1_2);
ER = 0;
E2 = (1-ER)./(2*(1-E1));
second_Ti_2 = -T1_2*log(E2);


plot(Ti, firts_Ti_2);
hold on
plot(Ti, second_Ti_2);




[mini,I] = min(abs(firts_Ti_2-second_Ti_2));

Ti1 = firts_Ti_2(I);
Ti2 = Ti(I);

        




