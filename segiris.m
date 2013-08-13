function [Im] = irisnorm(image, x0, y0, pR, iR, outfile, logfh)
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
n = 360;

% set angle range
angle = 2*pi/n:2*pi/n:2*pi;

% set radial range
radialr = [0:pR iR:iR+10]

% get pixel co-ordinates by traversing angles
% within radial range
x = x0 + round(radialr' * cos(angle))
y = y0 + round(radialr' * sin(angle))

% get pixel data from co-ordinates
idx = sub2ind(size(image), y(:), x(:));
I = image;
I(idx) = 255
%I(idx) = image(idx)
size(image)
% reshape into 2D image matrix
imshow(I)