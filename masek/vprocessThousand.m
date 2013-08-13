;
clusterHost = 'trifid.vpac.org';
remoteDataLocation = '/lustre/pRMIT0111/matlab';
eMail = 's2102843@student.rmit.edu.au';
timeLimit='24:00:00';
sched = findResource('scheduler', 'type', 'generic');
set(sched, 'DataLocation', 'C:\Users\s2102843\matlab');
set(sched, 'ClusterMatlabRoot', '/usr/local/matlab/R2012b');
set(sched, 'HasSharedFilesystem', false);
set(sched, 'ClusterOsType', 'unix');
set(sched, 'GetJobStateFcn', @getGetJobState);
set(sched, 'DestroyJobFcn', @getDestroyJob);
% this is for R2008b
% set(sched, 'ParallelSubmitFcn', {@pbsNonSharedParallelSubmitFcn, timeLimit, eMail, clusterHost, remoteDataLocation});
% this is for R2012b
set(sched, 'ParallelSubmitFcn', {@parallelSubmitFcn, clusterHost, remoteDataLocation});
pjob = createParallelJob(sched);
set(pjob,'FileDependencies', {'c:\Users\s2102843\matlab\processThousand.m'});
set(pjob,'PathDependencies', {'/lustre/pRMIT0111/matlab'});
createTask(pjob,'@processThousand', 1,{});
set(pjob,'MinimumNumberOfWorkers',2)
set(pjob,'MaximumNumberOfWorkers',16)
% output the job details
get(pjob)
submit(pjob)
%waitForState(pjob, 'finished');
%results = getAllOutputArguments(pjob)
%celldisp(results)