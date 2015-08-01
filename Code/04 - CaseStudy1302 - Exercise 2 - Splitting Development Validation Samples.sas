/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP 4: Splitting Development and Validation Sample Datasets
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';

/** Splitting the Data into Development and Validation Samples **/
DATA CS13EX2.DEVELOPMENT_SAMPLE CS13EX2.VALIDATION_SAMPLE ;
	SET CS13EX2.CREDIT_RATING_DUMMY_VARIABLES;
	IF RANUNI(100) < 0.7 
		THEN 
			OUTPUT CS13EX2.DEVELOPMENT_SAMPLE; 
		ELSE 
			OUTPUT CS13EX2.VALIDATION_SAMPLE;
RUN;


/** Running Proc Means on the dataset to understand the data */
PROC MEANS N NMISS
	DATA=CS13EX2.DEVELOPMENT_SAMPLE;
	TITLE1 "Running Proc Means on the dataset to understand the data";
	TITLE2 "There are no missing Variables";
RUN;

