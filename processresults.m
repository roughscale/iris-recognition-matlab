function processresults

fid = fopen('results5.txt','a');

list = filelist2;

for n = 1:size(list,1)
    
    tmp = fullfile(list(n,1),list(n,3));
    filename1 = tmp{:};
    
    if exist(filename1,'file');

        try
        ref = load(filename1,'iriscode2');
        catch
        end
        
        subject = list(n,2);

        if isstruct(ref)

            for m = 1:size(list,1)

            tmp = fullfile(list(m,1),list(m,3));
            filename2 = tmp{:};

            object = list(m,2);
        
            if ~strcmp(filename1,filename2)

                if exist(filename2,'file')
                    try
                    query = load(filename2,'iriscode2');
                    catch
                    end
                    if isstruct(query)
                        try
                        HD = hammingdistance(ref.iriscode2,query.iriscode2);
                        if strcmp(subject,object)
                            imposter = 'false';
                        else
                            imposter = 'true';
                        end
  
                        fprintf(fid,'%s,%s,%d\n',subject{:},imposter,HD);
                        catch
                        end
                    end
                end
            end
        end
       end
    end
    
end
fclose(fid)
