% processes iris images on disk and writes iris code to disk

% base directory where CASIA images are
basedir = '..\casia_images';

global logfh
logfh = fopen('process-masek.log','a');

% CASIA categories
%categorydir = dir (basedir);
categorydir = { 'CASIA-Iris-Thousand'};
for category = 1:size(categorydir,2)
    catname = categorydir(category);
    if ~( strcmp(catname,'.') || strcmp(catname,'..') )
        subjectdir = dir (fullfile(basedir,catname{:}));
        for subject = 1:size(subjectdir,1);
            if ~( strcmp(subjectdir(subject).name,'.') || strcmp(subjectdir(subject).name,'..'))
                eyes = {'L','R'};
                for eye = 1:size(eyes,2)   
                    subjecteye = eyes(eye);               
                    tmpdir = fullfile(basedir,catname{:},subjectdir(subject).name,subjecteye,'/');
                    directory = tmpdir{:};
                    files = ls ([directory,'/*.jpg']);
                    if ((size(files,1) > 0)) 
                        for f = 1:size(files,1)
                            filename = files(f,:)
                            if ~( strcmp(filename,'.') || strcmp(filename,'..'))
                                % check image has not been processed
                                %if exist(regexprep([directory,filename],'.jpg','.mat'),'file')
                                    try
                                        % for testing
                                        %if exist(fullfile(directory,filename), 'file')
                                        %    disp(fullfile(directory,filename))
                                        %end
                                        fprintf(logfh,'Processing %s\n', [directory,filename])
                                        detect3(directory,filename);
                                    catch exception
                                        fprintf(logfh,'%s\n',getReport(exception));
                                        % retry with debugging
                                        try
                                            fprintf(logfh, 'Reprocessing %s with debugging\n', [directory,filename])
                                            detect3(directory,filename);
                                        catch exception2
                                            % we already have exception report
                                        end
                                    end    
                                %end
                            end                        
                        end
                    end  
                end
            end        
        end
    
    end

end
