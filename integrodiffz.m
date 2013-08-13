function [a, b, r]=integrodiff(image, R, debug, outfile, logfh);
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
buff = zeros(N+2*maxRad,M+2*maxRad);
buff(maxRad+1:maxRad+N, maxRad+1:maxRad+M)=g;

% find image pixels in buffer matrix
[B, A] = find(buff>0);
totpix=size(A,1);

delta=(2*pi)/128;
   
% determine line integral of circle at specific radius
% traverse all angles up to 2*pi/8 due to symmetry of circle
theta=delta:delta:(2*pi)/8 ;
% generate matrix of circle point (x,y) offsets for each radius
% for 1/8 circle
x = round(R'*cos(theta));
y = round(R'*sin(theta));

% generate total circle points due to 8-way symmetry
offsetX = [x y y -x -x -y -y x];
offsetY = [y x -x y -y -x x -y];

% calculate sum of pixel intensities of circle

% create 3-parameter space (a,b,r) accumulator matrix
Z = zeros(size(buff,1), size(buff,2), length(R));
% tic
for i=1:totpix

    % apply circle offset matrix to co-ordinates
    % to generate circle points matrix for each point (a,b)
    X = offsetX' + A(i);
    Y = offsetY' + B(i);
    
    % need to convert to linear indices to access scattered
    % pixel intensity elements within image buffer matrix
    idx = sub2ind(size(buff), Y(:), X(:));
    %size(X)
    %size(Y)
    %size(idx)

    % obtain pixel intensities of each circle point
    pixint = buff(idx);
    %size(pixint)
    %size(find(pixint>=0))
    % reshape pixel intensities vector back to offset matrix
    % to facilitate cumulative sum operation
    pixsum = cumsum(reshape(pixint, size(X)));

    % get final sum of all circle point intensities
    % normalise results
    I = pixsum(128,:);

    % add normalised line contour vector to accumulator
    Z(B(i),A(i),:) = I;
end
% display operation time for generating contour integral 
% disp(num2str(toc))
% excise points out of image 
Z = Z(maxRad+1:maxRad+N, maxRad+1:maxRad+M,:);
% save matrix to file
if debug
   save([outfile,'-debug'],'Z');
end
% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values
% calculate 1st order differential along radius dimension
dR = abs(diff(Z,1,3));
if debug
   save([outfile,'-debug'],'dR','-append');
end
% TODO 
% Gaussian filter convolution over differental matrix 
sigma = 0.5;
G = fspecial('gaussian',[1 5], sigma);

% convolution on differential matrix
smoothdR = convn(dR,G,'same');
if debug
    save([outfile,'-debug'],'smoothdR','-append');
end
% calculate maximum differential
% obtain radius dimension
maxVal = max(max(max(smoothdR)));
% need to taken into account double point imprecision
r = find(abs(max(max(smoothdR)) - maxVal) < 10^-4);
    
%%[maxdR, r] = max(max(max(dR)))

% locate pixel co-ordinates
% get column co-ordinate
%%[maxdR, a] = find (dR(:,:,r)))
% get row co-ordinate
%%[maxdR, b] = max(dR(:,a,r))
[b a] = find(abs(smoothdR(:,:,r) - maxVal) < 10^-6);

% determine correct radius
r = r + minRad - 1;

if debug
    % output co-ordinates to console
    fprintf(logfh, 'Pupil x co-ord: %d\n', a)
    fprintf(logfh, 'Pupil y co-ord: %d\n', b)
    fprintf(logfh, 'Pupil radius: %d\n', r)
end