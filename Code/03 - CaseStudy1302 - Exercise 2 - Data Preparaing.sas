/*********************************
Case Study - Class 13 - Exercise 2
Credit Rating
STEP 3: Data Preparation
*****************************************/


LIBNAME CS13EX2 '/folders/myshortcuts/myfolder/SSCode/JigsawCaseStudy13Exercise2/Datasets';

/** Creating Dummy Variables **/
DATA CS13EX2.CREDIT_RATING_DUMMY_VARIABLES;
	SET CS13EX2.CREDIT_RATING (RENAME=(GOOD_BAD=Good));
	
	/** Creating Dummy Variables for Check_Account_Status **/
	IF Check_Account_Status = "A11" THEN Check_Account_Status_A11 = 1;
	IF Check_Account_Status = "A12" THEN Check_Account_Status_A12 = 1;
	IF Check_Account_Status = "A13" THEN Check_Account_Status_A13 = 1;
	/** Making Dummy Variables that are empty then make it 0; **/
	IF Check_Account_Status_A11 = . THEN Check_Account_Status_A11 = 0;
	IF Check_Account_Status_A12 = . THEN Check_Account_Status_A12 = 0;
	IF Check_Account_Status_A13 = . THEN Check_Account_Status_A13 = 0;
	
	/** CreditHistory Dummy Variables **/
	IF CreditHistory = "A30" THEN CreditHistory_A30 = 1;
	IF CreditHistory = "A31" THEN CreditHistory_A31 = 1;
	IF CreditHistory = "A33" THEN CreditHistory_A33 = 1;
	IF CreditHistory = "A34" THEN CreditHistory_A34 = 1;
	IF CreditHistory_A30 = . THEN CreditHistory_A30 = 0;
	IF CreditHistory_A31 = . THEN CreditHistory_A31 = 0;
	IF CreditHistory_A33 = . THEN CreditHistory_A33 = 0;
	IF CreditHistory_A34 = . THEN CreditHistory_A34 = 0;
	
	
	/** Purpose Dummy Variables  **/
	IF Purpose = "A40" THEN Purpose_A40 = 1;
	IF Purpose = "A41" THEN Purpose_A41 = 1;
	IF Purpose = "A42" THEN Purpose_A42 = 1;
	IF Purpose = "A44" THEN Purpose_A44 = 1;
	IF Purpose = "A45" THEN Purpose_A45 = 1;
	IF Purpose = "A46" THEN Purpose_A46 = 1;
	IF Purpose = "A48" THEN Purpose_A48 = 1;
	IF Purpose = "A49" THEN Purpose_A49 = 1;
	IF Purpose_A40 = . THEN Purpose_A40 = 0;
	IF Purpose_A41 = . THEN Purpose_A41 = 0;
	IF Purpose_A42 = . THEN Purpose_A42 = 0;
	IF Purpose_A44 = . THEN Purpose_A44 = 0;
	IF Purpose_A45 = . THEN Purpose_A45 = 0;
	IF Purpose_A46 = . THEN Purpose_A46 = 0;
	IF Purpose_A48 = . THEN Purpose_A48 = 0;
	IF Purpose_A49 = . THEN Purpose_A49 = 0;
	IF Purpose_A44 = 1 OR 
		Purpose_A49 = 1 OR
		Purpose_A42 = 1
			THEN
				Purpose_42_44_49 = 1;
			ELSE
				Purpose_42_44_49 = 0;
	
	/** SavingsAcc Dummy Variables **/
	IF SavingsAcc = "A62" THEN SavingsAcc_A62 = 1;
	IF SavingsAcc = "A63" THEN SavingsAcc_A63 = 1;
	IF SavingsAcc = "A64" THEN SavingsAcc_A64 = 1;
	IF SavingsAcc = "A65" THEN SavingsAcc_A65 = 1;
	IF SavingsAcc_A62 = . THEN SavingsAcc_A62 = 0;
	IF SavingsAcc_A63 = . THEN SavingsAcc_A63 = 0;
	IF SavingsAcc_A64 = . THEN SavingsAcc_A64 = 0;
	IF SavingsAcc_A65 = . THEN SavingsAcc_A65 = 0;
	
	/** EmployTenure Dummy Variables **/
	IF EmployTenure = "A71" THEN EmployTenure_A71 = 1;
	IF EmployTenure = "A72" THEN EmployTenure_A72 = 1;
	IF EmployTenure = "A74" THEN EmployTenure_A74 = 1;
	IF EmployTenure = "A75" THEN EmployTenure_A75 = 1;
	IF EmployTenure_A71 = . THEN EmployTenure_A71 = 0;
	IF EmployTenure_A72 = . THEN EmployTenure_A72 = 0;
	IF EmployTenure_A74 = . THEN EmployTenure_A74 = 0;
	IF EmployTenure_A75 = . THEN EmployTenure_A75 = 0;
	
	
	/** Status Dummy Variables **/
	IF Status = "A91" THEN Status_A91 = 1;
	IF Status = "A92" THEN Status_A92 = 1;
	IF Status = "A94" THEN Status_A94 = 1;
	IF Status_A91 = . THEN Status_A91 = 0;
	IF Status_A92 = . THEN Status_A92 = 0;
	IF Status_A94 = . THEN Status_A94 = 0;
	
	/** Debtors Dummy Variables **/
	IF Debtors = "A102" THEN Debtors_A102 = 1;
	IF Debtors = "A103" THEN Debtors_A103 = 1;
	IF Debtors_A102 = . THEN Debtors_A102 = 0;
	IF Debtors_A103 = . THEN Debtors_A103 = 0;
	
	
	/** Propert Dummy Variables **/
	IF Propert = "A121" THEN Propert_A121 = 1;
	IF Propert = "A122" THEN Propert_A122 = 1;
	IF Propert = "A124" THEN Propert_A124 = 1;
	IF Propert_A121 = . THEN Propert_A121 = 0;
	IF Propert_A122 = . THEN Propert_A122 = 0;
	IF Propert_A124 = . THEN Propert_A124 = 0;
	
	/** Plans Dummy Variables **/
	IF Plans = "A141" THEN Plans_A141 = 1;
	IF Plans = "A142" THEN Plans_A142 = 1;
	IF Plans_A141 = . THEN Plans_A141 = 0;
	IF Plans_A142 = . THEN Plans_A142 = 0;
	
	/** Plans Dummy Variables **/
	IF Hous = "A151" THEN Hous_A151 = 1;
	IF Hous = "A153" THEN Hous_A153 = 1;
	IF Hous_A151 = . THEN Hous_A151 = 0;
	IF Hous_A153 = . THEN Hous_A153 = 0;
	
	/** Job Dummy Variables **/
	IF Job = "A171" THEN Job_A171 = 1;
	IF Job = "A172" THEN Job_A172 = 1;
	IF Job = "A174" THEN Job_A174 = 1;
	IF Job_A171 = . THEN Job_A171 = 0;
	IF Job_A172 = . THEN Job_A172 = 0;
	IF Job_A174 = . THEN Job_A174 = 0;
	
	/** Tel Dummy Variables **/
	IF Tel = "A191" THEN Tel_A191 = 1;
	IF Tel_A191 = . THEN Tel_A191 = 0;
	
	/** Foreign Dummy Variables **/
	IF Foreign = "A202" THEN Foreign_A202 = 1;
	IF Foreign_A202 = . THEN Foreign_A202 = 0;
	
RUN;


