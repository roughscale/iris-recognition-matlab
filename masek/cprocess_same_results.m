% process iris images in cluster mode

c = parcluster('local')
job2 = createJob(c)
task2 = createTask(job2,@processsameresult,0,{})
submit(job2)


