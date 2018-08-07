/*Selecting 3 month variables*/

%let month3=NoNFA3mon
NoNFAbalance3mon
NoTA3mon
NoTAbalance3mon
NoUA3mon
NoUAbalance3mon
NoIAc3mon
NoIAcbalance3mon
NoSA3mon
NoSAbalance3mon
HstNFB3mon
HstTB3mon
HstUB3mon
HstIB3mon
totonSA3mon
OrgCrdLmtNFA3mon
HstNFACmt3mon
TotUtiNFA3mon
totNFA1CPD3mon
totNFA1CPDC3mon
totNFA2CPD3mon
totNFA2CPDC3mon
totNFA3CPD3mon
totNFA3CPDC3mon
totNFA4CPDC3mon
totTA1CPD3mon
totTA1CPDC3mon
totTA2CPD3mon
totTA2CPDC3mon
totTA3CPD3mon
totTA3CPDC3mon
totTA4CPDC3mon
totUA1CPD3mon
totUA1CPDC3mon
totUA2CPD3mon
totUA2CPDC3mon
totUA3CPD3mon
totUA3CPDC3mon
totUA4CPDC3mon
totIA1CPD3mon
totIA1CPDC3mon
totIA2CPD3mon
totIA2CPDC3mon
totIA3CPD3mon
totIA3CPDC3mon
totIA4CPDC3mon
NoNewNFAcc3mon26
totNFPDAmt3mon
totC1NFPDAmt3mon
totC2NFPDAmt3mon
totC3NFPDAmt3mon
totC4NFPDAmt3mon
totSPDAmt3mon
NoNFChgAcc3mon
totNFChgAmt3mon
NoSasNFA3mon
pctSasNFA3mon
pctNFPDAmtst3mon
pctNFC4PDAmt3mon
pctNFChgAccAcc3mon
WstNFpay3mon
WstTpay3mon
WstUpay3mon
WstIpay3mon
;


/* Selecting 12 month variables*/
%let month12=NoNFA12mon
NoTA12mon
NoUA12mon
NoIAc12mon
NoSA12mon
HstNFB12mon
HstTB12mon
HstUB12mon
HstIB12mon
totonSA12mon
OrgCrdLmtNFA12mon
HstNFACmt12mon
TotUtiNFA12mon
totNFA1CPD12mon
totNFA1CPDC12mon
totNFA2CPD12mon
totNFA2CPDC12mon
totNFA3CPD12mon
totNFA3CPDC12mon
totNFA4CPDC12mon
totTA1CPD12mon
totTA1CPDC12mon
totTA2CPD12mon
totTA2CPDC12mon
totTA3CPD12mon
totTA3CPDC12mon
totTA4CPDC12mon
totUA1CPD12mon
totUA1CPDC12mon
totUA2CPD12mon
totUA2CPDC12mon
totUA3CPD12mon
totUA3CPDC12mon
totUA4CPDC12mon
totIA1CPD12mon
totIA1CPDC12mon
totIA2CPD12mon
totIA2CPDC12mon
totIA3CPD12mon
totIA3CPDC12mon
totIA4CPDC12mon
totNFPDAmt12mon
totC1NFPDAmt12mon
totC2NFPDAmt12mon
totC3NFPDAmt12mon
totC4NFPDAmt12mon
NoNFChgAcc12mon
totNFChgAmt12mon
NoSasNFA12mon
pctSasNFA12mon
pctNFPDAmt12mon
pctNFC4PDAmt12mon
pctNFChgAccAcc12mon
WstNFpay12mon
WstTpay12mon
WstUpay12mon
WstIpay12mon
;

