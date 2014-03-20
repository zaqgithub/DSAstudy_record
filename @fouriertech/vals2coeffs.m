function coeffs = vals2coeffs(values)
%VALS2COEFFS   Convert values at equally spaced points between [-pi pi).
%   TODO: NEEDS UPDATING
%   C = VALS2COEFFS(V) returns the vector of N coefficients such that 
%
%   If N is odd
%       F(x) = C(1)*z^(N-1)/2 + C(2)*z^((N-1)/2-1) + ... + C(N)*z^(-(N-1)/2)
%   If N is even
%       F(x) = C(1)*z^(N/2-1) + C(2)*z^(N/2-2) + ... + C(N-1)*z^(-N/2-1) +
%                  1/2*C(N)*(z^(N/2) + z^(-N/2))
%   where z = exp(1i*x) and -pi <= x <= pi. 
%   F(x) interpolates the data [V(1) ; ... ; V(N)] at the N equally 
%   spaced points x_k = -pi + 2*k/N, k=0:N-1. 
%
%   If the input V is an (N+1)xM matrix, then C = VALS2COEFFS(V) returns the
%   (N+1)xM matrix of coefficients C such that F_j(x) intterpolates
%   [V(1,j) ; ... ; V(N+1,j)] for j=1:M using the same formula as above for
%   each column.
%
% See also COEFFS2VALS, FOURIERPTS.

% Copyright 2014 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org for Chebfun information.

% Get the length of the input:
n = size(values, 1);

% Trivial case (constant):
if ( n <= 1 )
    coeffs = values; 
    return
end

coeffs = (1/n)*flipud(fftshift(fft(values,[],1),1));

% These coefficients are for interpolation defined on [0,2*pi), but we want
% to work on [-pi,pi).  To fix the coefficients for this we just need to
% assign c_k = (-1)^k c_k, for k=-(N-1)/2:(N-1)/2 for N odd and 
% k = -N/2+1:N/2 for N even.
if mod(n,2) 
    even_odd_fix = (-1).^((n-1)/2:-1:-(n-1)/2);
else
    even_odd_fix = (-1).^((n/2-1):-1:(-n/2));
end
coeffs = bsxfun(@times,coeffs,even_odd_fix.');

end
