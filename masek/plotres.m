function plotresults

% load results matrix
load('h:/research/matlab/masek/masek_results.mat','samgen','imp')
rslts = zeros(1001,2);
ind = 1;
for hd = 1:1001

    frr = sum(same(hd+5:end)) / sum(same);
    far = sum(t(1:hd)) / sum(t);
    rslts(ind,:) = [frr far];
    ind = ind + 1;
end
save('masek-roc.mat','rslts','frr','far')

% plot frr vs far

figure
hold on
plot(rslts(:,1),'-','LineWidth',2)
plot(rslts(:,2),':','LineWidth',2)


    