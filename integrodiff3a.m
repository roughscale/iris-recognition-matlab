function [a, b, r]=integrodiff3a(image, rangeR, x0, y0)
% 
% function to determine iris boundaries within an image
% according to Daugman's blurred partial integro-differential algorithm
% 
% input parameters:
% image matrix(image),radius range vector (R)
% cartesian co-ordinate ranges for centre co-ordinates (x,y)
% these will be within the pupil.
%
% output parameters:
% centre co-ordinates(a,b) and radius(r) of detected circle boundary
%
%
% copyright 2013 Brenton O'Loughlin (brenton.oloughlin@roughscale.com)
%                RMIT University, Melbourne, Australia 
%

% Not needed for MATLAB, only octave
% pkg load image;
more on;

% get image size
[N, M] = size(image)
minRad = rangeR(1);
maxRad = rangeR(end)

% convert to double-type image for calculation optimisation
g = im2double(image);

% create buffer around image to deal with edge points
% do we need this for iris?
%buff = zeros(N+2*maxRad,M+2*maxRad);
%buff(maxRad+1:maxRad+N, maxRad+1:maxRad+M)=g;

% create window matrix for range of centre co-ordinates
% find image pixels in buffer matrix
buff = g(x0(:),y0(:)); 

[B, A] = find(buff>=0);
totpix=size(A,1)

delta=(2*pi)/128;
   
% determine line integral of circle at specific radius
% traverse all angles up to 2*pi/8 due to symmetry of circle
theta=delta:delta:(2*pi)/8 ;

% generate matrix of circle point (x,y) offsets for each radius
% for 1/8 circle
x = round(rangeR'*cos(theta));
y = round(rangeR'*sin(theta));

% generate total circle points due to 8-way symmetry
% limit this to (7pi/8:2pi/8),(5*pi/8:7pi/8),
% for the two 90degree opposable cones
offsetX = [x x -x -x];
offsetY = [-y y y -y];

% calculate sum of pixel intensities of circle

% create 3-parameter space (a,b,r) accumulator matrix
Z = zeros(size(x0,2), size(y0,2), length(rangeR));
% tic
for i=1:totpix

    [y0(B(i)) x0(A(i))];  
    %determine maximum radius within image
    if (x0(A(i)) > M/2)
        rx = M - x0(A(i));
    else
        rx = x0(A(i));
    end
    if (y0(B(i)) > N/2)
        ry = N - y0(B(i));
    else
        ry = y0(B(i));
    end
    Rmax = min([rx ry maxRad]) - 1;
    % apply circle offset matrix to co-ordinates
    % to generate circle points matrix for each point (a,b)
    X = offsetX(1:Rmax)' + A(i) + x0(1);
    Y = offsetY(1:Rmax)' + B(i) + y0(1);

    % need to convert to linear indices to access scattered
    % pixel intensity elements within image buffer matrix
    idx = sub2ind(size(g), Y(:), X(:));

    % obtain pixel intensities of each circle point
    pixint = g(idx);

    % reshape pixel intensities vector back to offset matrix
    % to facilitate cumulative sum operation
    pixsum = cumsum(reshape(pixint, size(X)));

    % get final sum of all circle point intensities
    % normalise results
    % should reduce this to 64 as we are only analysing half the circle
    I = pixsum(64,:)/64;
    
    %i
   % A(i)
   % B(i)
    % add normalised line contour vector to accumulator
    Z(B(i),A(i),:) = I;
end
% display operation time for generating contour integral 
% disp(num2str(toc))
% excise points out of image 
%Z = Z(y0,x0,:)
% save matrix to file
save Z2.mat Z;

% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values
% calculate 1st order differential along radius dimension
dR = diff(Z,1,3)
%dR = Z;
% TODO 
% Gaussian filter convolution over differental matrix 



% calculate maximum differential
% obtain radius dimension
maxVal = max(max(max(dR)))
% need to taken into account double point imprecision
r = find(abs(max(max(dR)) - maxVal) < 10^-4)
%%[maxdR, r] = max(max(max(dR)))

% locate pixel co-ordinates
% get column co-ordinate
%%[maxdR, a] = find (dR(:,:,r)))
% get row co-ordinate
%%[maxdR, b] = max(dR(:,a,r))
[b a] = find(abs(dR(:,:,r) - maxVal) < 10^-4)

% determine correct radius
r = r + minRad;

% output co-ordinates to console
% [a, b, r]
