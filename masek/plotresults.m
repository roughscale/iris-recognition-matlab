function plotresults

% load results matrix
load('h:/research/matlab/masek/masek_results.mat','gen','imp')
rslts = zeros(200,2);
ind = 1;
for hd = 0:5:1000

    frr = sum(gen(hd+5:end)) / sum(gen);
    far = sum(imp(1:hd)) / sum(imp);
    rslts(ind,:) = [frr far];
    ind = ind + 1;
end
save('plotresults.mat','rslts')

% plot frr vs far

figure
hold on
plot(rslts(:,1),'b-')
plot(rslts(:,2),'r')
hold off

    