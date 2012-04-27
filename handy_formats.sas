* 1. padding zeros to the left;
data a;
input x;
datalines;
1 
235
454
34
454454545
;
run;
data b;
  set a;
  x1 = put(x, z9.0);
run;
/*  results:
        x      x1
        1    000000001
      235    000000235
      454    000000454
       34    000000034
454454545    454454545
*/

* 2. putting quotation marks around;
proc print data = b noobs;
  format x1 $quote20.;
run;
/*  results:
        x      x1
        1    "000000001"
      235    "000000235"
      454    "000000454"
       34    "000000034"
454454545    "454454545"

*/

proc freq data = mydata.hsbdemo;
  tables ses*female /out=p;
run;
proc print data = p;
run;
