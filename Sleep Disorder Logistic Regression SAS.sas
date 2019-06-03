%let path=C:\Users\User\Project\;
libname acq xport "&path.acq_h.xpt" access=readonly; proc copy inlib=acq outlib=work; run;
libname alq xport "&path.alq_h.xpt" access=readonly; proc copy inlib=alq outlib=work; run;
libname bpq xport "&path.bpq_h.xpt" access=readonly; proc copy inlib=bpq outlib=work; run;
libname cbq xport "&path.cbq_h.xpt" access=readonly; proc copy inlib=cbq outlib=work; run;
libname cdq xport "&path.cdq_h.xpt" access=readonly; proc copy inlib=cdq outlib=work; run;
libname csq xport "&path.csq_h.xpt" access=readonly; proc copy inlib=csq outlib=work; run;
libname dbq xport "&path.dbq_h.xpt" access=readonly; proc copy inlib=dbq outlib=work; run;
libname demo xport "&path.demo_h.xpt" access=readonly; proc copy inlib=demo outlib=work; run;
libname deq xport "&path.deq_h.xpt" access=readonly; proc copy inlib=deq outlib=work; run;
libname diq xport "&path.diq_h.xpt" access=readonly; proc copy inlib=diq outlib=work; run;
libname dlq xport "&path.dlq_h.xpt" access=readonly; proc copy inlib=dlq outlib=work; run;
libname dpq xport "&path.dpq_h.xpt" access=readonly; proc copy inlib=dpq outlib=work; run;
libname duq xport "&path.duq_h.xpt" access=readonly; proc copy inlib=duq outlib=work; run;
libname ecq xport "&path.ecq_h.xpt" access=readonly; proc copy inlib=ecq outlib=work; run;
libname fsq xport "&path.fsq_h.xpt" access=readonly; proc copy inlib=fsq outlib=work; run;
libname heq xport "&path.heq_h.xpt" access=readonly; proc copy inlib=heq outlib=work; run;
libname hiq xport "&path.hiq_h.xpt" access=readonly; proc copy inlib=hiq outlib=work; run;
libname hoq xport "&path.hoq_h.xpt" access=readonly; proc copy inlib=hoq outlib=work; run;
libname hsq xport "&path.hsq_h.xpt" access=readonly; proc copy inlib=hsq outlib=work; run;
libname huq xport "&path.huq_h.xpt" access=readonly; proc copy inlib=huq outlib=work; run;
libname imq xport "&path.imq_h.xpt" access=readonly; proc copy inlib=imq outlib=work; run;
libname inq xport "&path.inq_h.xpt" access=readonly; proc copy inlib=inq outlib=work; run;
libname mcq xport "&path.mcq_h.xpt" access=readonly; proc copy inlib=mcq outlib=work; run;
libname ocq xport "&path.ocq_h.xpt" access=readonly; proc copy inlib=ocq outlib=work; run;
libname ohq xport "&path.ohq_h.xpt" access=readonly; proc copy inlib=ohq outlib=work; run;
libname osq xport "&path.osq_h.xpt" access=readonly; proc copy inlib=osq outlib=work; run;
libname paq xport "&path.paq_h.xpt" access=readonly; proc copy inlib=paq outlib=work; run;
libname pfq xport "&path.pfq_h.xpt" access=readonly; proc copy inlib=pfq outlib=work; run;
libname puqmec xport "&path.puqmec_h.xpt" access=readonly; proc copy inlib=puqmec outlib=work; run;
libname rhq xport "&path.rhq_h.xpt" access=readonly; proc copy inlib=rhq outlib=work; run;
libname slq xport "&path.slq_h.xpt" access=readonly; proc copy inlib=slq outlib=work; run;
libname smq xport "&path.smq_h.xpt" access=readonly; proc copy inlib=smq outlib=work; run;
libname smqfam xport "&path.smqfam_h.xpt" access=readonly; proc copy inlib=smqfam outlib=work; run;
libname smqrtu xport "&path.smqrtu_h.xpt" access=readonly; proc copy inlib=smqrtu outlib=work; run;
libname smqshs xport "&path.smqshs_h.xpt" access=readonly; proc copy inlib=smqshs outlib=work; run;
libname sxq xport "&path.sxq_h.xpt" access=readonly; proc copy inlib=sxq outlib=work; run;
libname whq xport "&path.whq_h.xpt" access=readonly; proc copy inlib=whq outlib=work; run;
libname whqmec xport "&path.whqmec_h.xpt" access=readonly; proc copy inlib=whqmec outlib=work; run;

