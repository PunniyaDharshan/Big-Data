import re

f=open('C:/Python27/pd.txt','r')
li=f.readlines()
pattern='file=\"(US[a-zA-Z0-9].*[a-zA-Z0-9]).*XML'
pattern1='<doc_number>([a-zA-Z0-9]+[0-9])</doc_number>'
for i in li:
    a=re.findall(pattern,i)
    b=re.findall(pattern1,i) 
    if a and b:
	   for j in range(len(b)):
	      
	      print "%s,%s" % (a[0],b[j])
f.close()
