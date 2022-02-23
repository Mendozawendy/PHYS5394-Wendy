
   
%% Plot the Sinusoidal Signal function
% Signal parameters
freq0 = 2;  
phi0 = pi/2;
A = 10;
% Instantaneous frequency after 1 sec is 
maxFreq = freq0; %Maxmimum is equal to the constant frequency of the sinusoid

%5 times the Nyquist sampling frequency
%SDM: The Nyquist frequency is 2*maxFreq
samplFreq = 5*(2*maxFreq);
samplFreq = 30; %Hz
samplIntrvl = 1/samplFreq;

%1/2 of the Nyquist sampling frequency
%SDM: The Nyquist frequency is 2*maxFreq
samplFreq_2 = 1/2*(2*maxFreq);
samplIntrvl2 = 1/samplFreq_2;

% Time samples
timeVec = 0:samplIntrvl:1.0;
timeVec_2 = 0:samplIntrvl2:1.0;

% Number of samples
nSamples = length(timeVec);
nSamples_2 = length(timeVec_2);

% Generate the signal
sigVec = gensinusig(timeVec,A,freq0,phi0);
sigVec_2 = gensinusig(timeVec_2,A,freq0,phi0);

%Plot the signal 
figure;
plot(timeVec,sigVec,'Marker','.','MarkerSize',24);
title('Sinusoidal Signal'); 
xlabel('Time (sec)'); 
ylabel('Amplitude');

%SDM Plot of the second signal
figure;
plot(timeVec_2,sigVec_2,'Marker','.','MarkerSize',24);
title('Sinusoidal Signal'); 
xlabel('Time (sec)'); 
ylabel('Amplitude');


%Plot the periodogram
%--------------
%Length of data 
dataLen = timeVec(end)-timeVec(1);
dataLen_2 = timeVec_2(end)-timeVec_2(1);
%DFT sample corresponding to Nyquist frequency
kNyq = floor(nSamples/2)+1; %5 sample of the corresponding Nyquist Frequency
N_kNyq = floor(nSamples_2/2)+1; %1/2 sample of the corresponding Nyquist Frequency
% Positive Fourier frequencies
posFreq = (0:(kNyq-1))*(1/dataLen);
posFreq_2 = (0:N_kNyq-1)*(1/dataLen_2); 
% FFT of signal
fftSig = fft(sigVec);
fftSig_2 = fft(sigVec_2); 
% Discard negative frequencies
fftSig = fftSig(1:kNyq);
fftSig_2 = fftSig_2(1:N_kNyq);

%Plot periodogram
%FIXME These are periodograms, not the time series plots. Correct the plot
%labeling.
figure;
plot(posFreq,abs(fftSig),'Marker','.','MarkerSize',24);
title('Sinusoidal Signal Sampling 5 times Nyquist sampling Frequency'); 
xlabel('Time (sec)'); 
ylabel('Magnitude');
figure; 
plot(posFreq_2,abs(fftSig_2),'Marker','.','MarkerSize',24);
title('Sinusoidal Signal Sampling 1/2 times Nyquist Sampling Frequency'); 
xlabel('Time (sec)'); 
ylabel('Magnitude');





 