/* Selecting 24 month variables*/
%let month24=NoNFA24mon
NoTA24mon
NoUA24mon
NoIAc24mon
NoSA24mon
HstNFB24mon
HstTB24mon
HstUB24mon
HstIB24mon
totonSA24mon
OrgCrdLmtNFA24mon
HstNFACmt24mon
TotUtiNFA24mon
totNFA1CPD24mon
totNFA1CPDC24mon
totNFA2CPD24mon
totNFA2CPDC24mon
totNFA3CPD24mon
totNFA3CPDC24mon
totNFA4CPDC24mon
totTA1CPD24mon
totTA1CPDC24mon
totTA2CPD24mon
totTA2CPDC24mon
totTA3CPD24mon
totTA3CPDC24mon
totTA4CPDC24mon
totUA1CPD24mon
totUA1CPDC24mon
totUA2CPD24mon
totUA2CPDC24mon
totUA3CPD24mon
totUA3CPDC24mon
totUA4CPDC24mon
totIA1CPD24mon
totIA1CPDC24mon
totIA2CPD24mon
totIA2CPDC24mon
totIA3CPD24mon
totIA3CPDC24mon
totIA4CPDC24mon
totNFPDAmt24mon
totC1NFPDAmt24mon
totC2NFPDAmt24mon
totC3NFPDAmt24mon
totC4NFPDAmt24mon
NoNFChgAcc24mon
totNFChgAmt24mon
NoSasNFA24mon
pctSasNFA24mon
pctNFPDAmt24mon
pctNFC4PDAmt24mon
pctNFChgAccAcc24mon
WstNFpay24mon
WstTpay24mon
WstUpay24mon
WstIpay24mon
;


/* Selecting posthoc variables*/
%let posthoc=
CrdRiskScore1
SCR0041
ReasonCode1_41
ReasonCode2_41
ReasonCode3_41
ReasonCode4_41
RejectCode_41
RejectDescription_41
FailRiskRating
SCR0043
ScoreValue_43
ReasonCode1_43
ReasonCode2_43
ReasonCode3_43
ReasonCode4_43
RejectCode_43
RejectDescription_43
EarlyDefaultScore
SCR0078
ScoreValue_78
ReasonCode1_78
ReasonCode2_78
ReasonCode3_78
ReasonCode4_78
RejectCode_78
RejectDescription_78
;

/***********************************Analysis*/////

proc sql;
select distinct ScoreValue_41 from eq2.eq102013;
run;

/*11787287 observations total*/
proc sql;
create table soco_sou.eq102014_score as
select eq2013.* ,eq2014.ScoreValue_41 as ScoreValue_41_2014
from eq2.eq102013  as eq2013,
eq2.eq102014  as eq2014
where eq2013.MPID=eq2014.MPID;
run;

proc sql;
select distinct ScoreValue_41_2014 from SOCO_SOU.eq102014_score;
run;
/*4772535 observations after removing missing values in target variable*/ 
data SOCO_SOU.eq102014_score ;
set SOCO_SOU.eq102014_score (drop= ScoreValue_41) ;
where ScoreValue_41_2014 ne .;
run;
/*Removing credit score value Zero as it is invalid after remvoing 4693371 observations*/
data SOCO_SOU.eq102014_score ;
set SOCO_SOU.eq102014_score ;
where ScoreValue_41_2014 ne 0;
run;

proc sql;
select distinct ScoreValue_41_2014 from SOCO_SOU.eq102014_score;
run;

proc univariate data=SOCO_SOU.eq102014_score ;
var ScoreValue_41_2014 ;
histogram/normal;
run;


data SOCO_SOU.eq102014_score   ;
set soco_sou.eq102014_score ;
if ScoreValue_41_2014 < 450 then BADCredit=1;
else BADCredit=0;
run;
/* checking distribution of target binary variable */
proc freq data=SOCO_SOU.eq102014_score  ;
tables BADCredit;
run;


proc means data=soco_sou.eq102014_score  N NMISS min q1 median q3 max;
run;

/* removing posthoc variables now 279 variables after dropping them*/
data SOCO_SOU.eq102014_score ;
set soco_sou.eq102014_score (drop=CrdRiskScore1
SCR0041
ReasonCode1_41
ReasonCode2_41
ReasonCode3_41
ReasonCode4_41
RejectCode_41
RejectDescription_41
FailRiskRating
SCR0043
ScoreValue_43
ReasonCode1_43
ReasonCode2_43
ReasonCode3_43
ReasonCode4_43
RejectCode_43
RejectDescription_43
EarlyDefaultScore
SCR0078
ScoreValue_78
ReasonCode1_78
ReasonCode2_78
ReasonCode3_78
ReasonCode4_78
RejectCode_78
RejectDescription_78) ;
run;


