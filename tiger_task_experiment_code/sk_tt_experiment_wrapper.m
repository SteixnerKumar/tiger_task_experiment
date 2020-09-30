function [out]=sk_tt_experiment_wrapper(ttsk)
% Tiger task experimental setup optimized for lab 218 (basically for usage on a single PC)
%
% USAGE:
% _____________________________________________________
% sk_tt_experiment_wrapper_08_pilot(sub,type,session);
% _____________________________________________________
%
% INPUT:
% sub: the participant-id that is agreed upon to use
% type: 'single', 'enemy', 'friend'
% session: the session number to be recorded
% 
% _____________________________________________________
%
% warning
% 1.) make sure your disply monitor is set to be the main display
% 2.) make sure that the display is application controlled and not (default) application override
%
% This display uses the Psychtoolbox
%
% FOR numbering participoants
% 2->single, 4->enemy, 5->friend
% samelast three numbers (xxx) for single and multi versions
% for training (20xxx)
% For single participants ->    30xxx (001 to 999) (000 is for the EEG pilot)
% % For enemy participants ->     auto (gap of 200)
% % For friend participants ->    auto (gap of 200)
%
% author: Saurabh Kumar (s.kumar@uke.de)
%

% dbstop if error

sub1 = ttsk.sub1;
sub2 = ttsk.sub2;
type = ttsk.type;
session = ttsk.session;
handlesArray = ttsk.handlesArray;
% single_player_side = ttsk.single_player_side;
ttsk=[];
%% Important parameters to be checked before every run !!!
%-------------------------------------------------------------------------------------------------------------------
ttsk.save_files = 1; % 1;  % 1 to save, 0 to not save
ttsk.num_trials = 10; % 10;
%ttsk.session_number = 1; % 1;
ttsk.session_number = session;

if strcmp(type,'single')
    ttsk.tt_version = 'single';
    ttsk.participant_number_A = sub1;
    ttsk.participant_number_B = sub2;
    ttsk.data_folder_name = 'data_storage_behaviour';
    potential_file_name = 'single';
elseif strcmp(type,'enemy')
    ttsk.tt_version = 'multienemy';
    ttsk.participant_number_A = sub1;% + 2000;
    ttsk.participant_number_B = sub2;% + 2000;
    ttsk.data_folder_name = 'data_storage_behaviour';
    potential_file_name = 'multi_enemy';
elseif strcmp(type,'friend')
    ttsk.tt_version = 'multifriend';
    ttsk.participant_number_A = sub1;% + 3000;
    ttsk.participant_number_B = sub2;% + 3000;
    ttsk.data_folder_name = 'data_storage_behaviour';
    potential_file_name = 'multi_friend';
else
%     error('Please check the input arguments !!!');
    msgbox('Please check the input arguments !!!', 'Error','error');
end

%ttsk.tt_version = 'multifriend'; % 'single', 'multienemy', 'multifriend'  
%ttsk.participant_number_A = 13000; % 101; (only numbers)
%ttsk.participant_number_B = 00000; % 201; % for single this parameter is irrelevent (00000)

% ttsk.data_folder_name = 'data_storage_pilot'; % 'data_storage_pilot_single/multienemy/multiffriend_';

