function r = customrandn(M,sigma, mu)
%Generates a normally distributed pseudo-random numbers 
%r = customrandn(sigma, mu)
%sigma is the standard deviation of the normal distribution
%mu is the mean of the normal distribution numbers
%M return an M by M matrix containing pseudorandm values 
%The function randn draws a trial values from the Normal PDF:N(X;0,1). 

%Wendy Mendoza, March 2022

X = randn(M,1);
r = sigma.* X + mu; 

end 

