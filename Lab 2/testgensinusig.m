%% Plot the Sinusoidal Signal function
% Signal parameters
freq0 = 11; %Freq0:11 been the best optional to see signal process. 
phi0 = pi/2;
A = 10;
% Instantaneous frequency after 1 sec is 
maxFreq = sqrt(5)*freq0;
samplFreq = 5*maxFreq;
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
 
