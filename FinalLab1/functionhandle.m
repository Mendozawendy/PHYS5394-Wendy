%%Function handle to plot the time series of the signal for SNR values 10,
%%12 and 15
% Signal parameters
P = struct('freq0', 20,...
            'phi0', pi/2.0);
A = 10; %Amplitude
SNR1 = 10; 
SNR2 = 12;
SNR3 = 15;
% Instantaneous frequency 
maxFreq = P.freq0; %Maxmimum is equal to the constant frequency of the sinusoid

%5 times the Nyquist sampling frequency
samplFreq = 5*(2*maxFreq);
%samplFreq = 1024; %Hz
samplIntrvl = 1/samplFreq;
% Time samples
timeVec = 0:samplIntrvl:.1;
% Number of samples
nSamples = length(dataX); 

%Function handle to gensinusig_new 
H = @(snr) gensinusig_new(timeVec, snr, P); 

% Generate the signal
sigVec1 = H(SNR1);
sigVec2 = H(SNR2);
sigVec3 = H(SNR3);

%Plot the time series of signals SNR: 10, 12, & 15
figure;
plot(timeVec,sigVec1,'Marker','.','MarkerSize',24);
title('Time Series of Sinusoidal Signal SNR:10 '); 
xlabel('Time (sec)'); 
ylabel('Amplitude'); 
figure; 
plot(timeVec,sigVec2,'Marker','.','MarkerSize',24);
title('Time Series of Sinusoidal Signal SNR:12 '); 
xlabel('Time (sec)'); 
ylabel('Amplitude'); 
figure; 
plot(timeVec,sigVec3,'Marker','.','MarkerSize',24);
title('Time Series of Sinusoidal Signal SNR:15 '); 
xlabel('Time (sec)'); 
ylabel('Amplitude'); 
