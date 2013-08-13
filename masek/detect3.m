function detect3(directory,filename)



[template, mask] = createiristemplate([directory,filename])
save(regexprep([directory,filename],'.jpg','-masek.mat'),'template','mask')