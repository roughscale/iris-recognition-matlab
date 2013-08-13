function processresults6

% updates iriscodes

list = filelist2;

for n = 1:size(list,1)
    
    tmp = strcat(list(n,1),list(n,3));
    filename = tmp{:};

    if exist(filename,'file');

        ref = load(filename,'normiris','normiris2');

        iriscode = gaborwavelet2(ref.normiris,false,'tmp',1)
        iriscode2 = gaborwavelet2(ref.normiris2,false,'tmp',1)

        fprintf('Processing %s\n',filename);
        save(filename,'iriscode','iriscode2','-append')
            
    end
  
end
