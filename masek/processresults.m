

function processresults

fid = fopen('masek-results2.txt','a');

list = filelist;

for n = 1:size(list,1)
    
    tmp = strcat(list(n,1),list(n,3));
    filename1 = tmp{:};

    if exist(filename1,'file');

        ref = load(filename1);
        subject = list(n,2);
        
        if (str2num(subject) > 29)
    
        for m = 1:size(list,1)

            tmp = strcat(list(m,1),list(m,3));
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
  
                fprintf(fid,'%s,%s,%s,%s,%d\n',subject{:},filename1,filename2,imposter,HD);
            
                end
            end
        end

        end
    end
  
end