data SOCO_SOU.eq102014_scorenum;
set SOCO_SOU.eq102014_score (keep=_NUMERIC_);
run;

/*11 character*/
data SOCO_SOU.eq102014_scorechar;
set SOCO_SOU.eq102014_score (keep=_CHAR_);
run;

/*macro to select input variable*/
%MACRO IMPV3(DSN=,VARS=,EXCLUDE=,PCTREM=,MSTD=)/MINOPERATOR;
%PUT IMPUTE 3.0 IS NOW RUNNING YOU ARE THE GREATEST;

*DETERMING LOG STUFF;
FILENAME LOG1 DUMMY;
PROC PRINTTO LOG=LOG1;
RUN;

/*FILE AND DATA SET REFERENCES*/
%IF %INDEX(&DSN,.) %THEN %DO;
        %LET LIB=%UPCASE(%SCAN(&DSN,1,.));
        %LET DATA=%UPCASE(%SCAN(&DSN,2,.));
%END;
%ELSE %DO;
        %LET LIB=WORK;
        %LET DATA=%UPCASE(&DSN);
%END;

%LET DSID=%SYSFUNC(OPEN(&LIB..&DATA));
%LET NOBS=%SYSFUNC(ATTRN(&DSID,NOBS));
%LET CLOSE=%SYSFUNC(CLOSE(&DSID));

%PUT &NOBS;

DATA TEMP;
     SET &LIB..&DATA;
RUN;

/*MODULE IF _ALL_ KEYWORD IS PRESENT*/
%IF %UPCASE(&VARS)=_ALL_ AND &EXCLUDE= %THEN %DO;
PROC PRINTTO;
RUN;

%PUT ============================================;
%PUT XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
%PUT ;
%PUT XXX: EXCLUDE PARAMETER IS NULL;
%PUT XXX: IMPUTE MACRO IS TERMINATING PREMATURELY;
%PUT;
%PUT XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX;
%PUT ============================================;

%RETURN;
%END;

%ELSE %IF %UPCASE(&VARS)=_ALL_ AND &EXCLUDE^= %THEN %DO;

%LET NEXC=%SYSFUNC(COUNTW(&EXCLUDE,%STR( )));
/*SELECTING ALL THE VARIABLES TO BE IMPUTED*/

PROC SQL NOPRINT;
        SELECT NAME INTO: VARNAME SEPARATED BY ' '
                FROM DICTIONARY.COLUMNS
                WHERE UPCASE(LIBNAME)="&LIB" AND UPCASE(MEMNAME)="&DATA"
                AND NAME NOT IN("%SCAN(&EXCLUDE,1,%STR( ))" %DO A=2 %TO &NEXC;
                ,"%SCAN(&EXCLUDE,&A,%STR( ))"
                %END;);
QUIT;

%DO B=1 %TO %SYSFUNC(COUNTW(&VARNAME,%STR( )));
                
%LET CURR=%SCAN(&VARNAME,&B,%STR( ));
/*FINDING OUT IF VAR CONTAINS CODES*/
PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MAX;
        VAR &CURR;
        OUTPUT OUT=MAX MAX=MAX;
RUN;

DATA _NULL_;
        SET MAX;
        CALL SYMPUTX('MAX',MAX);
RUN;
/*IF NO CODED VALUES ARE DETECTED THEN IMPUTATION OF MISSING VALUES OCCURS*/
/*I KNOW THERE ARE MSSING VALUES WITHIN THE DATA SET BUT JUST IN CASE*/
%IF %EVAL(%SYSFUNC(INDEXW(%STR(999999999 99999999 9999999 9999 999 99 9.9999),&MAX))<1) %THEN %DO;
PROC SQL NOPRINT;
        SELECT MISSING(&CURR) INTO: MISS
        FROM TEMP;
