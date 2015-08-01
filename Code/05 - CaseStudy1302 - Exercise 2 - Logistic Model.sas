/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP 5: The Model
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';



/** Creating the Model **/
ODS OUTPUT CLASSIFICATION = CS13EX2.CTABLE_DATA;
PROC LOGISTIC 
	DATA=CS13EX2.DEVELOPMENT_SAMPLE 
	/*We want probabilities of good which is level 1. 
	Bad is level 2. so it is not DESCENDING */
	/* to allow plotting *
	PLOTS(MAXPOINTS=NONE) 
	/**/ 
	OUTEST=CS13EX2.LOG_MODEL; 
  	MODEL 
  		 Good =
  		 	Check_Account_Status_A11
			Check_Account_Status_A12
			Check_Account_Status_A13
			
			Duration
			
			CreditHistory_A30
			CreditHistory_A31
			CreditHistory_A33
			CreditHistory_A34
			
			Purpose_A40
			Purpose_A41
			Purpose_42_44_49
			/*
			Purpose_A42
			Purpose_A44
			Purpose_A49
			*/
			Purpose_A45
			Purpose_A46
			Purpose_A48
			
			
			Amount
			
			SavingsAcc_A62
			SavingsAcc_A63
			SavingsAcc_A64
			SavingsAcc_A65
			
			EmployTenure_A71
			EmployTenure_A72
			EmployTenure_A75
			EmployTenure_A74
			
			
			Rate
			
			Status_A91
			Status_A92
			Status_A94
			
			Debtors_A102
			Debtors_A103
			
			Age
			
			Plans_A141
			Plans_A142
			
			Hous_A151
			Hous_A153
			
			Foreign_A202
  		/ LACKFIT OUTROC=CS13EX2.ROC_DATA CTABLE;
  	OUTPUT 
  		OUT = CS13EX2.DEVELOPMENT_SAMPLE_PRED 
  		PREDICTED=Predicted_Good_Probability;
 
  	SCORE 
  		DATA=CS13EX2.VALIDATION_SAMPLE 
  		OUT=CS13EX2.VALIDATION_SAMPLE_PRED;
  	TITLE1 "Logistic Model Development using Development Dataset";
RUN;

