function listfiles=filelist2
%
% gets a list of all saved matlab files
% and feeds them into vector for use as scripting args
%
basedir = 'results2014';

categorydir = { 'CASIA-Iris-Interval' };

listfiles = [];

for category = categorydir(1)
   catname = category{:};
 
    
    if ~( strcmp(catname,'.') || strcmp(catname,'..'))
        subjectdir = dir (fullfile(basedir,catname));

        for s = 1:size(subjectdir,1);

            if ~( strcmp(subjectdir(s).name,'.') || strcmp(subjectdir(s).name,'..'))                
                directory = fullfile(basedir,catname);
                subject = subjectdir(s).name;
                subdir = strcat(directory,'/',subject);
                eyes = {'L','R'};
                for eye = 1:size(eyes,2)   
                    subjecteye = eyes(eye);               
                    tmpdir = fullfile(subdir,subjecteye);
                    directory = tmpdir{:};
                    files = dir(fullfile(directory,'*.mat'));
                    if ((size(files,1) > 0)) 
                        for f = 1:size(files,1)
                            filename = files(f).name;
                            if ~( strcmp(filename,'.') || strcmp(filename,'..') || ...
                                  ~isempty(strfind(filename, '-masek.mat')) || ...
                                  ~isempty(strfind(filename, '-houghpara.mat')) || ...
                                  ~isempty(strfind(filename, '-debug.mat')) )

                                % add files to list matrix
                                listfiles = [listfiles ; { directory, subject, filename } ];                               
                            end                                   
                        end
                    end
                end
                
            end
        end
    end
end

end
