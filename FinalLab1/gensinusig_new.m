%%Objective: Modify the function you wrote for generating your assigned signal to use a ‘struct’ as the
%input argument for specifying the signal parameters. 

function sigVec = gensinusig_new(dataX,snr,P) 
% Generate a Sinusoidal signal 
% S = GENSINUSIG(X,SNR,FREQ0,PHI0) 
% Generate a Sinusoidal signal of S. 
% data X is the vector of time stamps at which the value of signal is to be
% computed. SNR is the matched filtering signal to noise of S.
% P is the struct containing values for sinusoidal oscillations 
% P.freq0 is the frequency of the sinusoidal oscillation
% P.phi0 is the initial phase of the oscillation. 
% Unnormalized signal is defines as A. 
% s(t) = Asin(2*pi*freq0*t+phi0) 

% Wendy Mendoza, April 2022 
phaseVec = 2*pi*P.freq0*dataX+P.phi0;
sigVec = sin(phaseVec);
sigVec = snr*sigVec/norm(sigVec);

end 

