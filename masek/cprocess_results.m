% process iris images in cluster mode

c = parcluster('local')
job1 = createJob(c)
task1 = createTask(job1,@results_imp,0,{})
submit(job1)


