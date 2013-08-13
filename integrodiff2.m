% 
% script to determine pupil and iris boundaries within an image
% according to Daugman's partial integro-differential algorithm
%
% copyright 2013 Brenton O'Loughlin (brenton.oloughlin@roughscale.com)
% 
% not needed for MATLAB.
% pkg load image;
%load matrix from file
load Z.mat;

% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values 
% calculate 1st order differential along radius dimension
dR = abs(diff(Z,1,3));

% TODO 
% Gaussian filter convolution over differental matrix 
% in spatial domain
% query whether we should do it in the frequency domain?

% calculate maximum differential
[maxdR, r] = max(max(max(dR)));

% locate co-ordinates for max value
%[a,b,r] = find(dR==maxdR)
[maxdR, b]  = max(max(dR(:,:,r)));
[maxdR, a] = max(dR(:,b,r));
