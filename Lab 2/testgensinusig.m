%% Plot the Sinusoidal Signal function
% Signal parameters
%FIXME documentation should explain what the unit for frequency used here
%is (i.e., Hz)
freq0 = 11; %Freq0:11 been the best optional to see signal process. 
phi0 = pi/2;
A = 10;
% Instantaneous frequency after 1 sec is 
%FIXME The lab instruction required setting the sampling interval yourself:
%The sqrt(5) factor makes no sense here. See the next FIXME comment.
maxFreq = sqrt(5)*freq0;
samplFreq = 5*maxFreq;
%FIXME Specifying the sampling interval for this lab by hand...
samplFreq = 30;%Hz
samplIntrvl = 1/samplFreq;

% Time samples
timeVec = 0:samplIntrvl:1.0;
% Number of samples
nSamples = length(timeVec);

% Generate the signal
sigVec = gensinusig(timeVec,A,freq0,phi0);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('Sinusoidal Signal'); 
%FIXME Label the X-axis ('Time (sec)')
 
