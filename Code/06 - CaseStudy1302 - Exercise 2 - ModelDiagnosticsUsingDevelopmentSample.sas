/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP 6: Model Diagnostics using Development Dataset
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';



/** Finding out the No of Good/Bad Respondents in the Development Sample */
PROC FREQ
	DATA=CS13EX2.DEVELOPMENT_SAMPLE;
	TABLE Good;
	TITLE1 "Finding out the No of Good/Bad Respondents in the Development Sample";
RUN;

/** Printing out the Classification Table **/
PROC PRINT
	DATA=CS13EX2.CTABLE_DATA;
	TITLE1 "Classification Table";
RUN;


/** Exporting the Classification Table **/
PROC EXPORT 
	DATA = CS13EX2.CTABLE_DATA 
	OUTFILE = "/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/CSVs/CaseStudy1302_Exercise2_ClassificationTable.CSV"
	DBMS = CSV 
	REPLACE;
RUN;


/** Plotting the ROC Curve **/
PROC PLOT 
	DATA=CS13EX2.ROC_DATA;
	PLOT _SENSIT_ * _1MSPEC_;
RUN;

%LET Cut_Off_Ratio = 0.5;


/** Marking the Predicted Good Records based on &Cut_Off_Ratio cutoff */
DATA CS13EX2.DEVELOPMENT_SAMPLE_PRED_CLEAN;
	SET CS13EX2.DEVELOPMENT_SAMPLE_PRED (KEEP=Good Predicted_Good_Probability );
	IF Predicted_Good_Probability < &Cut_Off_Ratio
		THEN Predicted_Good = 2;
		ELSE Predicted_Good = 1;
	IF Good = 1 AND Predicted_Good = 1
		THEN Good_And_Predicted_Good = 1;
		ELSE Good_And_Predicted_Good = 0;
RUN;
	

/** Creating the Gains Chart Data - Ranking the Probability into 10 Groups - Descending Order **/
PROC RANK
	DATA=CS13EX2.DEVELOPMENT_SAMPLE_PRED_CLEAN
	OUT=CS13EX2.DEVELOPMENT_DECILES
	GROUPS=10
	DESCENDING;
	VAR Predicted_Good_Probability;
	RANKS Decile;
RUN;

/** Sorting the Deciles for PROC MEANS Calculation **/
PROC SORT 
	DATA=CS13EX2.DEVELOPMENT_DECILES;
	BY Decile;	
RUN;


/** Finding out the 
- Sum of Actual Good
- Predicted Good Percentation which is the average Score
- No of Respondents per decile
**/
PROC MEANS NOPRINT
	DATA=CS13EX2.DEVELOPMENT_DECILES;
	BY Decile;
	OUTPUT
		OUT=CS13EX2.DEVELOPMENT_GAIN_CHART
		SUM(Good) = Good
		SUM(Good_And_Predicted_Good) = Good_And_Predicted_Good
		N(Good) = No_Of_Respondents
		SUM(Predicted_Good) = Predicted_Good;
RUN;


/** Calculating the Lift on Development Dataset  **/
DATA CS13EX2.DEVELOPMENT_LIFT;
	SET CS13EX2.DEVELOPMENT_GAIN_CHART (DROP=_TYPE_ _FREQ_);
	/** Total ( Good / Total no of respondents) will give the expected 
	probabilty of getting a good from a random Sample) */
	Expected_Good = 0.7132 * No_Of_Respondents; 
	
	LIFT = 
		( Good_And_Predicted_Good * No_Of_Respondents )  / 
		( Expected_Good * Predicted_Good ); 
	
	/** to calculate Cumulative Numbers **/
	Expected_Good_Lag1 = LAG1(Expected_Good);
	Expected_Good_Lag2 = LAG2(Expected_Good);
	Expected_Good_Lag3 = LAG3(Expected_Good);
	Expected_Good_Lag4 = LAG4(Expected_Good);
	Expected_Good_Lag5 = LAG5(Expected_Good);
	Expected_Good_Lag6 = LAG6(Expected_Good);
	Expected_Good_Lag7 = LAG7(Expected_Good);
	Expected_Good_Lag8 = LAG8(Expected_Good);
	Expected_Good_Lag9 = LAG9(Expected_Good);
	
	Good_And_Predicted_Good_Lag1 = LAG1(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag2 = LAG2(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag3 = LAG3(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag4 = LAG4(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag5 = LAG5(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag6 = LAG6(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag7 = LAG7(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag8 = LAG8(Good_And_Predicted_Good);
	Good_And_Predicted_Good_Lag9 = LAG9(Good_And_Predicted_Good);
	
	Cumulative_Expected_Good = SUM(OF Expected_Good_Lag1-Expected_Good_Lag9 Expected_Good);
	Cumulative_Predicted_Good =  SUM(OF Good_And_Predicted_Good_Lag1-Good_And_Predicted_Good_Lag9 Good_And_Predicted_Good);
	
	/** The Model has 490 Good in Total */
	Cumulative_Expected_Percent = Cumulative_Expected_Good / 490 * 100;
	Cumulative_Predicted_Percent = Cumulative_Predicted_Good / 490 * 100;
RUN;

DATA CS13EX2.DEVELOPMENT_LIFT_CLEAN;
	RETAIN
		Good 
		Good_And_Predicted_Good
		Predicted_Good
		Expected_Good
		LIFT
		Cumulative_Predicted_Good
		Cumulative_Predicted_Percent
		Cumulative_Expected_Good
		Cumulative_Expected_Percent
		Decile;
	SET CS13EX2.DEVELOPMENT_LIFT 
		(KEEP=
			Good 
			Good_And_Predicted_Good
			Predicted_Good
			Expected_Good
			LIFT
			Cumulative_Predicted_Percent
			Cumulative_Expected_Percent
			Decile );
RUN;



/** Plotting the Lift Curve **/
PROC PLOT 
	DATA=CS13EX2.DEVELOPMENT_LIFT_CLEAN;
	PLOT 
		Cumulative_Predicted_Percent * Cumulative_Expected_Percent
		Cumulative_Expected_Percent * Cumulative_Expected_Percent;
	TITLE1 "[DEVELOPMENT DATASET] Plotting the Gains Chart";
	TITLE2 "Cut Off Ratio=";
	TITLE3 &Cut_Off_Ratio;
RUN;


PROC PRINT
	DATA=CS13EX2.DEVELOPMENT_LIFT_CLEAN;
	SUM 
		Good 
		Good_And_Predicted_Good
		Predicted_Good
		Expected_Good;
	TITLE1 "[DEVELOPMENT DATASET] Printing out the Gains Chart Items";
	TITLE2 "Cut Off Ratio=";
	TITLE3 &Cut_Off_Ratio;
	
	
/** Exporting the Gains Chart Items **/
PROC EXPORT 
	DATA = CS13EX2.DEVELOPMENT_LIFT_CLEAN 
	OUTFILE = "/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/CSVs/CaseStudy1302_Exercise2_GainsChartItems_Development.CSV"
	DBMS = CSV 
	REPLACE;
RUN;








