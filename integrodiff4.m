function [x2 y2] = integrodiff4(image, r, y0,x0);
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
%[N, M] = size(image);
%r = R(1);
%maxRad = R(end);

% convert to double-type image for calculation optimisation
g = im2double(image);
count = 0;
% create buffer around image to deal with edge points
%buff = zeros(N+2*maxRad,M+2*maxRad);
%buff(maxRad+1:maxRad+N, maxRad+1:maxRad+M)=g;

% find image pixels in buffer matrix
%[B, A] = find(buff>0);
%totpix=size(A,1);

%delta=(2*pi)/128;
   
% determine line integral of circle at specific radius
% traverse all angles up to 2*pi/8 due to symmetry of circle
%theta=delta:delta:(2*pi)/8 ;

% find three points upper eyelid region
[x0 y0 r]
min_x = x0 - round(r*cos(2*pi/8))
max_x = x0 + round(r*cos(2*pi/8))
max_y = y0 - round(r*sin(2*pi/8)) + 1
min_y = y0 - r
delta_x = (max_x - min_x) / 32

%calculate points on arc
x2 = round([min_x:delta_x:max_x])

Z = [];
for i = min_y:max_y
    
    for j = 0:max_y-min_y+1
        
        x1 = [min_x x0 max_x];
        y1 = [min_y+j i min_y+j];

        % solve parabolic quadratic equation
        p = polyfit(x1,y1,2);

        % calculate points on the arc
        y2 = round(polyval(p,x2));

        % cumsum pixel intensities on the arc
        idx = sub2ind(size(g), y2(:), x2(:));
        %I = cumsum(g(x2(:),y2(:))
        
        pixint = g(idx);

        % reshape pixel intensities vector back to offset matrix
        % to facilitate cumulative sum operation
        pixsum = cumsum(pixint);

        % get final sum of all circle point intensities
        % normalise results
        % should reduce this to 64 as we are only analysing half the circle
        I = pixsum(33,:)/33;

        % add normalised line contour vector to accumulator
        Z = [ Z ; I i p];
    end
end

% save matrix to file
save Z.mat Z;

% calculate line contour differential with respect 
% respect to increasing radius
% calculate absolute differential values
% calculate 1st order differential along radius dimension
size(Z)
dR = diff(Z(:,1));
% TODO 
% Gaussian filter convolution over differental matrix 



% calculate maximum differential
% obtain radius dimension
maxVal = max(dR)
% need to taken into account double point imprecision
%r = find(abs(max(max(dR)) - maxVal) < 10^-4);
row = find(abs((dR) - maxVal) < 10^-4)
Z(row,:)

%return vector of arc co-ordinates
Z(row,3:5)
y2=round(polyval(Z(row,3:5),x2))


uind = sub2ind(size(image),x2,y2)

% display image with edge features
imshow(image);
hold on;
%plot(ap,bp,'wx')
%plot(ai,bi,'w.')
%plot(pA, pB, 'r:')
%plot(iA, iB, 'r:')
plot(x2, y2)
