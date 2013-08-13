function displayimages(files)

for l = 1:size(files,1)
    
    %fprintf(logfh,'Processing %s\n', [directory,filename])
    mat = load(regexprep(files(l,:),'.jpg','.mat'),'coords');
    mat.coords
    image = imread(files(l,:));
    plotcircles(image,mat.coords)
end