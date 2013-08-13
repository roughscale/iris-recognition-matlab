% processes iris images on disk and writes iris code to disk

% directory where images are
basedir = 'h:\research\casia_images';

global logfh;

logfh = 1;


categorydir = { 'CASIA-Iris-Syn' };
for category = categorydir(1)
    catname = category{:};
    if ~( strcmp(catname,'.') || strcmp(catname,'..') )

        subjectdir = dir (fullfile(basedir,catname));
        for subject = 1:size(subjectdir,1);
            if ~( strcmp(subjectdir(subject).name,'.') || strcmp(subjectdir(subject).name,'..'))                
                directory = fullfile(basedir,catname,subjectdir(subject).name,'\');
                files = ls ([directory,'\*.jpg']);
                if ((size(files,1) > 0)) 
                    for f = 1:size(files,1)
                        filename = files(f,:);
                        if ~( strcmp(filename,'.') || strcmp(filename,'..'))
                            % check image has not been processed
                            if ~exist(regexprep([directory,filename],'.jpg','.mat'),'file')
                                try
                                    %if exist(fullfile(directory,filename), 'file')
                                    %    disp(fullfile(directory,filename))
                                    %end
                                    fprintf(logfh,'Processing %s\n', [directory,filename])
                                    detect2(directory,filename,false,logfh);
                                catch exception
                                    fprintf(logfh,'%s\n',getReport(exception));
                                    % retry with debugging
                                    try
                                        fprintf(logfh,'Reprocessing %s with debugging\n', [directory,filename])
                                        detect2(directory,filename,true,logfh);
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
    
    end

end
