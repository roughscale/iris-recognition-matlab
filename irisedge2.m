function iR=irisedge(image, a, b, R)

% NOTE: integrodiff function modified specific for iris detection
% 
% function to determine pupil and iris boundaries within an image
% according to Daugman's blurred partial integro-differential algorithm
% 
% input parameters:
% image matrix(image), pupil centre co-ordinates (a,b) and
% pupil radius (pR)
%
% output parameters:
% radius(iR) of detected iris boundary
%
%
% copyright 2013 Brenton O'Loughlin (brenton.oloughlin@roughscale.com)
%                RMIT University, Melbourne, Australia 
%

% Not needed for MATLAB, only octave
% pkg load image;

% test data
%a = 147;
%b = 146;
%pR = 43;
%image = imread('image1.bmp');

% get image size
[N M] = size(image);
% need to add a few pixels to avoid borderline pupil edges distorting
% calculations.  Should be resolved once Gaussian filtering is implemented.
minRad = R(1) + 10;
%maxRad = R(end)
maxRad = min([(N-b) (M-a) a b]) - 1;

R = minRad:maxRad;

% convert to double-type image for calculation optimisation
g = im2double(image);

% create buffer around image to deal with edge points
buff = zeros(N+2*maxRad,M+2*maxRad);
buff(maxRad+1:maxRad+N, maxRad+1:maxRad+M)=g;

% find image pixels in buffer matrix
% [B, A] = find(buff>0);
% totpix=size(A,1);

delta=(2*pi)/128;
   
% determine line integral of circle at specific radius
% traverse all angles up to 2*pi/8 due to symmetry of circle
theta=delta:delta:(2*pi)/8 ;
% generate matrix of circle point (x,y) offsets for each radius
% for 1/8 circle
x = round(R'*cos(theta));
y = round(R'*sin(theta));

% NOTE: generating total circle circumference for iris can cause 
% distortion in line contour integral calculation as it may include
% eyelashes and eyelids.
% previous work suggests to only include left and right 
% 90deg radial arcs instead of circle circumference
%
% generate total circle points due to 8-way symmetry
offsetX = [x x -x -x];
offsetY = [-y y y -y];

% calculate sum of pixel intensities of circle

% create 3-parameter space (a,b,r) accumulator matrix
%Z = zeros(size(buff,1), size(buff,2), length(R));
% tic
% not needed for one pixel
% for i=1:totpix

    % apply circle offset matrix to co-ordinates
    % to generate circle points matrix for each point (a,b)
    X = offsetX' + a + maxRad;
    Y = offsetY' + b + maxRad;

    % need to convert to linear indices to access scattered
    % pixel intensity elements within image buffer matrix
    idx = sub2ind(size(buff), Y(:), X(:));

    % obtain pixel intensities of each circle point
    pixint = buff(idx);

    % reshape pixel intensities vector back to offset matrix
    % to facilitate cumulative sum operation
    pixsum = cumsum(reshape(pixint,size(X)));

    % get final sum of all circle point intensities
    % normalise results
    I = pixsum(128,:)/128;

    % add normalised line contour vector to accumulator
    Z = I;
%end
% disp(num2str(toc))
% excise points out of image 
%Z = Z(maxRad+1:maxRad+N, maxRad+1:maxRad+M,:);
% save matrix to file
% save Z.mat Z

% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values
% calculate 1st order differential along radius dimension
%dR = abs(diff(Z,1,3))
dR = abs(diff(Z));
% TODO 
% Gaussian filter convolution over differental matrix 



% calculate maximum differential
% obtain radius dimension
[maxdR, iR] = max(dR);

% locate pixel co-ordinates
%[maxdR, b] = max(max(dR(:,:,r)));
%[maxdR, a] = max(dR(:,b,r));

% determine correct radius
iR = iR + minRad - 1;

% output co-ordinates to console
%[a b iR]
