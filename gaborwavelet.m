function [bitCode] = gaborwavelet(normiris, debug, outfile, logfh)
% function [bitCode] = gabor2D(image)
%
% MATLAB port of the 2-D gabor wavelet function
% from the Project Iris C++ implementation
% 
more off;

[R,C] = size(normiris);
% generate null bitCode array
bitCode = zeros(1,2048);

angularSlices = 128;
radialSlices = 1024/angularSlices;

bitCodePos = 1;

dimensions = [ 3 6 9 12 15 18 21 24];

for aslice = 0:1:angularSlices - 1;
    
    theta = aslice;
    
    for rslice = 0:1:size(dimensions,2)-1

        filterHeight = dimensions(rslice + 1);
    
    
        GB = wavelets(filterHeight);

        % don't analyse 3 pixels 
        radius = ceil((filterHeight + 1)/2);
        
        %range = -(floor(filterHeight/2)):floor(filterHeight/2))
 
        radialLow = radius - floor(filterHeight/2);
        
        radiusr = radialLow:(radialLow+filterHeight)-1;

        thetaLow = theta - floor(filterHeight/2);
        
        
        thetar = thetaLow:(thetaLow + filterHeight)-1 ;

        % allow for theta to wrap around image
        if (find(thetar < 1))
            t = find(thetar < 1);
            thetar(t) = thetar(t) + C;
        end
  
        if (find(thetar > angularSlices))
            t = find(thetar > C);
            thetar(t) = thetar(t) - C;
        end

        % take local region of iris for integral calculation
        try
            im = normiris(radiusr,thetar);
        catch exception
            fprintf(logfh,'%s\n',getReport(exception));
            fprintf(logfh,'Radius range:\n');
            fprintf(logfh,'%s\n',radiusr);
            fprintf(logfh,'Theta range:\n');
            fprintf(logfh,'%s\n',thetar);
            rethrow(exception)
        end
        % convole localised iris region with 2-D Gabor filter
        if debug
            if exist([outfile,'-debug.mat'],'file')
                save([outfile,'-debug'],'GB','im','-append')
            else
                save([outfile,'-debug'],'GB','im')   
            end
        end

        %filteredImage = convn(GB,double(im));
        filteredImage = double(im) * GB;
        
        % calculate integral of both real and imaginary components
        % of filtered image
        h_real = sum(real(filteredImage(:)));
        h_imag = sum(imag(filteredImage(:)));
 
        % quantise integral based on sign
        if (h_real > 0)
            bitCode(bitCodePos) = 1;
        end
        if (h_imag > 0)
            bitCode(bitCodePos + 1) = 1; 
        end
            
        bitCodePos = bitCodePos + 2;
    end

end

