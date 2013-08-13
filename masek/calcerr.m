function calcerr

% load results matrix
load('h:/research/matlab/masek/masek_roc.mat','rslts')
diff = abs(rslts(:,1) - rslts(:,2))
err = find(abs(diff - min(diff)) < 10^-4)

    