QUIT;
/*THIS DROPS VARS IF PROBALITY OF FINDING A MISSING VALUES IS GREATER THEN PCTREM*/
%IF %SYSEVALF((&MISS/&NOBS)>&PCTREM) %THEN %DO;
PROC SQL NOPRINT;
        ALTER TABLE TEMP
        DROP &CURR;
QUIT;

PROC PRINTTO;
RUN;
%PUT &CURR HAS BEEN REMOVED BECAUSE IT DOES NOT MEET &PCTREM CRITERION;
PROC PRINTTO LOG=LOG1
RUN;
%END;

%ELSE %DO;
/*FINDING MEDIAN*/
PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MEDIAN;
        VAR &CURR;
        OUTPUT OUT=MEDI MEDIAN=MEDIAN;
RUN;

DATA _NULL_;
        SET MEDI;
        CALL SYMPUTX('MEDIAN',MEDIAN);
RUN;
/*MISSING IMPUTATION*/
DATA TEMP;
        SET TEMP;
        IF &CURR=. THEN &CURR=&MEDIAN;
RUN;
%END;
%END;
/*THIS NEXT PART IS SAME AS ABOVE WITH THE EXCEPTION THIS HANDLES CODED VALUES*/
%ELSE %DO;
DATA _NULL_;
        IF &MAX=99 THEN CALL SYMPUTX('LOW',92);
                ELSE IF &MAX=999 THEN CALL SYMPUTX('LOW',992);
                        ELSE IF &MAX=9999 THEN CALL SYMPUTX('LOW',9992);
                ELSE IF &MAX=9.9999 THEN CALL SYMPUTX('LOW',9.9992);
        ELSE CALL SYMPUTX('LOW',9999992);
RUN;

PROC SQL NOPRINT;
        SELECT COUNT(&CURR) INTO: CCODE
                        FROM TEMP
                        WHERE &CURR BETWEEN &LOW AND &MAX;
        SELECT MISSING(&CURR) INTO: MISS
                        FROM TEMP;
QUIT;

%IF %SYSEVALF(((&CCODE+&MISS)/&NOBS)>&PCTREM) %THEN %DO;

PROC SQL;
        ALTER TABLE TEMP
        DROP &CURR;
QUIT;

PROC PRINTTO;
RUN;
%PUT &CURR HAS BEEN REMOVED, TOO MUCH DATA IS CODED OR MISSING;
PROC PRINTTO LOG=LOG1;
RUN;
%END;
                        
%ELSE %DO;
PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MEDIAN STD MEAN;
        VAR &CURR;
        OUTPUT OUT=NUM MEDIAN=MEDIAN STD=STD MEAN=MEAN;
        WHERE &CURR<&LOW;
RUN;

DATA _NULL_;
        SET NUM;
        CALL SYMPUTX('MEDIAN',MEDIAN);
        CALL SYMPUTX('STD',STD);
        CALL SYMPUTX('MEAN',MEAN);
RUN;

DATA TEMP;
        SET TEMP;
        IF &LOW<=&CURR<=&MAX | &CURR>&MEAN+&MSTD*&STD | &CURR<&MEAN-&MSTD*&STD THEN &CURR=&MEDIAN;
RUN;
%END;
%END;
%END;
%END;

/*THIS NEXT PART HANDLES A LIST OF VARIABLES PROVIDED IN THE VAR STATEMENT*/
%ELSE %DO;
%LET NVAR=%SYSFUNC(COUNTW(&VARS,%STR( )));

%DO C=1 %TO &NVAR;
%LET CURR=%SCAN(&VARS,&C,%STR( ));

PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MAX;
VAR &CURR;
OUTPUT OUT=MAX MAX=MAX;
RUN;

DATA _NULL_;
        SET MAX;
        CALL SYMPUTX('MAX',MAX);
RUN;
                
%IF %EVAL(%SYSFUNC(INDEXW(%STR(999999999 9999999 9999 999 99 9.9999),&MAX))<1) %THEN %DO;
PROC SQL NOPRINT;
        SELECT MISSING(&CURR) INTO: MISS
                FROM TEMP;
QUIT;