%------------------------------------------------------------------------------------------------------------------
%% check for the files to prevent overwriting
potential_file_name = strcat(pwd,'\',ttsk.data_folder_name,'\tt_',potential_file_name,'_sub',num2str(ttsk.participant_number_A),'_session',num2str(ttsk.session_number),'.mat');
if exist(potential_file_name,'file') % checks for file if it exists
    %    error('Please check the input parameters. The FILE already EXISTS !');
    set(handlesArray, 'Enable', 'off');
    uiwait(msgbox('Please check the input parameters. The FILE already EXISTS !', 'Error','error'));
    set(handlesArray, 'Enable', 'on');
    error('Please check the input parameters. The FILE already EXISTS !');
end
%%
ttsk.trig.wanted = 1; % '1' for yes, '0' for no
ttsk.resting_state = 1; % '1' for yes, '0' for no
ttsk.delay_test = 1; % '1' for yes, '0' for no

% ttsk.image_folder = 'C:\matlab\work\tiger_task_display\images\'; % 'C:\matlab\work\tiger_task_display\images\';
ttsk.image_folder = strcat(pwd,'\images\');

% timing section
ttsk.wait_time = 1; % 1; % time in sesonds (between different slides)
ttsk.fluct_ms = 600; % time in ms (the random fluctuation) between slides to no expectation from participant
ttsk.time.prediction = 5; %5; % time in sesonds % for single this parameter is irrelevent
ttsk.time.choice = 5; %5; % time in sesonds
ttsk.time.result_partner = 5; %3; % time in sesonds % for single this parameter is irrelevent
ttsk.time.result_your = 5; %3; % time in sesonds
ttsk.rs_time = 2; % 2; % time in sesonds to display the instruction resting state
ttsk.rs_duration = 30; % 30; % time in seconds for the duration of eyes closd/open
% ttsk.dt_time = 2; % 2; % time in sesonds to display the instruction for screen delay test
% ttsk.dt_time_m_duration = 0.3; % time in sesonds for the changing color scrrens
ttsk.scr_ratio_white = 7/8; % screen at the bottom to turn white for getting screen delay (through diode)

%% define the experiment parameters

ttsk.single = 2; %2; % for multi this parameter is irrelevent
ttsk.enemy = 4; %4; % for single this parameter is irrelevent
ttsk.friend = 5; %5; % for single this parameter is irrelevent

% basics

% numerical values of actions
ttsk.side.left = 3; %3; % open left
ttsk.side.right = 1; %1; % open right
ttsk.side.center = 2; %2; % listen

% reward section
% this these numbers are overwritten by the modified matrix in the  'sk_tt_experiment' function
% In case you want to use the original matrix,
% then please uncomment the relevent reward structure section in the 'sk_tt_experiment' function
ttsk.reward.L = -1; %-1; % listen
ttsk.reward.win = 10; %10; % win
ttsk.reward.loose = -100; %-100; % loose

% probabilities section
ttsk.prob.growl_correctness = 0.7; %0.7;
ttsk.prob.creek_side_correctness = 0.8; %0.8; % for single this parameter is irrelevent

% dot section
ttsk.dot.size = 15; % = 15;
ttsk.dot.colour_default = [1 1 1]; % = [1 1 1]; % white
ttsk.dot.colour_your = [1 1 0.2]; % = [1 1 0.2]; % yellow
ttsk.dot.colour_partner = [0 0.5020 1]; % = [0 0.5020 1]; % blue

% text section
ttsk.display.font_name = 'Ariel'; %'Ariel';
ttsk.display.font_size = 40; %40;

% trigger section
ttsk.trig.port_no = 'COM3'; % port number, chek four your system
ttsk.trig.baudrate = 115200; %BaudRate (check for your system)
%
% Trigger definitions
%
ttsk.trig.start_questions = 40; % start of the screen_delay_test
ttsk.trig.end_questions = 41; % end of the screen_delay_test
ttsk.trig.start_dt_test = 30; % start of the screen_delay_test
ttsk.trig.end_dt_test = 31; % end of the screen_delay_test
ttsk.trig.start_eyes_closed = 10; % start of the eyes closed
ttsk.trig.end_eyes_closed = 11; % end of the eyes closed
ttsk.trig.start_eyes_open = 20; % start of the eyes open
ttsk.trig.end_eyes_open = 21; % end of the eyes open
ttsk.trig.start_experiment = 100; % start of the experiment
ttsk.trig.end_experiment = 101; % end of the experiment
ttsk.trig.start_sequence = 200; % start the sequence from prediction to own evidence
ttsk.trig.end_sequence = 201; % end the sequence from prediction to own evidence
ttsk.trig.start_prediction = 210; % start of the prediction slide
ttsk.trig.response_prediction_A = 214; % start of the prediction slide
ttsk.trig.response_prediction_B = 215; % start of the prediction slide
ttsk.trig.end_prediction = 211; % end of the prediction slide
ttsk.trig.start_choice = 220; % start of the own choice slide
ttsk.trig.response_choice_A = 224; % start of the own choice slide
ttsk.trig.response_choice_B = 225; % start of the own choice slide
ttsk.trig.end_choice = 221; % end of the other player choice slide
ttsk.trig.start_evidence_other_player = 230; % start of the evidence of other player slide
ttsk.trig.end_evidence_other_player = 231; % end of the evidence of other player slide
ttsk.trig.start_evidence_own = 240; % start of the own evidence slide
ttsk.trig.end_evidence_own = 241; % end of the own evidence slide

% t_start = 100;
% t_end = 110;
% t_eyes_closed = 250;
% t_eyes_open = 200;
%%%%%%%%%%%%%%%%%%%%%%%
% opening the port
% if ttsk.trig.wanted
%     handle = IOPort('OpenSerialPort', ttsk.trig.port_no,sprintf('BaudRate=%d',ttsk.trig.baudrate));
%     IOPort('Write', handle, uint8(ttsk.trig.start_experiment));
% end
%%%%%%%%%%%%%%%%%%%%%%%%
% if ttsk.trig.wanted
%         IOPort('Write', handle, uint8(ttsk.trig.));
% end
%%%%%%%%%%%%%%%%%%%%%%%
% if ttsk.trig.wanted
%        IOPort('CloseAll');
% end 

%% the experiment function using the psychtoolbox
% ttsk.single_player_side = single_player_side; % 'L' or 'R'
[out]=sk_tt_experiment(ttsk);

%% incase you want screenshots (example)
% % % % % imwrite(out.imageArray, 'test.jpg')
% % % % imwrite(out.imageArray_predict, 'predict.jpg')
% % % % imwrite(out.imageArray_action, 'action.jpg')
% % % % imwrite(out.imageArray_result_partner, 'result_partner.jpg')
% % % % imwrite(out.imageArray_result_your, 'result_your.jpg')
%% end message after the task is over
fprintf('\n\n\n\n');
fprintf('--------------------------------------------------------------\n');
fprintf('---------------------- WELL DONE! -------------------------\n');
fprintf('--------------------------------------------------------------\n');
fprintf('---- Please wait now ----------------------------------------\n');
fprintf('--------------------------------------------------------------\n');
fprintf('\n\n');

%%
end