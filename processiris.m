% processes iris images on disk and writes iris code to disk

% directory where images are
basedir = 'h:\research\casia_images\';

categorydir = ls (basedir)

for category = 1:size(categorydir,1)
    subjectdir = ls ([basedir,categorydir(category,:)])
    for subject = 1:size(subjectdir,1)
        eyes = {'L','R'};
        for eye = 1:size(eyes,2)
            subjecteye = eyes(eye);
            directory = strcat(basedir,'\',subjectdir(subject,:),'\',eyes(eye),'\')
            files = ls (strcat(directory{:},'*.jpg'))
            if ((size(files,1) > 0)) 
                for f = 1:size(files,1)
                   filename = files(f,:);
                   strtregexp([direction{:},filename],'.jpg','.mat')
                   if not (strregexp([directory{:},filename],'.jpg','.mat'),'file') 
                      try
                         %detect(directory{:},filename);
                         disp([directory{:},filename])
                      catch exception
                         disp(getReport(exception));
                      end    
                   end
                end
                  
            end
            
        end
    
    end

end