%IF %SYSEVALF((&MISS/&NOBS)>&PCTREM) %THEN %DO;
PROC SQL NOPRINT;
        ALTER TABLE TEMP
        DROP &CURR;
QUIT;
%END;

%ELSE %DO;
PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MEDIAN;
        VAR &CURR;
        OUTPUT OUT=MEDI MEDIAN=MEDIAN;
RUN;

DATA _NULL_;
        SET MEDI;
        CALL SYMPUTX('MEDIAN',MEDIAN);
RUN;

DATA TEMP;
        SET TEMP;
        IF &CURR=. THEN &CURR=&MEDIAN;
RUN;
%END;
%END;

%ELSE %DO;
DATA _NULL_;
        IF &MAX=99 THEN CALL SYMPUTX('LOW',92);
                ELSE IF &MAX=999 THEN CALL SYMPUTX('LOW',992);
                        ELSE IF &MAX=9999 THEN CALL SYMPUTX('LOW',9992);
                ELSE IF &MAX=9.9999 THEN CALL SYMPUTX('LOW',9.9992);
        ELSE CALL SYMPUTX('LOW',9999992);
RUN;

PROC SQL NOPRINT;
        SELECT COUNT(&CURR) INTO: CCODE
                FROM TEMP
                WHERE &CURR BETWEEN &LOW AND &MAX;
        SELECT MISSING(&CURR) INTO: MISS
                FROM TEMP;
QUIT;

%IF %SYSEVALF(((&CCODE+&MISS)/&NOBS)>&PCTREM) %THEN %DO;

PROC SQL;
        ALTER TABLE TEMP
        DROP &CURR;
QUIT;

PROC PRINTTO;
RUN;
%PUT &CURR HAS BEEN REMOVED, TOO MUCH DATA IS CODED OR MISSING;
PROC PRINTTO LOG=LOG1;
RUN;
%END;
                        
%ELSE %DO;
PROC MEANS DATA=TEMP(KEEP=&CURR) NOPRINT MEDIAN STD MEAN;
        VAR &CURR;
        OUTPUT OUT=NUM MEDIAN=MEDIAN STD=STD MEAN=MEAN;
        WHERE &CURR<&LOW;
RUN;

DATA _NULL_;
        SET NUM;
        CALL SYMPUTX('MEDIAN',MEDIAN);
        CALL SYMPUTX('STD',STD);
        CALL SYMPUTX('MEAN',MEAN);
RUN;

DATA TEMP;
        SET TEMP;
        IF &LOW<=&CURR<=&MAX | &CURR>(&MEAN + &MSTD*&STD) | &CURR<(&MEAN -&MSTD*&STD) THEN &CURR=&MEDIAN;
RUN;
%END;
%END;
%END;
%END;

/*CREATING NEW DATASET*/
DATA &LIB..&DATA.OUT;
        SET TEMP;
RUN;

PROC DATASETS NOLIST;
        DELETE NUM TEMP MEDI MAX;
QUIT;

PROC PRINTTO;
RUN;

%PUT THIS MACRO HAS FINISHED RUNNING HAVE A NICE DAY;
%MEND IMPV3;

proc contents data=SOCO_SOU.eq102011_2014_GT450CHAR;
run;


proc contents data=SOCO_SOU.eq102011_14_GT450num;
run;
%IMPV3(DSN=SOCO_SOU.eq102014_scorenum, VARS=_ALL_, EXCLUDE = SnapshotDate ArchiveDate ScoreValue_41_2014 BADCREDIT,PCTREM=0.5,MSTD=4)/MINOPERATOR;

proc means data=SOCO_SOU.eq102014_scorenumout nmiss min q1 median q3 max;
run;


proc contents data=SOCO_SOU.eq102014_scorenumout;
run;

/**example of numeric variables before imputation: totNFPDAmt24mon**/
proc univariate data=SOCO_SOU.eq102014_scorenum noprint;
var HstNFB24mon;
histogram;
run;
proc means data=SOCO_SOU.eq102014_scorenum min max;
var totNFPDAmt24mon;
run;


