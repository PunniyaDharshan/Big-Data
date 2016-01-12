 
/*Code used:*/


create table patent
(file string,date_produced string,date_publ string,invention_title string)
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe' 

WITH SERDEPROPERTIES (
  "column.xpath.file"="/us-patent-grant/@file",
  "column.xpath.date_produced"="/us-patent-grant/date-produced",
  "column.xpath.date_publ"="/us-patent-grant/date-publ",
  "column.xpath.invention_title"="/us-patent-grant/us-bibliographic-data-grant/invention-title/text()"
  )
  STORED AS
  INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
  OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
  
 TBLPROPERTIES (
    "xmlinput.start"="<us-patent-grant",
    "xmloutput.end"="</record>"
    );
 
------------------------------------------------------------------------------------------------------------------------------------
/* load data  inpath 'hdfs:/user/hive/ipgb.xml'  into TABLE patent*/
-------------------------------------------------------------------------------------------------------------------------------

 
 
/* Text parsing to get patent_no,date-publ,date-produced------ */
 
 select substr(
 file,
 (instr(file,'le="'))+4,
 (instr(file,'.XML'))-(instr(file,'file='))-6) 
 as patentno_datepubl,
substr(file,(instr(file,'date-produced="'))+15,
(instr(file,'date-publ')-2)-(instr(file,'date-produced="'))-15) 
as date_produced

from patent_ipgb where file like '%us-patent-grant%'

------------------------------------------------------------------------------------------------------------------------------------------


/* Text parsing to get invention-title-------*/

select substr(file,(instr(file,'>'))+1,
(instr(file,'</'))-(instr(file,'>'))-1) 
as Title
from patent_ipgb where file like '%invention-title%'
---------------------------------------------------------------------------------------------------------------------------------------

/*Code used to derive the  Factual Fields:*/


/*Code used to Extract Days Information:*/
select ((cast(substr(date_grant,1,4) as int)-cast(substr(date_publ,1,4) as int))*365) 
+ 
case when cast(substr(date_grant,5,2) as int)>=cast(substr(date_publ,5,2) as int) 
then (cast(substr(date_grant,5,2) as int)-cast(substr(date_publ,5,2) as int))*30
else (cast(substr(date_publ,5,2) as int)-cast(substr(date_grant,5,2) as int))*30
end
   + 
case when cast(substr(date_grant,7,2) as int)>=cast(substr(date_publ,7,2) as int) 
then (cast(substr(date_grant,7,2) as int)-cast(substr(date_publ,7,2) as int))
else (cast(substr(date_publ,7,2) as int)-cast(substr(date_grant,7,2) as int))
end as Granted_days
from days

-------------------------------------------------------------------------------------------------------------------------------
/*Code used to Extract Backward and Forward Citations:*/

select substr(file,(instr(file,'le="'))+4,(instr(file,'.XML'))-(instr(file,'file='))-6) as patentno_datepubl,
(substr(file,(instr(file,'<doc-number>'))+12,(instr(file,'</doc-number>'))-13)) as Backward_citation,
case when (substr(file,(instr(file,'<category>'))+10,(instr(file,'</category>'))-11)) like 'cited by%' 
then 1 else 0 end as Forward_citation
from patent_ipgb where file like '%us-patent-grant%' or file like '<category>%'
-------------------------------------------------------------------------------------------------------------------------------





