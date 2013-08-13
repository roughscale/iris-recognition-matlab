%function [a, b, r]=function integrodiff(image, R)
% 
% function to determine pupil and iris boundaries within an image
% according to Daugman's partial integro-differential algorithm
% 
% input parameters:
% image matrix(image) and radius range vector (R)
%
% output parameters:
% centre co-ordinates(a,b) and radius(r) of detected circle boundary
%
%
% copyright 2013 Brenton O'Loughlin (brenton.oloughlin@roughscale.com)
%                RMIT University, Melbourne, Australia 
%

% turn off for MATLAB. only required for octave
% pkg load image;
more off;

% read image from file
f=imread('image1.bmp');

% get size of image
[N,M] = size(f);

% convert to double-type image for calculation optimisation
g = im2double(f);

% determine radius parameters
% determine maximum radius
maxRad = min(N,M)/2;
%maxRad = l/2;
% at the moment, start minRad at 20
minRad = 20;

% create buffer around image to deal with edge points
buff = zeros(N+2*maxRad,M+2*maxRad);
buff(maxRad+1:maxRad+N, maxRad+1:maxRad+M)=g;

% find image pixels in buffer matrix
[B, A] = find(buff>0);
totpix=size(A,1);

delta=(2*pi)/128;
   
R=minRad:maxRad;
% determine line integral of circle at specific radius
% traverse all angles up to 2*pi/8 due to symmetry of circle
theta=delta:delta:(2*pi)/8 ;
% generate matrix of circle point (x,y) offsets for each radius
% for 1/8 circle
x = round(R'*sin(theta));
y = round(R'*cos(theta));

% generate total circle points due to 8-way symmetry
offsetX = [x y y -x -x -y -y x];
offsetY = [y x -x y -y -x x -y];

% calculate sum of pixel intensities of circle

% create 3-parameter space (a,b,r) accumulator matrix
Z = zeros(size(buff,1), size(buff,2), length(R));
tic
for i=1:totpix

    % apply circle offset matrix to co-ordinates
    % to generate circle points matrix for each point (a,b)
    X = offsetX' + A(i);
    Y = offsetY' + B(i);

    % need to convert to linear indices to access scattered
    % pixel intensity elements within image buffer matrix
    idx = sub2ind(size(buff), Y(:), X(:));

    % obtain pixel intensities of each circle point
    pixint = buff(idx);

    % reshape pixel intensities vector back to offset matrix
    % to facilitate cumulative sum operation
    pixsum = cumsum(reshape(pixint, size(X)));

    % get final sum of all circle point intensities
    % normalise results
    I = pixsum(128,:)/128;

    % add normalised line contour vector to accumulator
    Z(B(i),A(i),:) = I;
end
% output time taken to iterate over image
disp(num2str(toc))
% excise points out of image 
Z = Z(maxRad+1:maxRad+N, maxRad+1:maxRad+M,:);
% save matrix to file
% save Z.mat Z

% calculate line contour differential with respect 
% to increasing radius

% calculate 1st order differential along radius dimension
dR = abs(diff(Z,1,3));
% TODO 
% Gaussian spatial filter convolution over differental matrix 



% calculate maximum differential
% obtain radius dimension
[maxdR, r] = max(max(max(dR)))

% locate pixel co-ordinates
[maxdR, a] = max(max(dR(:,:,r)))
[maxdR, b] = max(dR(:,a,r))


% determine correct radius
r = r - 1 + minRad;

% output co-ordinates to console
[b, a, r]

% show image with detected dimensions
% create detected circle edge
% determine circle points
theta1 = 0:(2*pi)/128:(2*pi)/8;
x1 = round(r * sin(theta1));
y1 = round(r * cos(theta1));
% 
X1 = [x1 y1 y1 -x1 -x1 -y1 -y1 x1];
Y1 = [y1 x1 -x1 y1 -y1 -x1 x1 -y1];

A1 = a + X1;
B1 = b + Y1;

% display image with edge features
imshow(f);
hold on;
plot(a,b,'wx')
plot(A1, B1, 'r:')

