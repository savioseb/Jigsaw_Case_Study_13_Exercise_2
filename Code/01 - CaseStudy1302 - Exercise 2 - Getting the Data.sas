/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP1 : Getting the Data
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';

/** Importing the Dataset **/
PROC IMPORT
	Datafile='/folders/myshortcuts/myfolder/Foundation Exercises/Assignments/Class13 - Logistic Regression with SAS/GOODBAD.csv'
	DBMS=CSV
	REPLACE
	OUT=CS13EX2.CREDIT_RATING;
RUN;
