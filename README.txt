README.txt

DATE OF SUBMISSION: APRIL 11, 2016

HOMEWORK 03, ROBOTICS.

GROUP #3: ALEXANDRA SERRALTA (AVS327), YATING ZHAN (YZ1339), RICARDO SPINOLA (RS3826)


TO RUN OUR CODE:

QUESTION 1A:
	kf_setup —- to setup the ppps.
	kf_test(ppp,i) where i is the index of ppp you want to run —— this command will calculate the actual and observed states as well as call kalman filter and produce figure plots
	kf_filter(ppp) —— this command will use kf_filter on the chosen ppp. Note that this will only produce XH (Kalman states) and PH (Covariance) for ppp. If you want to calculate other properties, you should run kf_test instead. Also note that in order for this function to run properly, you need to have all the observation states and actual states calculated and stored in ZZ and XX.
	Figures in ppp(1) folder.
QUESTION 1B:
	Figures in ppp(2) folder. 
	I am using a larger decay rate (0.8) and a larger initial velocity (20). Also use larger N (40) with a false XH(:, 1) to prove that kalman filter will recover from the initial false state. Notice that for figure_C, the kalman filter states converge with the actual states after time 9. 
	
QUESTION 1C
	Figures in ppp(3) folder. 
	Everything same with ppp(2) except q and qh to prove that kaman filter takes longer to converge to correct state with larger process noise. Notice that for figure_C, the kalman filter states converge with the actual states after time 15, which is longer than time needed in ppp(2). 

QUESTION 2A
QUESTION 2B
QUESTION 2C

FILES INCLUDED:



################# COLLABORATION STATEMENT  #################

“This is he collaborative work of all the named group members. 

Electronically signed:

Ricardo Spinola
Yating Zhan
Alexandra Serralta

################### SOURCE STATEMENT ########################

OTHER THAN THE MATLAB DOCUMENTATION AND THE CLASS NOTES, NO OTHER 
SOURCES HAVE BEEN CONSULTED.

##############################################################