/**example of numeric variables after imputation: totNFPDAmt24mon**/
proc univariate data=SOCO_SOU.eq102014_scorenumout noprint;
var HstNFACmt3mon;
histogram;
run;
proc means data=SOCO_SOU.eq102014_scorenumout min max;
run;
proc contents data=SOCO_SOU.eq102014_scorenumout;
run;

proc contents data=SOCO_SOU.eq102014_12monthdata;
run;

Data SOCO_SOU.eq102014_12monthdata(drop=NoNFA24mon totNFA1CPD24mon
totNFA1CPDC24mon
HstNFB24mon
pctNFC4PDAmt24mon
TotUtiNFA24mon
NoSasNFA24mon
pctSasNFA24mon
NoNFChgAcc24mon
totNFA2CPD24mon
totNFA2CPDC24mon
totNFA3CPD24mon
totNFA3CPDC24mon
totNFA4CPDC24mon
totNFPDAmt24mon
totC1NFPDAmt24mon
totC2NFPDAmt24mon
totC3NFPDAmt24mon
totC4NFPDAmt24mon
pctNFPDAmt24mon
pctNFChgAccAcc24mon
);
set SOCO_SOU.eq102014_scorenumout;
run;


Data SOCO_SOU.eq102014_3monthdata(drop=NoNFA12mon pctSasNFA12mon
TotUtiNFA12mon
pctNFPDAmt12mon
pctNFChgAccAcc12mon
pctNFC4PDAmt12mon
);
set SOCO_SOU.eq102014_12monthdata;
run;

Data SOCO_SOU.eq102014_24monthdata;
set SOCO_SOU.eq102014_scorenumout;
run;


%let ds2 = SOCO_SOU.eq102014_12monthdata;

Data cluster  (drop= ScoreValue_41_2014 BADCredit);
set &ds2;
run;


%macro varsel(input=, vars= , output =); 
ods select none;
ods output clusterquality=summary
           rsquare=clusters;

proc varclus data=&input maxeigen=.7 short hi;
   var &vars;
run;
ods select all;

data _null_;
set summary;
call symput('nvar',compress(NumberOfClusters));
run;

data selvars;
set clusters (where = (NumberOfClusters=&nvar));
keep Cluster Variable RSquareRatio;
run;

data cv / view=cv;
retain dummy 1;
set selvars;
keep dummy cluster;
run;

data filled;
update cv(obs=0) cv;
by dummy;
set selvars(drop=cluster);
output;
drop dummy;
run;

proc sort data = filled;
by cluster RSquareRatio;
run;

data &output;
set filled (rename = (variable = Best_Variables));
if first.cluster then output;
by cluster;
run;

symbol v=square color=black i=join;
proc gplot data=summary;
 plot propvarexplained*numberofclusters;
run;
quit;

%mend;

%varsel(input= cluster, vars= _all_ , output = SOCO_SOU.VARClustering1);


%let ds2 = SOCO_SOU.eq102014_24monthdata;

Data cluster  (drop= ScoreValue_41_2014 BADCredit);
set &ds2;
run;


%macro varsel(input=, vars= , output =); 
ods select none;
ods output clusterquality=summary
           rsquare=clusters;

proc varclus data=&input maxeigen=.7 short hi;
   var &vars;
run;
ods select all;

data _null_;
set summary;
call symput('nvar',compress(NumberOfClusters));
run;

data selvars;
set clusters (where = (NumberOfClusters=&nvar));
keep Cluster Variable RSquareRatio;
run;

data cv / view=cv;
retain dummy 1;
set selvars;
keep dummy cluster;
run;

data filled;
update cv(obs=0) cv;
by dummy;
set selvars(drop=cluster);
output;
drop dummy;
run;

proc sort data = filled;
by cluster RSquareRatio;
run;

data &output;
set filled (rename = (variable = Best_Variables));
if first.cluster then output;
by cluster;
run;

symbol v=square color=black i=join;
proc gplot data=summary;
 plot propvarexplained*numberofclusters;
run;
quit;

%mend;

%varsel(input= cluster, vars= _all_ , output = SOCO_SOU.VARClustering24);

%let ds2 = SOCO_SOU.eq102014_3monthdata;

