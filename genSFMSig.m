function sigVec = genSFMSig(dataX,snr,timea,freq0,freq1)
 
% TO DO
% Generate a Step FM signal
% S = GENSFMSIG(DATAX,TIMEA,FREQ0,FREQ1)
% Generate a Step FM signal S. X is vector of the time stamps at which the value of the signal is to
% be computed. 
% SNR is the matched filtering signal-to-noise ratio of S.
% T is the time value for a peal of the curve. 
% Timea is the time value for a peal of the curve. 
% Freq0 is the frequency of sinusoidal oscillation.
% Freq1 is the frequency of sinusoidal oscillation. 

%SNR * sin(2*pi*freq0*t) ; t <=; ta 
%SNR * sin(2*pi*f1*(t-timea)+2*pi*freq0*timea) ; t >; ta 


%Wendy Mendoza, January 2021


% phaseVec = 2*pi*freq0*timea; 
% sfmSig = 2*pi*freq1*(dataX-timea)+2*pi*timea;
sigVec = sin(2*pi*freq0*dataX).*( dataX <= timea);
sigVec = sigVec+ sin(2*pi*freq1*(dataX-timea)+2*pi*freq0*timea).*(dataX >= timea);


sigVec = snr*sigVec/norm(sigVec);
 
