function processsameresults_masek

fid = fopen('masek-same-results.txt','a');

list = filelist_masek;

for n = 1:size(list,1)
    
    tmp = fullfile(list(n,1),list(n,3));
    filename1 = tmp{:};

    if exist(filename1,'file');

        ref = load(filename1);
        [tmp1, subeye, tmp2] = fileparts(fileparts(filename1));
        subject = list(n,2);
        
    
        for m = 1:size(list,1)

            tmp = fullfile(list(m,1),list(m,3));
            object = list(m,2);

            if strcmp(subject{:},object{:})
                
                filename2 = tmp{:};
                [tmp1, objeye, tmp2] = fileparts(fileparts(filename2));

                if ~strcmp(filename1,filename2)

                if exist(filename2,'file')
                    query = load(filename2);
            
                    HD = gethammingdistance(ref.template,ref.mask,query.template,query.mask,1);
                    if strcmp(subeye,objeye)
                        same = 'true';
                    else
                        same = 'false';
                    end
  
                    fprintf(fid,'%s,%s,%d\n',subject{:},same,HD);
            
                end
                end
            end
        end        

    end
        
end

fclose(fid)

end

    
 