/**********Dataset use for the model, with all recoding done**********/
data nhanes;
	/*Still need to determine variables in demo_h that should be kept.*/
	merge demo_h acq_h alq_h bpq_h cbq_h cdq_h csq_h dbq_h deq_h diq_h dlq_h dpq_h duq_h ecq_h fsq_h heq_h
		hiq_h hoq_h hsq_h huq_h imq_h inq_h mcq_h ocq_h ohq_h osq_h paq_h pfq_h puqmec_h rhq_h slq_h
		smq_h smqfam_h smqrtu_h smqshs_h sxq_h whq_h whqmec_h;
	by SEQN;
	keep RIAGENDR RIDAGEYR RIDRETH3 BPQ020 BPQ080 HSD010 DIQ010 DBQ700 DLQ010 DLQ020
			FSD151 HIQ011 HOQ065 IND235 MCQ010 MCQ053 MCQ080 MCQ160a MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220
			OCD150 PUQ110 PAQ665 PAQ710 PAQ715 SLD010H SLQ050 SLQ060 SMQ020 SMDANY;

	/*Recoding the values "Refuse" and "Don't Know" as missing values*/
	array vars1{27} BPQ020 BPQ080 HSD010 DIQ010 DBQ700 DLQ010 DLQ020
			FSD151 HIQ011 HOQ065 MCQ010 MCQ053 MCQ080 MCQ160a MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220
			OCD150 PUQ110 PAQ665 SLQ050 SLQ060 SMQ020 SMDANY;
	do i=1 to dim(vars1);
		if (vars1{i} = 7) or (vars1{i} = 9) then call missing(vars1{i});
	end;
	array vars2{4} IND235 PAQ710 PAQ715 SLD010H;
	do i=1 to dim(vars2);
		if (vars2{i} = 77) or (vars2{i} = 99) then call missing(vars2{i});
	end;
	if OCD150=2 then OCD150=1;
	if OCD150=3 then OCD150=4;
	/*Variables that don't have values that need to be recoded*/
	/*RIAGENDR RIDAGEYR RIDRETH3*/
	/**********************************************************/
	if RIDAGEYR ge 20;
run;
/************************************************************************/

/**********Formats for each variable to make the output look nice**********/
proc format;
	value nhanesYN 1="Yes" 2="No";
	value nhanesBPYN 1="Yes High Blood Pressure" 2="No High Blood Pressure";
	value nhanesHCYN 1="Yes High Cholesterol" 2="No High Cholesterol";
	value nhanesDBYN 1="Yes Diabetes" 2="No Diabetes" 3="Borderline Diabetes";
	value nhanesASYN 1="Yes Asthma" 2="No Asthma";
	value nhanesOWYN 1="Yes Overweight" 2="No Overweight";
	value nhanesARYN 1="Yes Arthritis" 2="No Arthritis";
	value nhanesGender 1="Male" 2="Female";
	value nhanesRace 1="Mexican American" 2="Other Hispanic" 3="Non-Hispanic White"
			4="Non-Hispanic Black" 6="Non-Hispanic Asian" 7="Other Race - Including Multi-Racial";
	value nhanesHealth 1="Excellent General Health" 2="Very Good General Health"
			3="Good General Health" 4="Fair General Health" 5="Poor General Health";
	value nhanesHome 1="Owned or Being Bought" 2="Rented" 3="Other Arrangement";
	value nhanesSleepHours 1="1 Hour" 2="2 Hours" 3="3 Hours" 4="4 Hours" 5="5 Hours" 6="6 Hours"
			7="7 Hours" 8="8 Hours" 9="9 Hours" 10="10 Hours" 11="11 Hours" 12="12 or more Hours";
	value nhanesWork 1="Employed" 4="Unemployed";
	value nhanesHIYN 1="Yes Health Insurance" 2="No Health Insurance";
run;
/***************************************************************************/

