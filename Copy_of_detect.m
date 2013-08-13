function detect(directory,filename);
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
([directory,filename])
f=imread([directory,filename]);

savedfile = [directory,filename,'.mat']

% get size of image
[N,M] = size(f);

% determine radius parameters
% determine maximum radius
maxRad = min(M,N)/2;

% at the moment, start minRad at 20
minRad = 20;

% perform partial intergro-differential calculation to
% obtain pupil (a,b,pR) parameters
%[a,b,pR] = integrodiff(f,minRad:maxRad);

% perform the same function within pupil iris as minRad
% to obtain the iris edge.
% NOTE: Having the pupil centre co-ords, do we need to
% iterate over whole image again to detect iris edge?
% or do we calculate partial derivative only for pupil co-ords?

%[ai, bi, iR] = integrodiff(f,pR+5:maxRad)

% this works for the moment
%iR = irisedge(f,a,b,pR);

%noisemask = detect_eyelids(image, ap, bp, pR, ap, bp, iR);
%save noise.mat noisemask

a = 337
b=243
pR=48
iR=95
% save co-ordinates
coords = [a b pR iR];

% plot detected circles on image
% plotcircles(image, coords)


save ([directory,filename,'-coords.mat'], 'coords')

% generate normalised iris image
normiris = irisnorm(f,a,b,pR,iR);
%figure, imshow(norm)
save ([directory, filename,'-norm.mat'],'normiris')
% extract feature vector by 2-D Gabor wavelet
bitCode = gaborwavelet(normiris);

% show iris bitCode 
figure, imshow(reshape(bitCode,16,128))
save ([directory, filename, '-iriscode.mat'],'bitCode')
