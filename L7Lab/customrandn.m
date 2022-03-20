function r = customrandn(M,sigma, mu)
%Generates a normally distributed pseudo-random numbers 
%FIXME The help comment below is missing the first input argument
%r = customrandn(sigma, mu)
%sigma is the standard deviation of the normal distribution
%mu is the mean of the normal distribution numbers
%FIXME The help says "M by M" but the code returns (M,1) array. We want the
%M return an M by M matrix containing pseudorandm values 
%The function randn draws a trial values from the Normal PDF:N(X;0,1). 

%Wendy Mendoza, March 2022

X = randn(M,1);
r = sigma.* X + mu; 

end 

