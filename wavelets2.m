function [GB] = wavelets(dimension)
% returns complex 2-D Gabor wavelet matrix for specified wavelet dimension
%

% wavelength of complex carrier wave
w = double(pi/floor(dimension/2));
%w = double(floor(2 * pi /dimension));

% generate complex carrier wave
limit = (dimension-1)/2;
X = meshgrid(-limit:1:limit);
CW = exp (- ( i * (w * X) )  );

% adjust for row vector sum/dimension
% as provided in projectiris algorithm
%
%for j=1:size(CW,1)
%    CW(j,:) = CW(j,:) - sum(CW(j,:))/dimension;
%end

% generate Gaussian matrix
% peak and alpha/beta values are provided by ProjectIris
alpha = 0.47703322291 * (dimension -1);
%alpha = 1
beta = alpha;
%K = 15;
%alpha = 1 / dimension;
%beta = alpha;
K = 15

for r=-limit:1:limit
    for a = -limit:1:limit
        G(r+(limit+1),a+(limit+1)) = K .* exp ( - ( (r^2) / (alpha^2) ) ) .* exp ( - ( (a.^2) / (beta^2) ) );
    end
end

% generate convolved gabor complex wavelet
GB = G .* CW
GB2 = conv2(G,CW)
