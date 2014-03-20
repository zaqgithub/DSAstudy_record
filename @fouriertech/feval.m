function y = feval(f, x)
%FEVAL   Evaluate a FOURIERTECH.
%   Y = FEVAL(F, X) Evaluation of the FOURIERTECH F at points X via
%   Horner's scheme.
%
%   If size(F, 2) > 1 then FEVAL returns values in the form [F_1(X), F_2(X),
%   ...], where size(F_k(X)) = size(X).
%
%   Example:
%     f = fouriertech(@(x) exp(cos(x)) );
%     x = linspace(-pi, pi, 1000);
%     fx = feval(f, x);
%     plot(x,fx,'r-')
%

% Copyright 2014 by The University of Oxford and The Chebfun Developers. 
% See http://www.chebfun.org/ for Chebfun information.

if ( isempty(f) )
    y = [];
    return 
end

% Reshape x to be a column vector for passing to polyval:
[~, m] = size(f);
fourierCoeff = f.coeffs;
N = size(fourierCoeff,1);
sizex = size(x);
ndimsx = ndims(x);
x = x(:);

if m > 1
    % If N is odd, no modification is needed.
    if ( mod(N,2) == 1 )
       % Compute using vectorized polyval (Horner's scheme)
       y = bsxfun(@times,exp(-1i*(N-1)/2*x),polyvalv(fourierCoeff,exp(1i*x)));
    else % The the degree (N/2 term) needs to be handled separately.   
       % Compute using vectorized polyval (Horner's scheme)
       y = cos(N/2*x)*fourierCoeff(N,:) + ...
           bsxfun(@times,exp(-1i*(N/2-1)*x),polyvalv(fourierCoeff(1:N-1,:),exp(1i*x)));
    end
else
    % If N is odd, no modification is needed.
    if ( mod(N,2) == 1 )
       % Compute using polyval (Horner's scheme)
       y = exp(-1i*(N-1)/2*x).*polyval(fourierCoeff,exp(1i*x));
    else % The the degree (N/2 term) needs to be handled separately.   
       % Compute using polyval (Horner's scheme)
       y = cos(N/2*x)*fourierCoeff(N) + ...
           exp(-1i*(N/2-1)*x).*polyval(fourierCoeff(1:N-1),exp(1i*x));
    end
end    

% Reshape the output if possible:
if ( (m == 1) && ( (ndimsx > 2) || (sizex(2) > 1) ) )
    y = reshape(y, sizex);
elseif ( (m > 1) && ( (ndimsx == 2) || (sizex(2) > 1) ) )
    y = reshape(y, sizex(1), m*numel(x)/sizex(1));
end

if f.isReal
    y = real(y);
end

    % Vectorized version of Horner's scheme for evaluating multiple
    % polynomilas of the same degree at the same locations.
    function q = polyvalv(c,x)
        nValsX = size(x,1);
        degreePoly = size(c,1);
        q = ones(nValsX,1)*c(1,:);
        for j = 2:degreePoly
            q = bsxfun(@minus,bsxfun(@times,x,q),-c(j,:));
        end
    end

end