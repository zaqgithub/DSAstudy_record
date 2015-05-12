classdef trigdouble < chebdouble
%FOURDOUBLE   Fourier double class. 
%
%   See the CHEBDOUBLE class for details.
%
%   This class in intended solely as a worker-class for PDE15s.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

    methods
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% CLASS CONSTRUCTOR:
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function obj = trigdouble(varargin)
            
            % Call the CHEBDOUBLE constructor:
            obj = obj@chebdouble(varargin{:});
            
        end
        
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% CLASS METHODS:
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        

        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  DIFF  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function u = diff(u, k)
            %DIFF   Compute the k-th derivative of u using Fourier
            % differentiation matrices defined by diffmat.
            
            % Store the diffmat D as a persistent variable to allow speeding up
            % if we work with the same discretization at multiple time steps.
            % Note that the matrix D is independent of the domain, since it is
            % scaled separately below.
            persistent D
            
            % Assume first-order derivative
            if ( nargin == 1 )
                k = 1;
            end
            
            N = length(u.values);
            
            % Construct D if we don't match a previous discretization.
            if ( isempty(D) || numel(D) < k || size(D{k}, 1) ~= N )
                D{k} = trigtech.diffmat(N, k); % Diffmat
            end
            
            % Interval scaling
            c = 2*pi/diff(u.domain);     
            
            % Muliplying by the kth-order differentiation matrix
            u.values = c^k*(D{k}*u.values);
            
            % Update the difforder:
            u.diffOrder = u.diffOrder + k;
            
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  SUM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The differential operators
        function I = sum(u, a, b)
            %SUM  Compute the integral of u.
            
            % TODO: Add support.
            error('CHEBFUN:FOURDOUBLE:sum:noImplemented', 'Not implemented yet.')
            
        end
        
        function I = integral(varargin)
            I = sum(varargin{:});
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CUMSUM  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The differential operators
        function u = cumsum(u)
            %CUMSUM   Compute the indefinite integral of the Chebyshev
            %         interpolant to u.
            
            % TODO: Add support.
            error('CHEBFUN:FOURDOUBLE:cumsum:noImplemented', 'Not implemented yet.')
            
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  FRED  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function u = fred(K, u)
            %FRED  Fredholm operator with kernel K.
            %   FRED(K, U) computes the action of the Fredholm operator with
            %   kernel K on the Chebyshev interpolant to the points in the
            %   vector U.
            
            % TODO: Add support.
            error('CHEBFUN:FOURDOUBLE:fred:noImplemented', 'Not implemented yet.')
            
        end
        
        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  VOLT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function u = volt(K, u)
            %VOLT  Volterra operator with kernel K.
            %   VOLT(K, U) computes the action of the Volterra operator with
            %   kernel K on the Chebyshev interpolant to the points in the
            %   vector U.
            
            % TODO: Add support.
            error('CHEBFUN:FOURDOUBLE:volt:noImplemented', 'Not implemented yet.')
            
        end

        %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  FEVAL  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        function out = feval(u, y)
            %FEVAL  Evaluate polynomial interpolant of data {X_four, U} at a
            % point y using barycentric interpolation.
            
            % TODO: Add support.
            error('CHEBFUN:FOURDOUBLE:feval:noImplemented', 'Not implemented yet.')

        end
                
    end
    
end


