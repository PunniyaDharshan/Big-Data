import re
import sys as sys
f=open('E:/biblio.xml','r')
li=f.readlines() 
one_patent_per_line=''  
for line in li:
        line = re.sub('\n', ' <endline> ', line)
        line = re.sub('\</us-patent-grant\>', '\n', line)
        one_patent_per_line += line
sys.stdout.write(one_patent_per_line)