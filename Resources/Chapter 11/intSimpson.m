function FSmp = intSimpson(f,xLow,xHigh,Npoint);

% intSimpson implements Simpson's rule of numerical integration
% INPUT  f ..... function handle
%        xLow .. lower integration boundary
%        xHigh . upper integration boundary
%        Npoint. Number of integration steps
%
% OUTPUT FSmp .. Approximation of the integral
%
% HSG MATLAB course 2012
% peter.gruber@usi.ch, 2012-12-10

if mod(Npoint,2)
    error('Simpsons rule works only for even N')
end

dx   = (xHigh-xLow) / Npoint;	        % x-increment (="width of strips")
xSmp = xLow : dx : xHigh;	            % x values
ySmp = f(xSmp);							% Function values 
weights=repmat([2 4], 1, Npoint/2);     % Weights vector
weights(1)=1;                           % First and ... 
weights=[weights 1];                    % ... last weights are 1
FSmp = dx* 1/3 * sum(ySmp .* weights);	% Simpson's rule integral

end

