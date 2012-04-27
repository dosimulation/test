libname in "\\Mcprx\gfk\HCCI\Publications and Presentations\2009_MCRR MH paper with OC DHR"
        access = readonly;
options fmtsearch=(in) nofmterr;

proc freq data = in.No_id_20090614;
  tables gender_re;
  format gender_re Gender.;
run;
proc contents data = in.No_id_20090614;
run;

ods output crosstabfreqs = t;
proc freq data = in.No_id_20090614 ;
  tables age2*fpl*gender_re; 
  where fpl ^=.;
run; 

* example 1: creating a single sheet;
ods tagsets.excelxp
file='D:\work\hcci\example1.xls'
style=minimal
options ( Center_Horizontal = 'yes'
          Embedded_Titles = 'yes'
          Embedded_Footnotes = 'no' 
          sheet_name='data set 1');
title1 'Distribution of age by fpl';
title2 'and by gender';
footnote1 'where fpl is not missing';
proc print data = t ;
  var age2 fpl gender_re frequency percent rowpercent colpercent;
  where _type_ = "111";
  format gender_re Gender.;
run;
ods tagsets.excelxp close;


* example 1: creating a single sheet;
ods tagsets.excelxp
file='D:\work\hcci\example1.xls'
style=minimal
options (doc='help');
proc print data = t ;
  var age2 fpl gender_re frequency percent rowpercent colpercent;
  where _type_ = "111";
  format gender_re Gender.;
run;
ods tagsets.excelxp close;



* multiple sheets;
ods tagsets.excelxp
file='D:\work\hcci\example2.xls'
style=minimal;

ods tagsets.excelxp options (  sheet_name='data set 1');
proc print data = t ;
  var age2 fpl gender_re frequency percent rowpercent colpercent;
  where _type_ = "111";
  format gender_re Gender.;
run;
ods tagsets.excelxp options (  sheet_name='data set 2');
proc print data = t ;
  var age2 fpl gender_re frequency percent rowpercent colpercent;
  where _type_ = "111";
  format gender_re Gender.;
run;
ods tagsets.excelxp close;


* showing the digits!;
data t2;
  set t;
  rowpercent = rowpercent/100;
  colpercent = colpercent/100;
  percent=percent/100;
run;
ods tagsets.excelxp
file='D:\work\hcci\example3.xls'
style=minimal;
ods noproctitle;
ods tagsets.excelxp options (  sheet_name='gender_age');
proc print data= t2 ;
  var age2 fpl gender_re frequency;
  var percent rowpercent colpercent / style ={tagattr='format:##.000%'};;
  format gender_re Gender.;
  format percent rowpercent colpercent percent10.3;
run;
proc print data= t2 ;
  var age2 fpl gender_re frequency;
  var percent rowpercent colpercent / style ={tagattr='format:##.0%'};
  format gender_re Gender.;
run;
ods tagsets.excelxp close;


* putting on the same sheet, two proc print results;
ods tagsets.excelxp
file='D:\work\hcci\example4.xls'
style=minimal;

ods tagsets.excelxp options (  sheet_name='sheet1' sheet_interval='none');
proc print data= t2;
  var age2 fpl gender_re;
  format gender_re Gender.;
run;
proc print data = t2 ;
  var  frequency percent rowpercent colpercent / style ={tagattr='format:##.0%'};;
  where _type_ = "111";
run;
ods tagsets.excelxp close;

* an improved example;
ods tagsets.excelxp
file='D:\work\hcci\example5.xls'
style=minimal;

ods tagsets.excelxp options (  sheet_name='sheet1' sheet_interval='table');
proc print data= t2;
  var age2 fpl gender_re;
  format gender_re Gender.;
run;
proc print data = t2 ;
  var  frequency percent rowpercent colpercent / style ={tagattr='format:##.0%'};;
  where _type_ = "111";
run;
ods tagsets.excelxp close;



* proc report, proc tabulate, proc print 
