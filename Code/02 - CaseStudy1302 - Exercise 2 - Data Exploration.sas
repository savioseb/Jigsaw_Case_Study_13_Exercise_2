/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP 2 : Data Exploration
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';


/** Running PROC FREQ to understand the Data **/
PROC FREQ
	DATA=CS13EX2.CREDIT_RATING;
	TITLE1 "Running PROC FREQ to understand the Data";
RUN;


/** Running Proc Means on the dataset to understand the data */
PROC MEANS N NMISS
	DATA=CS13EX2.CREDIT_RATING;
	TITLE1 "Running Proc Means on the dataset to understand the data";
	TITLE2 "There are no missing Variables";
RUN;
