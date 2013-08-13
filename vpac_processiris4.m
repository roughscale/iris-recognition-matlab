;
clusterHost = 'trifid.vpac.org';
remoteDataLocation = '/lustre/pRMIT0111/matlab';
eMail = 's2102843@student.rmit.edu.au';
timeLimit='24:00:00';
sched = findResource('scheduler', 'type', 'generic');
set(sched, 'DataLocation', 'C:\Users\s2102843\matlab');
set(sched, 'ClusterMatlabRoot', '/usr/local/matlab/R2012b');
set(sched, 'HasSharedFilesystem', true);
set(sched, 'ClusterOsType', 'unix');
set(sched, 'GetJobStateFcn', @pbsGetJobState);
set(sched, 'DestroyJobFcn', @pbsDestroyJob);
set(sched, 'ParallelSubmitFcn', {@parallelSubmitFcn, timeLimit, eMail, clusterHost, remoteDataLocation});
pjob = createParallelJob(sched)
set(pjob,'FileDependencies', {'c:\Users\s2102843\matlab\processwrapper.m'});
set(pjob,'PathDependencies', {'/lustre/pRMIT0111/matlab'});
createTask(pjob,'@processwrapper', 1,{});
set(pjob,'MinimumNumberOfWorkers',8);
set(pjob,'MaximumNumberOfWorkers',16);
submit(pjob);
waitForState(pjob, 'finished');
results = getAllOutputArguments(pjob)
celldisp(results)