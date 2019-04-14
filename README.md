# MARGIN-Simulink

This is an implementation of the MARGIN using MATLAB SimEvents. 


Requirements 
-	MATLAB Version 2010a or 2011b 
-	MATLAB Simulink toolbox 

Run Instructions 

To select one of the decision-making approaches:
1.	Open the model GTSim_RQ.mdl 
2.	In the simulation model GTSim_RQ find “Interpreted MATLAB Function” and open it 
3.	Change the name of the file based on the decision-making approach to:
     -	MARGIN(u) for the MARGIN approach
     -	Random(u) for the Random approach 
     -	ZSGame(u) for the Zero-Sum Game approach 
4.	Save and close the model GTSim_RQ.mdl

Now, based on the scenario run either of the following 4 options:
1.	For DoS Scenario: run MATLAB file  run_Main_S1.m 
2.	For Insider Scenario: run MATLAB file run_Main_S2.m 
3.	For DoS+Insider Scenario: run MATLAB file  run_Main_S3.m 
4.	For DoS+Insider/Sequential Scenario: run MATLAB file  run_Main_S4.m 


For any questions regarding running the experiments please feel free to contact: mahsa.emamitaba@uwaterloo.ca




