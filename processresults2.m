function processresults2

fid = fopen('results5.txt','r');


imp = zeros(1,1001);
gen = zeros(1,1001);
totsam = 0;
totgen = 0;

line = fgetl(fid);
while ischar(line)
    C = regexp(line,',','split')
    HD = str2double(C(3));
    ind = uint32(HD * 1000) + 1;
    totsam = totsam + 1;
    
    if strcmp(C(2),'true')
        imp(ind) = imp(ind) + 1;
    else
        gen(ind) = gen(ind) + 1;
        totgen = totgen + 1;
    end
    
    line = fgetl(fid);
end
    
save('results.mat','gen','imp','totsam','totgen')
