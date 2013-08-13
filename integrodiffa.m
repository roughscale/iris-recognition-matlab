function [a, b, r]=integrodiffa(image, R);
% 
% function to determine pupil and iris boundaries within an image
% according to Daugman's blurred partial integro-differential algorithm
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

% Not needed for MATLAB, only octave
% pkg load image;

% get image size
[N, M] = size(image);
minRad = R(1);
maxRad = R(end);

% convert to double-type image for calculation optimisation
g = im2double(image);

% create buffer around image to deal with edge points

% find image pixels in buffer matrix
[B, A] = find(g>=0);
totpix=size(A,1);

delta=(2*pi)/128;
   
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
Z = zeros(size(g,1), size(g,2), length(R));
% tic
for i=1:totpix

    if (A(i) > M/2)
        rx = M - A(i)
    else
        rx = A(i)
    end
    if (B(i) > N/2)
        ry = N - B(i)
    else
        ry = B(i)
    end
    min([rx ry maxRad])
    R = 1:min([rx ry maxRad])
    % apply circle offset matrix to co-ordinates
    % to generate circle points matrix for each point (a,b)
    X = offsetX' + A(i);
    Y = offsetY' + B(i);

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
    I = pixsum(128,:)/128;

    % add normalised line contour vector to accumulator
    Z(B(i),A(i),:) = I;
end
% display operation time for generating contour integral 
% disp(num2str(toc))
% excise points out of image 
%Z = Z(maxRad+1:maxRad+N, maxRad+1:maxRad+M,:);
% save matrix to file
% save Z.mat Z;

% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values
% calculate 1st order differential along radius dimension
dR = diff(Z,1,3);
% TODO 
% Gaussian filter convolution over differental matrix 



% calculate maximum differential
% obtain radius dimension
maxVal = max(max(max(dR)));
% need to taken into account double point imprecision
r = find(abs(max(max(dR)) - maxVal) < 10^-4);
%%[maxdR, r] = max(max(max(dR)))

% locate pixel co-ordinates
% get column co-ordinate
%%[maxdR, a] = find (dR(:,:,r)))
% get row co-ordinate
%%[maxdR, b] = max(dR(:,a,r))
[b a] = find(abs(dR(:,:,r) - maxVal) < 10^-4);

% determine correct radius
r = r + minRad;

% output co-ordinates to console
% [a, b, r]
