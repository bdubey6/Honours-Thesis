Bhuvan, you will need all of the files. The majority of them are needed during the processing of the data. The three main scripts that you will use are the following:
1. biofeedback_posture_dubey_exp1_processing_pm
2. biofeedback_posture_dubey_exp1_batch_processing_pm (this one is not as important since you can just use 1.)
3. biofeedback_posture_dubey_exp1_main_analysis_pm

2025-03-08:
Adjust the directories used in biofeedback_posture_dubey_exp1_processing_pm: see lines 18 and 375

Adjust the direcoty used in biofeedback_posture_dubey_exp1_main_analysis_pm: see line 16

In the main analysis (biofeedback_posture_dubey_exp1_main_analysis_pm), you also need to add the time stamps at the end of each experimental phase: see lines 39 to 43. 

If the label/name of the protocols was changed at, this will need be adjusted/added to lines 25 to 148. 

Note, it is possible that the script biofeedback_posture_dubey_exp1_main_analysis_pm has to be tweaked a bit in case that a participant was not able to complete all conditions (e.g., 16x is missing).