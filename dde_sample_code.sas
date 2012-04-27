proc means data=household_coded_12newb(where=(.<age<65)) nways sum;
	class drp_esi_mcd_sch_opub_xcs_xcu_uni;
	weight final_weight_2009CHIS_to_2016;
	var
	one
	prob_esi_t2
	prob_mcaid_t2
	prob_schp_t2
	prob_opub_t2
	prob_xcs_t2
	prob_xcu_t2
    prob_cat_t2
	prob_unins_t2
	;
	output out = s2 sum = 	one
	prob_esi_t2
	prob_mcaid_t2
	prob_schp_t2
	prob_opub_t2
	prob_xcs_t2
	prob_xcu_t2
    prob_cat_t2
	prob_unins_t2
;
run;

* using dynamic data exchange;
options noxwait noxsync; 
x '"C:\Program Files\Microsoft Office\Office12\excel.exe"';
x '"G:\Microsim Code\Microsim 7x7 Example_template.xlsx"';
filename tout dde 'excel|sheet2!r8c3:r15c10';
data  _null_;
  set s2 (drop=_type_ _freq_  drp_esi_mcd_sch_opub_xcs_xcu_uni);
  file tout;
  put 	one
	prob_esi_t2
	prob_mcaid_t2
	prob_schp_t2
	prob_opub_t2
	prob_xcs_t2
	prob_xcu_t2
    prob_cat_t2
	prob_unins_t2;
run;

* not working correctly with format;
filename tout dde 'excel|sheet3!r1c3:r20c9';
data t2;
  set t2;
  format gender_re Gender.;
run;
data _null_;
  set t2;
  file tout;
  if _n_<= 20 then 
  put age2 fpl gender_re frequency percent rowpercent colpercent;
run;
