function processsameresults

fid = fopen('results_same.txt','a');

list = filelist3;

for n = 1:size(list,1)
    
    tmp = strcat(list(n,1),list(n,3));
    tmpfilename1 = tmp{:};
    filename1 = regexprep(tmpfilename1,'.jpg','.mat');
    
    if exist(filename1,'file');

        try
        ref = load(filename1,'iriscode2');
        catch
        end
        [tmp1, subeye, tmp2] = fileparts(fileparts(filename1))
        
        subject = list(n,2);

        if isstruct(ref)

            for m = 1:size(list,1)

            tmp = strcat(list(m,1),list(m,3));
            object = list(m,2);
            if strcmp(subject,object)
                tmpfilename2 = tmp{:};
            
               filename2 = regexprep(tmpfilename2,'.jpg','.mat');

                object = list(m,2);
        
                if ~strcmp(filename1,filename2)

                    if exist(filename2,'file')
                        try
                        query = load(filename2,'iriscode2');
                        catch
                        end
                        if isstruct(query)

                            [tmp1, objeye, tmp2] = fileparts(fileparts(filename2))
                            HD = hammingdistance(ref.iriscode2,query.iriscode2);
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
    end
    
end
