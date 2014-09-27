function results_gen

fid = fopen('same-results.txt','r');

same = zeros(1,1001);
diff = zeros(1,1001);
totsam = 0;

line = fgetl(fid);
while ischar(line)
    C = regexp(line,',','split');
    % C(1) is subject, C(2) is same eye, C(3) is HD
    HD = str2double(C(3));
    ind = uint32(HD * 1000) + 1;
    totsam = totsam + 1;
    
    if strcmp(C(2),'true')
        same(ind) = same(ind) + 1;
    else
        diff(ind) = diff(ind) + 1;
    end
    
    line = fgetl(fid);
end
    
save('gen_results.mat','same','diff','totsam')
