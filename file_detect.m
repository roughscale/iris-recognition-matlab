directory = 'H:\Downloads\CASIA-Iris-Lamp\CASIA-Iris-Lamp\001\L';
files = dir(strcat(directory,'\*.jpg'));
for file = files'
    detect(strcat(directory,'\',file.name))
end
