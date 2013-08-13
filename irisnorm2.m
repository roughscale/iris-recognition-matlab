function [Im] = irisnorm2(image, x0, y0, pR, iR, debug, outfile, logfh)
%
% extracts a normalised (rubber-sheet model) iris matrix
% from image file
%
% input variables: 
% centre co-ordinates (x0,y0) 
% radius of pupil edge (pR) and iris edge( iR)
%
% output variable:
% normalised iris matrix (Im)
%
% test variables
%x0 = 147;
%y0 = 146;
%pR = 44;
%iR = 84;
%image = imread('image1.bmp');

% n is the size of the angle dimension
% need to double this as we are only analysing
% half of the iris
n = 256;
delta = 2*pi/n;
% set angle range
% for 90degree cones
quad1 = delta:delta:2*pi/8;
quad23 = 6*pi/8+delta:delta:10*pi/8;
quad4 = 14*pi/8+delta:delta:16*pi/8;

angle = [ quad4 quad1 quad23] ;
% set radial range
radialr = pR:iR;

% get pixel co-ordinates by traversing angles
% within radial range
x = x0 + round(radialr' * cos(angle));
y = y0 + round(radialr' * sin(angle));

% get pixel data from co-ordinates
idx = sub2ind(size(image), y(:), x(:));
I = image(idx);

% reshape into 2D image matrix
Im = reshape(I, size(x));
