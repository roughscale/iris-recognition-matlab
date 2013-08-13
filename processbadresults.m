function list=processbadresults

basedir = 'h:\research\casia_images';

global logfh;

logfh = 1;

list = []
categorydir = { 'CASIA-Iris-Syn' };
for category = categorydir(1)
    catname = category{:};
    if ~( strcmp(catname,'.') || strcmp(catname,'..'))

        subjectdir = dir (fullfile(basedir,catname));
        for subject = 1:size(subjectdir,1);
            if ~( strcmp(subjectdir(subject).name,'.') || strcmp(subjectdir(subject).name,'..'))                
                directory = fullfile(basedir,catname,subjectdir(subject).name,'\');
                files = ls ([directory,'\*.jpg']);
                size(files);
                if ((size(files,1) > 0)) 
                    for f = 1:size(files,1)
                        filename = files(f,:);
                        if ~( strcmp(filename,'.') || strcmp(filename,'..'))
                            % check image has not been processed
                            matfile = regexprep([directory,filename],'.jpg','.mat');
                            if exist(matfile,'file')
                            load(matfile,'coords');
                                if (coords(3) < 35)
                                    fprintf('%s\n',[directory,filename])
                                    %list = [list ; ([directory,filename]) ]
                                    processfile(directory,filename,false,false);
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end






