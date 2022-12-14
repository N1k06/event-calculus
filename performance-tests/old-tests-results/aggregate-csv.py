import csv

exec_sum = [0,0,0,0,0,0,0,0,0,0,0]
nelem = [0,0,0,0,0,0,0,0,0,0,0]
means = [0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.]
variances = [0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.]

choices = {10: 0, 100:1, 200:2, 300:3, 400:4, 500:5, 600:6, 700:7, 800:8, 900:9, 1000:10}

with open('seqSingleAl_sparse_kdtree_result.csv') as csvfile:
    reader = csv.reader(csvfile, delimiter=';')
    for row in reader:
        i = choices.get(int(row[1]), 1)
        exec_sum[i] = exec_sum[i] + int(row[0])
        nelem[i] = nelem[i] + 1

    for i in range(0,len(exec_sum)):
        means[i] = float(exec_sum[i])/float(nelem[i])

    

        variances[i] = float()


    print(exec_sum)
    print(nelem)
    print(means)
