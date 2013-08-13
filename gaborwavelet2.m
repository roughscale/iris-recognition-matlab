function [bitCode] = gaborwavelet2(normiris, debug, outfile, logfh)
% function [bitCode] = gabor2D(image)
%
% MATLAB port of the 2-D gabor wavelet function
% from the Project Iris C++ implementation
% 
more off;

[R,C] = size(normiris)
% generate null bitCode array
bitCode = zeros(1,2048);

angularSlices = 128;
radialSlices = 1024/angularSlices;

bitCodePos = 1;

maxFilter = R / 3

for aSlice=0:1:angularSlices-1
    
    theta = aSlice;

    for rSlice=0:1:radialSlices-1
  
        radius = floor(rSlice * (R - 6) / (2*radialSlices)) + 3;

        if (radius < (R - radius))
            filterHeight = 2 * radius - 1;
        else
            filterHeight = 2 * (radius - R) - 1;
        end

        if (filterHeight > C - 1)
            filterHeight = C - 1;
        end

        if (filterHeight > maxFilter)
            filterHeight = maxFilter;
        end

       

        range = -(floor(filterHeight/2)):(floor(filterHeight/2));
 
        size(range)
        % obtain complex 2-D Gabor wavelet matrix
        GB = wavelets(size(range,2));
        radiusr = radius+range;

        % allow for theta to wrap around image
        thetar = theta + range;

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
        size(double(im))
        size(GB)
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

