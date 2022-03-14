function ru = customrand(M,a,b)

%Generate uniformly distributed pseudo-random numbers 
%ru = costumrand(a,b) 
%ru between the open interval(a,b) 
%a and b are the boundaries of the uniform probability distribution
%M returns M by M with pseudorandom values uniformly distributed
%function. The function rand draws a trials value from the uniform PDF U(x;0,1). 

%Wendy Mendoza, March 2022

X = rand(M,1);
ru = (b-a).* X + a;  

end 