/**********Running proc logistic for the variable selection and final model**********/
proc logistic data=nhanes;
	class RIAGENDR RIDRETH3(ref="Non-Hispanic White") BPQ020(ref="No High Blood Pressure") BPQ080(ref="No High Cholesterol") HSD010(ref="Poor General Health")
			DIQ010(ref="No Diabetes") DBQ700 DLQ010 DLQ020 FSD151 HIQ011(ref="No Health Insurance") HOQ065(ref="Other Arrangement")
			IND235 MCQ010(ref="No Asthma") MCQ053 MCQ080(ref="No Overweight") MCQ160a(ref="No Arthritis")
			MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220 OCD150(ref="Unemployed") PUQ110 PAQ665 SMQ020 SMDANY / param=ref;
	format RIAGENDR nhanesGender. RIDRETH3 nhanesRace. BPQ020 nhanesBPYN. BPQ080 nhanesHCYN.
		HSD010 nhanesHealth. DIQ010 nhanesDBYN. HIQ011 nhanesHIYN. HOQ065 nhanesHome. MCQ010 nhanesASYN. MCQ080 nhanesOWYN.
		MCQ160A nhanesARYN. OCD150 nhanesWork. SLD010H nhanesSleepHours.;
	model SLQ060 = RIAGENDR RIDAGEYR RIDRETH3 BPQ020 BPQ080 HSD010 DIQ010 DBQ700 DLQ010 DLQ020
			FSD151 HIQ011 HOQ065 IND235 MCQ010 MCQ053 MCQ080 MCQ160a MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220
			OCD150 PUQ110 PAQ665 PAQ710 PAQ715 SLD010H SMQ020 SMDANY / selection=backward lackfit aggregate scale=none influence;
	output out=nhanes_out reschi=reschi resdev=resdev;
run;
/************************************************************************************/

/**********Histograms for the residuals if needed**********/
proc univariate data=nhanes_out;
	histogram reschi;
	histogram reschi;
run;
/**********************************************************/













/**********Just the raw data if needed**********/
data nhanes_raw;
	/*Still need to determine variables in demo_h that should be kept.*/
	merge demo_h acq_h alq_h bpq_h cbq_h cdq_h csq_h dbq_h deq_h diq_h dlq_h dpq_h duq_h ecq_h fsq_h heq_h
		hiq_h hoq_h hsq_h huq_h imq_h inq_h mcq_h ocq_h ohq_h osq_h paq_h pfq_h puqmec_h rhq_h slq_h
		smq_h smqfam_h smqrtu_h smqshs_h sxq_h whq_h whqmec_h;
	by SEQN;
run;
proc print data=nhanes_raw(obs=100);
run;
/***********************************************/

/**********Initial count of missing data**********/
proc freq data=nhanes;
	tables RIAGENDR RIDAGEYR RIDRETH3 BPQ020 BPQ080 HSD010 DIQ010 DBQ700 DLQ010 DLQ020
			FSD151 HIQ011 HOQ065 IND235 MCQ010 MCQ053 MCQ080 MCQ160a MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220
			OCD150 PUQ110 PAQ665 PAQ710 PAQ715 SLD010H SLQ050 SLQ060 SMQ020 SMDANY
			/ nocum missing;
run;
/*************************************************/

/**********Two way interaction model took 12 hours to run and didn't improve the model fit**********/
proc logistic data=nhanes;
	class RIAGENDR RIDRETH3 BPQ020 BPQ080 HSD010 DIQ010 DBQ700 DLQ010 DLQ020
			FSD151 HIQ011 HOQ065 MCQ010 MCQ053 MCQ080 MCQ160a MCQ160b MCQ160c MCQ160e MCQ160f MCQ160l MCQ220
			OCD150 PUQ110 PAQ665 SMQ020 SMDANY;
	model SLQ060 = RIAGENDR|RIDAGEYR|RIDRETH3|BPQ020|BPQ080|HSD010|DIQ010|DBQ700|DLQ010|DLQ020|
			FSD151|HIQ011|HOQ065|IND235|MCQ010|MCQ053|MCQ080|MCQ160a|MCQ160b|MCQ160c|MCQ160e|MCQ160f|MCQ160l|MCQ220|
			OCD150|PUQ110|PAQ665|PAQ710|PAQ715|SLD010H|SMQ020|SMDANY@2 / selection=backward lackfit;
run;
/***************************************************************************************************/

/**********Just to test for number of missing values in each observation**********/
data test;
	set nhanes;
	array var{*} _NUMERIC_;
	tmiss = 0;
	do i=1 to dim(var);
		if missing(var{i}) then do;
			tmiss = tmiss + 1;
		end;
	end;
run;
proc univariate data=test;
	var tmiss;
	histogram tmiss;
run;
/**********************************************************************************/

