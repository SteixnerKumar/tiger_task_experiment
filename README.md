# Tiger task experiment
This is the experimental setup of the tiger task for both the single-agent (TT) and the multiagent (competitive and cooperative) (ITT) versions.

This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License (CC BY-NC 4.0)

# Contents
## [General idea](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#general-idea-1)
## [The default versions used for this codebase](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#the-default-versions-used-for-this-codebase-1)
## [Procedure](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#procedure-1)
## [Flow of code](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#flow-of-code-1)
## [Data structure](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#data-structure-1)
## [Published work](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#published-work-1)
## [Contact](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#contact-1)

# General idea
This is an experimental setup of the 'tiger task'.

The game is played always by a dyad (two participants) either independent of each other (TT) or with each other (ITT).
The experiment runs on a single computer ideally connected to two screens. These screens are partly covered so that the individual participants visually only access their part of the task.

###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# The default versions used for this codebase
--> MATLAB version and toolboxes versions 

+ MATLAB Version: 9.1.0.441655 (R2016b)

+ Operating System: Microsoft Windows 10 Pro Version 10.0 (Build 17134)

+ Java Version: Java 1.7.0_60-b19 with Oracle Corporation Java HotSpot(TM) 64-Bit Server VM mixed mode

+ Image Processing Toolbox                              Version 9.5         (R2016b)                

+ Signal Processing Toolbox                             Version 7.3         (R2016b)     

+ Psychtoolbox                                          Version 3.0.14      30 December
###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# Procedure
Shortcut: In the command windoe type 'tiger_task_experiment' to begin.

The default structure is as follows.
There is a folder named 'images', which has all the graphics required by the code. Missing any of this will most likely create an error. This folder is refered in the code as the current_working_directory/images, so as long as this folder exists, you are good to go. All the default location addresses can be modified if you wish manually in the wrapper ('sk_tt_experiment_wrapper.m') file.

The main function is 'tiger_task_experiment'; So to run the it you can simple type the function name in the comman window and it will load the gui (graphical user interface) with all the default settings.

On the gui, on the left side, one can choose the type of game to be played - TT ot ITT (competitive/cooperative).
Below this selection one can enter the participant id (in number format) as an identifier. By default the identifier of the second participant will be 200 added. This default setting can be modified if wished in the 'tiger_task_experiment.m' file. Its important to note the first participant should sit on the left side in the setup, and the second on the right side. This is because the behaviour of the participant will be recorded with their unique identifier, and it makes sense to know which participant will see which side of the screen. The assumption here is that the left sitting participant gets acess only to the left half of the screen and vice-versa. 
To start one has to also choose the session number which by default is from 1 to 6. The maximum number of sessions on the gui can be changed by manually changing the .fig file ('tiger_task_experiment.fig'). Then press the Begin button to start. If all the parameters are fine on the left side, then the experiment will start.

After all the sessions are recoded, on the gui, check the experiment over box and make sure the participant identifiers are correct with the correct version of the task selected. This is necessary to calculate the relative financial binus each participant will recieve based on their performance. The bonus is between 0 to 10 euros max, and only for the ITT, not TT. Press calculate and you will see the amount session wise (and a max of the sessions) in the white space below the button on the gui. Additionally, it will also be displayed on the matlab command window.

###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# Flow of code
In the command windoe type 'tiger_task_experiment' to begin.

Sequence: 'tiger_task_experiment.m' starts the gui 'tiger_task_experiment.fig'. Pressing the begin button on the gui takes the code into the wapper 'sk_tt_experiment_wrapper.m'. This is where, one can make all the easy changes in the code, including the number of trials, etc. Then the wrapper calls the function 'sk_tt_experiment.m', which is the heart of the entire setup. This function displays the task and records all the responses. Please be very careful changing anything inside this function as it can easily break the code. Additionally the function 'sk_tt_moneywon.m' called from the gui does the bonus calculation.

###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# Data structure
Data is saved in the folder 'data_storage_behaviour'. If this folder does not exist, its created on the fly. The default name of this folder can also be manually changed in the wrapper function.

The default two file names (for one run of the experiment) are :'tt_single/multifriend-enemy_identifier_session'. Basically from the filename one can get the version of the tiger task (TT or ITT (competitive/cooperative)), the participant identifier and the session number. This format of naming is used by the script that calculates the bonus for the participants.

Inside the saved file there are two structures: 'ttsk' and 'out'. The 'ttsk' structure containes all the settings of the tiger task used for the particular session. The 'out' structure contains the associated probilities in the tiger task, the definition of the columns of the data and the data matrix (the actual behavioral data).

Data Structure:

+ For single-agent version (TT) :

| column number: | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 | 11 | 12 | 13 |
| - | - | - | - | - | - | - | - | - | - | - | - | - | - |
|column definition: | sub_id  | setting | session  | trial_your | tiger_side  | growl_side | growl_correct | action_your | action_your_rt  | forced_action_listen | reward_your  | reward_relative_your | reward_cumulative_your |

+ For multiagent version (ITT competitive/cooperative):

| column number: | 01 | 02 | 03 | 04 | 05 | 06 | 07 | 08 | 09 | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 |
| - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - | - |
|column definition: | sub_id  | setting | session | trial_univ | trial_your | trial_partner | tiger_side | growl_side | growl_correct  | creek_side | creek_correct | action_your | action_your_rt  | prediction | prediction_rt | action_partner | action_partner_rt  | prediction_partner | prediction_partner_rt | forced_action_listen | forced_prediction_listen  | prediction_correct | reward_your  | reward_relative_your | reward_cumulative_your | reward_partner | reward_relative_partner | reward_cumulative_partner |

###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# Published work
This work is presented and published in various conferences.

Saurabh Kumar et al. “Modeling Cooperation and Competition in the Tiger Task”. In: (2019), pp. 638–641. doi:10.32470/ccn.2019.1057-0.

Saurabh Kumar et al. “Modeling cooperative and competitive decision-making in the Tiger Task”. In:4th Multi-disciplinary Conference on Reinforcement Learning and Decision Making (RLDM2019)(2019), p. 105.


###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)

# Contact
***author: Saurabh Steixner-Kumar***

***email: s.steixner-kumar@uke.de*** 

###### [Back to Contents](https://github.com/SteixnerKumar/tiger_task_experiment/blob/master/README.md#Contents)
