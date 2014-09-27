function detect3(directory,filename)


[template, mask] = createiristemplate(fullfile(directory,filename))
output_base = 'results2014';
relative_path = regexprep(directory, 'casia_images/', '');
outfile = fullfile(output_base, relative_path, regexprep(filename, '.jpg', ''));

% Ensure output directory exists
[outdir, ~, ~] = fileparts(outfile);
if ~exist(outdir, 'dir')
    mkdir(outdir);
end
save([outfile, '-masek.mat'], 'template', 'mask');
