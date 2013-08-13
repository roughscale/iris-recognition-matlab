

function results_imp

fid = fopen('results5.txt','r');

imp2 = zeros(1,1001);
gen2 = zeros(1,1001);
totsam = 0;

%load('H:/research/matlab/masek/masek_imp_results.mat','imp','totsam');

line = fgetl(fid);
while ischar(line)
    C = regexp(line,',','split');
    % C(1) is subject, C(2) is imposter, C(3) is HD
    HD = str2double(C(3));
    ind = uint32(HD * 1000) + 1;
    totsam = totsam + 1;
    
    if strcmp(C(2),'true')
        imp2(ind) = imp2(ind) + 1;
    else
        gen2(ind) = gen2(ind) + 1;
    end
    line = fgetl(fid);
end
    
save('our_imp_results.mat','imp2','gen2','totsam')
