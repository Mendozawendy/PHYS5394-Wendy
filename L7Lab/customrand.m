function ru = customrand(M,a,b)

%Generate uniformly distributed pseudo-random numbers 
%FIXME The help comment below is missing the first input argument
%ru = costumrand(a,b) 
%ru between the open interval(a,b) 
%FIXME The help says "M by M" but the code returns (M,1) array. We want the
%latter, so fix the help.
%a and b are the boundaries of the uniform probability distribution
%M returns M by M with pseudorandom values uniformly distributed
%function. The function rand draws a trials value from the uniform PDF U(x;0,1). 

%Wendy Mendoza, March 2022

X = rand(M,1);
ru = (b-a).* X + a;  

end 