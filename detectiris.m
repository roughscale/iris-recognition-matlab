function detectiris(filename);
%
% detects pupil and iris boundaries from eye image
% and produces normalised iris matrix
%
% copyright 2013 Brenton O'Loughlin (brenton.oloughlin@roughscale.com)
%                RMIT University, Melbourne, Australia 
%

% Not needed for MATLAB, only OCTAVE
%pkg load image;
more off;

% read image from file
f=imread(filename);

% get size of image
[N,M] = size(f)

% determine radius parameters
% determine maximum radius
maxRad = min(M,N)/2

% at the moment, start minRad at 20
minRad = 20

theta1 = 2*pi/128:(2*pi)/128:(2*pi)/8;

% perform partial intergro-differential calculation to
% obtain pupil (a,b,pR) parameters
[ap,bp,pR] = integrodiff(f,minRad:maxRad)

% perform the same function within pupil iris as minRad
% to obtain the iris edge.
% NOTE: Having the pupil centre co-ords, do we need to
% iterate over whole image again to detect iris edge?
% or do we calculate partial derivative only for pupil co-ords?


% plot pupil edge on image
% show image with detected dimensions
% create detected circle edge
% determine circle points
x1 = round(pR * cos(theta1));
y1 = round(pR * sin(theta1));
% 

X1 = [x1 y1 y1 -x1 -x1 -y1 -y1 x1];
Y1 = [y1 x1 -x1 y1 -y1 -x1 x1 -y1];
pA = ap + X1;
pB = bp + Y1;

% calculate iris-boundary centre-co-ordinate limits
%iris_x = [ap - pR : ap + pR]
%iris_y = [bp - pR : bp + pR]
iR = integrodiff(f,ap,bp,pR+10)

% again for iris
x2 = round(iR * cos(theta1));
y2 = round(iR * sin(theta1));

X2 = [x2 y2 y2 -x2 -x2 -y2 -y2 x2];
Y2 = [y2 x2 -x2 y2 -y2 -x2 x2 -y2];
iA = ai + X2;
iB = bi + Y2;

% calculate eyelids line points
% [ux, uy] integrodiff4(f,iR,ai,bi)
%uind = sub2ind(size(f),ux,uy)
%imagewithnoise = detect_eyelids(image(bi-iR:bi+iR,ai-iR,ai+ir),bp,ap);
%save noise.mat imagewithnoise

% display image with edge features
imshow(f);
hold on;
plot(ap,bp,'wx')
plot(ai,bi,'w.')
plot(pA, pB, 'r:')
plot(iA, iB, 'r:')
%plot(ux, uy)
% generate normalised iris image
norm = irisnorm(f, a,b,pR,iR);
%figure, imshow(norm)
