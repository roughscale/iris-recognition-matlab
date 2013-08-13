% process iris images in cluster mode

c = parcluster('local')
job1 = createJob(c)
task1 = createTask(job1,@processiris4masek,0,{})
submit(job1)


