import numpy as np
import csv
file=open('E:/python/page rank/page_rank.csv')
reader=csv.reader(file)
data=[]
rank=list()
sub_rank=list()
initial_rank=list()
out=list()

"""Assigning the values in the file to a seperte Array called data"""
for line in reader:
    data.append(line)
data=np.array(data)
file.close()

"""Getting the size of rows or columns to use it to generate indexes in a seperate list """
dup=data[:1,:].copy()
no_of_nodes=dup.size

"""Assigning Index values to a seperate List"""
v=0
li=list()
while v<no_of_nodes:
    li.append(v)
    v=v+1
    
"""Assigning Intial Rank values and also assigning out going nodes and sub ranks to 0"""

for i in li:
    initial_rank.append(float((1.0/no_of_nodes)))
    out.append(0)
    sub_rank.append(0)
    rank.append(0)

initial_rank=np.array(initial_rank,dtype=float)
out=np.array(out,dtype=float)
sub_rank=np.array(sub_rank,dtype=float)
rank=np.array(rank,dtype=float)
print initial_rank

"""Calculating outgoing node Values"""
for i in li:
    for j in li:
        if data[i,j]:
            out[j]=out[j]+1
print out

"""Calculating Page Rank Values"""
for n in li:
    
    print "Below are the values of Iteration %s" %(n+1)
    
    """Calculating value of 1st node""" 
    if n==0:
       for i in li:
           for j in li:
               if data[i,j]:
                  sub_rank[i]=initial_rank[j]/out[j] +sub_rank[i]
       for i in li:
           rank[i]=initial_rank[i]/no_of_nodes+(1-initial_rank[i])*(sub_rank[i])
           print "Node %s= %s" % ((i+1),rank[i])
           
#Calculating value of other nodes apart from 1st node  
       
    else:
        for i in li:
            initial_rank[i]=rank[i]
            sub_rank[i]=0
        for i in li:
           for j in li:
               if data[i,j]:
                  sub_rank[i]=initial_rank[j]/out[j] +sub_rank[i]
        for i in li:
           rank[i]=initial_rank[i]/no_of_nodes+(1-initial_rank[i])*(sub_rank[i])
           print "Node %s= %s" % ((i+1),rank[i])
    


      
                  
         

        
    








    
    




