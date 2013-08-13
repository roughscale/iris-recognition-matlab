function processfile(directory,filename, debug, force)

global logfh;
logfh = 1;


%if (force && ~exist(regexprep([directory,filename],'.jpg','.mat'),'file'))

    try
        % for testing
        %if exist(fullfile(directory,filename), 'file')
        %    disp(fullfile(directory,filename))
        %end
        fprintf(logfh, 'Processing %s\n', [directory,filename])
        detect2(directory,filename,debug, logfh);
    catch exception
        fprintf(logfh, '%s\n', getReport(exception)); 
        % retry with debugging
        try
            fprintf(logfh, 'Reprocessing %s with debugging\n', [directory,filename])
            detect2(directory, filename,true, logfh);
        catch exception2
            % we already have exception report
        end
    end    
%else
    fprintf(logfh,'%s already processed\n',[directory,filename])
%end
