 #Big-Data
 Hive code to extract data from a dirty XML file:
 
 
  select substr(
 file,
 (instr(file,'file="'))+6,
 (instr(file,'.XML'))-(instr(file,'file='))-6) 
 as patentno_datepubl,
substr(file,(instr(file,'date-produced="'))+15,
(instr(file,'date-publ')-2)-(instr(file,'date-produced="'))-15) 
as date_produced
from patent_ipgb where file like '%us-patent-grant%'



Sample XML data:

<us-patent-grant lang="EN" dtd-version="v4.1 2005-08-25" file="USD0531781-20061114.XML" status="PRODUCTION" id="us-patent-grant" country="US" date-produced="20061030" date-publ="20061114">
<us-bibliographic-data-grant>
<publication-reference>
<document-id>
<country>US</country>
<doc_number>D0531781</doc_number>
<kind>S1</kind>
<date>20061114</date>
</document-id>
</publication-reference>
<application-reference appl-type="design">
<document-id>
<country>US</country>
<doc_number>29200956</doc_number>
<date>20040308</date>
</document-id>
</application-reference>
<us-application-series-code>29</us-application-series-code>
<us-term-of-grant>
<length-of-grant>14</length-of-grant>
</us-term-of-grant>
<classification-locarno>
<edition>8</edition>
<main-classification>0199</main-classification>
</classification-locarno>
<classification-national>
<country>US</country>
<main-classification>D 1199</main-classification>
</classification-national>
<invention-title id="d0e53">Packaged teabag</invention-title>
