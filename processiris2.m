% processes iris images on disk and writes iris code to disk

% directory where images are
basedir = 'h:\research\casia_images';

categorydir = 'CASIA-Iris-Lamp';

for category = 1:size(categorydir,1)
    subjectdir = '003';
    for subject = 1:size(subjectdir,1);
        eyes = {'L','R'};
        for eye = 1:size(eyes,2)
            subjecteye = eyes(eye);
            tmpdir = strcat(basedir,'\',categorydir(category,:),'\',subjectdir(subject,:),'\',eyes(eye),'\');
            directory = tmpdir{:};
            files = ls ([directory,'*.jpg']);
            if ((size(files,1) > 0)) 
                for f = 1:size(files,1)
                   filename = files(f,:);
                   % check image has not been processed
                   if ~exist(regexprep([directory,filename],'.jpg','.mat'),'file')
                      try
                         fprintf('Processing %s\n', [directory,filename])
                         detect2(directory,filename,false);
                      catch exception
                         disp(getReport(exception));
                         % retry with debugging
                         try
                             fprintf('Re-processing %s with debugging\n', [directory,filename])
                             detect2(directory,filename,true);
                         catch exception2
                             % we already have exception report
                         end
                      end    
                   end
                end
                  
            end
            
        end
    
    end

end
