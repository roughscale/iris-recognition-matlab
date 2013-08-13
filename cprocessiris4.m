% process iris images in cluster mode

c = parcluster('local')
job1 = createJob(c)
task1 = createTask(job1,@processresults,0,{})
submit(job1)


