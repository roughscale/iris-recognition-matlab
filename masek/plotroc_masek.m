function plotroc_masek

% load results matrix
load('results_masek.mat','gen','imp')
load('masek_gen_results.mat','same')
rslts = zeros(1001,2);
ind = 1;
for hd = 1:1001

    frr = sum(same(hd+5:end)) / sum(same);
    far = sum(imp(1:hd)) / sum(imp);
    rslts(ind,:) = [frr far];
    ind = ind + 1;
end
save('plotroc_masek.mat','rslts','frr','far')

% plot frr vs far

figure
hold on
plot(rslts(:,1),'-','LineWidth',2)
plot(rslts(:,2),':','LineWidth',2)
hold off

% calculate equal error rate (eer)

diff = abs(rslts(:,1) - rslts(:,2));
err = find(abs(diff - min(diff)) < 10^-4)

