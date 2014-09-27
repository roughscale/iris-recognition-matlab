function plotresults
  % Plot 1: Genuine matches
  % Load genuine match data (same eye + different eye)
  load('gen_results.mat','same','diff');

  % Create x-axis (HD from 0 to 1, with 1001 bins)
  x = 0:0.001:1.0;

  % Combine same and diff into total genuine
  gen = same + diff;

  % Create figure
  figure;
  bar(x, gen, 'BarWidth', 1, 'FaceColor', [0 0 0.5], 'EdgeColor', 'none');
  xlabel('Hamming Distances');
  ylabel('Frequency');
  axis([0 1 0 max(gen)*1.1]);
  print -dpng hd-genuine.png

  % Plot 2: Imposter Matches
  % Load imposter match data
  load('results.mat','imp');

  % Create x-axis
  %x = 0:0.001:1.0;

  % Create figure
  figure;
  bar(x, imp, 'BarWidth', 1, 'FaceColor', [0 0 0.5], 'EdgeColor', 'none');
  xlabel('Hamming Distance');
  ylabel('Frequency');
  axis([0 1 0 max(imp)*1.1]);
  print -dpng hd-imposter.png

  % Plot 3: Genuine Same Eye Only

  %function plot_masek_genuine_same
  %load('gen_results.mat','same');
  x = 0:0.001:1.0;

  figure;
  bar(x, same, 'BarWidth', 1, 'FaceColor', [0 0 0.5], 'EdgeColor', 'none');
  xlabel('Hamming Distances');
  ylabel('Frequency');
  axis([0 1 0 max(same)*1.1]);
  print -dpng hd-genuine-same.png

  %Plot 4: Genuine Different Eye Only

  %function plot_masek_genuine_diff
  %load('gen_results.mat','diff');
  x = 0:0.001:1.0;

  figure;
  bar(x, diff, 'BarWidth', 1, 'FaceColor', [0 0 0.5], 'EdgeColor', 'none');
  xlabel('Hamming Distances');
  ylabel('Frequency');
  axis([0 1 0 max(diff)*1.1]);
  print -dpng hd-genuine-diff.png
