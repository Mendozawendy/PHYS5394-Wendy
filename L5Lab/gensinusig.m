function sigVec = gensinusig(dataX,snr,freq0,phi0) 
% Generate a Sinusoidal signal 
% S = GENSINUSIG(X,SNR,FREQ0,PHI0) 
% Generate a Sinusoidal signal of S. 
% data X is the vector of time stamps at which the value of signal is to be
% computed. SNR is the matched filtering signal to noise of S. 
% Freq0 is the frequency of the sinusoidal oscillation
% Phi0 is the initial phase of the oscillation. 
%Unnormalized signal is defines as A. 
% s(t) = Asin(2*pi*freq0*t+phi0) 

% Wendy Mendoza, Jan 2022 
phaseVec = 2*pi*freq0*dataX+phi0;
sigVec = sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);   


