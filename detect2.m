function detect2(directory,filename, debug, logfh);
%
% detects pupil and iris boundaries from eye image
% produces normalised iris matrix
%
% Author 2013 Brenton O'Loughlin
%             RMIT University, 
%             Melbourne, Australia 
%
%             brenton.oloughlin@roughscale.com
%             s2102843@student.rmit.edu.au
%

% Not needed for MATLAB, only OCTAVE
%pkg load image;
more off;

% read image from file
f=imread(fullfile(directory,filename));

% name of output file
global outfile;
outfile = regexprep(([directory,filename]),'.jpg','');
output_base = 'results2014';
relative_path = regexprep(directory, 'casia_images/', '');
outfile = fullfile(output_base, relative_path, regexprep(filename, '.jpg', ''));
% Ensure directory exists
[outdir, ~, ~] = fileparts(outfile);
if ~exist(outdir, 'dir')
    mkdir(outdir);
end

% get size of image
[N,M] = size(f);

% determine radius parameters
% determine maximum radius
maxRad = min(M,N)/2;

% at the moment, start minRad at 20
% testing has indicated that setting a low minimum pupil
% radius can allow specular reflection in the pupil
% to mis-locate the pupil boundary
minRad = 35;

% perform partial intergro-differential calculation to
% obtain pupil (a,b,pR) parameters
[a,b,pR] = integrodiff(f,minRad:maxRad,debug,outfile,logfh);

% perform the same function within pupil iris as minRad
% to obtain the iris edge.
% NOTE: Having the pupil centre co-ords, do we need to
% iterate over whole image again to detect iris edge?
% or do we calculate partial derivative only for pupil co-ords?

%[ai, bi, iR] = integrodiff(f,pR+5:maxRad)

% this works for the moment
iR = irisedge(f,a,b,pR,debug,outfile, logfh);

%noisemask = detect_eyelids(image, ap, bp, pR, ap, bp, iR);
%save noise.mat noisemask

% save co-ordinates
coords = [a b pR iR];

if debug
    save ([outfile,'-debug'],'coords','-append');
end
% plot detected circles on image
% plotcircles(image, coords)

%savefile = regexprep(([directory,filename]),'.jpg','');
%save (savefile, 'coords','-mat')

% generate normalised iris image
%normiris = irisnorm(f,a,b,pR,iR, outfile, logfh);
normiris2 = irisnorm2(f,a,b,pR,iR, outfile, logfh);
if debug
    %save([outfile,'-debug'],'irisnorm','irisnorm2','-append');
    save([outfile,'-debug'],'irisnorm2','-append');
end
%figure, imshow(norm)
%save ([directory,filename,'-norm.mat'], 'normiris','-mat')

% extract feature vector by 2-D Gabor wavelet
%iriscode = gaborwavelet(normiris,debug,outfile, logfh);
iriscode2 = gaborwavelet2(normiris2,debug,outfile, logfh);

% show iris bitCode 
%figure, imshow(reshape(bitCode,16,128))
%save ([directory,filename,'-iriscode.mat'], 'bitCode','-mat')

% save matrices to disk
%save (outfile, 'coords','normiris','normiris2','iriscode','iriscode2');
save (outfile, 'coords','normiris2','iriscode2');
