function processresults_masek

fid = fopen('results_masek.txt','a');

list = filelist_masek;

for n = 1:size(list,1)
    
    tmp = fullfile(list(n,1),list(n,3));
    filename1 = tmp{:};

    if exist(filename1,'file');

        ref = load(filename1);
        subject = list(n,2);
        
        for m = 1:size(list,1)

            tmp = fullfile(list(m,1),list(m,3));
            filename2 = tmp{:};
            object = list(m,2);
        
            if ~strcmp(filename1,filename2)

                if exist(filename2,'file')
                    query = load(filename2);
            
                    HD = gethammingdistance(ref.template,ref.mask,query.template,query.mask,1);
                    if strcmp(subject,object)
                        imposter = 'false';
                    else
                        imposter = 'true';
                    end
  
                fprintf(fid,'%s,%s,%d\n',subject{:},imposter,HD);
            
                end
            end
        end

    end
  
end
fclose(fid)