Data cluster  (drop= ScoreValue_41_2014 BADCredit);
set &ds2;
run;


%macro varsel(input=, vars= , output =); 
ods select none;
ods output clusterquality=summary
           rsquare=clusters;

proc varclus data=&input maxeigen=.7 short hi;
   var &vars;
run;
ods select all;

data _null_;
set summary;
call symput('nvar',compress(NumberOfClusters));
run;

data selvars;
set clusters (where = (NumberOfClusters=&nvar));
keep Cluster Variable RSquareRatio;
run;

data cv / view=cv;
retain dummy 1;
set selvars;
keep dummy cluster;
run;

data filled;
update cv(obs=0) cv;
by dummy;
set selvars(drop=cluster);
output;
drop dummy;
run;

proc sort data = filled;
by cluster RSquareRatio;
run;

data &output;
set filled (rename = (variable = Best_Variables));
if first.cluster then output;
by cluster;
run;

symbol v=square color=black i=join;
proc gplot data=summary;
 plot propvarexplained*numberofclusters;
run;
quit;

%mend;

%varsel(input= cluster, vars= _all_ , output = SOCO_SOU.VARClustering3);

proc contents data=SOCO_SOU.eq102014_scorechar;
run;
/*4693371 observations and 41 variables*/
data SOCO_SOU.eq102014_Merge3M;
merge SOCO_SOU.eq102014_3monthdata SOCO_SOU.eq102014_scorechar;
run;
/*4693371 observations and 46 variables*/
data SOCO_SOU.eq102014_Merge12M;
merge SOCO_SOU.eq102014_12monthdata SOCO_SOU.eq102014_scorechar;
run;
/*4693371 observations and 67 variables*/
data SOCO_SOU.eq102014_Merge24M;
merge SOCO_SOU.eq102014_24monthdata SOCO_SOU.eq102014_scorechar;
run;

proc contents data=soco_sou.eq102014_scorechar;
run;

proc contents data=soco_sou.eq102014_24monthdata ;
run;

%let var=NoNFA3mon
totLAllJud
TotUtiNFA3mon
pctNFPDAmtst3mon
LienJudInd
Industry
YearStarted
totLAllLiens
NoEmployeeRange
pctNFChgAccAcc3mon
TotUtiNFA
Region
;

/* 12 numeric variables out of 41 */
Data SOCO_SOU.VARCLUSDATA3M(drop=ZipCode EFXID MPID SiteEFXID);
set SOCO_SOU.eq102014_Merge3M(keep=&var _char_ BADCredit);
run;


%let var1=pctNFPDAmt12mon
NoEmployeeRange
TotUtiNFA3mon
Region
totC3NFPDAmt24mon
totNFA2CPD24mon
totLAllJud
TotUtiNFA
totC4NFPDAmt24mon
totNFA3CPD24mon
totNFA1CPD24mon
LienJudInd
pctNFChgAccAcc24mon
NoNFA12mon
totNFA3CPDC24mon
Industry
pctNFChgAccAcc3mon
totNFPDAmt24mon
totLAllLiens
YearStarted
;


/* 20 numeric variables out of 67 */
Data SOCO_SOU.VARCLUSDATA24M(drop=ZipCode EFXID MPID SiteEFXID);
set SOCO_SOU.eq102014_Merge24M(keep=&var1 _char_ BADCredit);
run;


proc contents data=soco_sou.eq102014_merge12m;
run;


%let var3=NoNFA12mon
TotUtiNFA12mon
pctNFC4PDAmt12mon
pctNFChgAccAcc12mon
pctNFPDAmt12mon
pctSasNFA12mon
pctNFPDAmtst3mon
Region
totLAllJud
TotUtiNFA
LienJudInd
Industry
YearStarted
totLAllLiens
pctNFChgAccAcc3mon
NoEmployeeRange
NoNFA3mon
TotUtiNFA3mon
;


Data SOCO_SOU.VARCLUSDATA12M(drop=ZipCode EFXID MPID SiteEFXID);
set SOCO_SOU.eq102014_Merge12M(keep=&var3 _char_ BADCredit);
run;
