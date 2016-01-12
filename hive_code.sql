 
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




