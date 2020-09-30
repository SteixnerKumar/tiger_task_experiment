function [out]=sk_tt_experiment(ttsk)
% Function for the Tiger-task, the dual EEG setup in
% lab-218 (it runs on a single computer)
%
% warning
% 1.) make sure your disply monitor is set to be the main display
% 2.) make sure that the display is application controlled and not (default) application override
%
% This display uses the Psychtoolbox
%
% _______________________________________________________________
% OUTPUT
% The function saves a .mat file as well as a .csv file for matlab and R
% related further analysis.
% out.definition :  describes the output function structure
% out.data : gives the data (see below)
% the output file structure:
% defined in the out.definition :
%       * for multi
%     [{'sub_id'}, {'setting'}, {'session'}, {'trial_univ'}, {'trial_your'}, {'trial_partner'}, ...
%     {'tiger_side'}, {'growl_side'}, {'growl_correct'}, {'creek_side'}, {'creek_correct'}, {'action_your'}, ...
%     {'action_your_rt'}, {'prediction'}, {'prediction_rt'}, {'action_partner'}, {'action_partner_rt'}, ...
%     {'prediction_partner'}, {'prediction_partner_rt'}, ...
%     {'forced_action_listen'}, {'forced_prediction_listen'}, {'prediction_correct'}, {'reward_your'}, ...
%     {'reward_relative_your'}, {'reward_cumulative_your'}, {'reward_partner'}, {'reward_relative_partner'}, ...
%     {'reward_cumulative_partner'}]
%       * for single
%     [{'sub_id'}, {'setting'}, {'session'}, {'trial_your'}, ...
%     {'tiger_side'}, {'growl_side'}, {'growl_correct'}, {'action_your'}, {'action_your_rt'}, ...
%     {'forced_action_listen'}, {'reward_your'},{'reward_relative_your'}, {'reward_cumulative_your'}];
% _______________________________________________________________
% INPUT
% * all the input parameters are in structure 'ttsk', eg: ttsk.save_files
% * the input parameters are defined. and an example what to put inside is
% also given after the '%' symbol:
%   ttsk.save_files;% 1;
%               '1' to save files in the specified folder '0' to not
%   ttsk.image_folder; % 'C:\matlab\work\tiger_task_display\images\';
%               the folder where the experiment images are (tiger, gold, door, reward)
%   ttsk.data_folder_name; % 'data_storage';
%               the name of the folder where the saved files will be stored (.mat, .csv)
%   ttsk.tt_version; % 'single', 'multienemy', 'multifriend'
%               the version of the tiger task
%   ttsk.resting_state; 0;
%               '1' to have it, '0' to not have it
%   ttsk.session_number; % 1;
%               the session number
%   ttsk.single_player_side; % 'L', 'R'
%               if single player, then play Left or the Right side
%   ttsk.participant_number_A; % 101;
%               the id number of the first participant
%               in single player this will be used
%   ttsk.participant_number_B; % 201;
%               the id number of the second participant
%               in single player omit this
%   ttsk.wait_time; % 1;
%               the wait time between the slides (where just center dots are visible)
%   ttsk.fluct_ms; % 600
%               The random fluctuation in ms (so that the participa nt has no expectation)
%   ttsk.num_trials; % 10;
%               the number of trials to be played
%   ttsk.trg_wanted; % 0;
%               if the trigger is wanted (currently not implemented)
%   ttsk.port_no; % 204;
%               only if the trigger is wanted
%   ttsk.side.left; %3;
%               the numerical value of the left
%   ttsk.side.right; %1;
%               the numerical value of the right
%   ttsk.side.center; %2;
%               the numerical value of the center/listen
%   ttsk.reward.L; %-1;
%               the numerical value of the reward to listen
%   ttsk.reward.win; %10;
%               the numerical value of the reward to get the gold
%   ttsk.reward.loose; %-100;
%               the numerical value of the reward to get the tiger
%   ttsk.prob.growl_correctness; %0.7;
%               the growl probability
%   ttsk.prob.creek_side_correctness; %0.8;
%               the creek probability (skip in the single player version)
%   ttsk.display.font_name; %'Ariel';
%               the font to be displyed in the text messages
%   ttsk.display.font_size; %40;
%               the font size of the textual messages
%   ttsk.time.prediction; %5;
%               time in seconds to predict action (skip in the single player version)
%   ttsk.time.choice; %5;
%               time in seconds to choose action
%   ttsk.time.result_partner; %3;
%               time in seconds to see the partner's action result (skip in the single player version)
%   ttsk.time.result_your; %3;
%               time in seconds to see your action result
%   ttsk.single; %2;
%               the numerical number for the single player version
%   ttsk.enemy; %4;
%               the numerical number for the multi player enemy version
%   ttsk.friend; %5;
%               the numerical number for the multi player friend version
%   ttsk.dot.colour_default; % = [1 1 1];
%               the center dots colour
%   ttsk.dot.size; % = 15;
%               the center dots size
%   ttsk.trig.__; % all the trigger values wanted
%
%
% *****************************
% -code creator : Saurabh Steixner-Kumar
% -contact info : s.steixner-kumar@uke.de
% *****************************
%
%

%%%%%%%%%%%%%%%%%%%%%%%%% removed functionality %%%%%%
% single_player_side = 'R';
% if strcmp(tt_version,'single') && strcmp(single_player_side,'R')
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% input parameters from the wrapper mainly
get_screenshot = 0; % set to 1 if screen shots wanted at different screens (for debugging)
save_files = ttsk.save_files;% 1;
image.image_folder = ttsk.image_folder; % 'C:\matlab\work\tiger_task_display\images\';
data_folder_name = ttsk.data_folder_name; % 'data_storage';
resting_state = ttsk.resting_state; % if resting state wanted
delay_test = ttsk.delay_test; % if screen delay test wanted
tt_version = ttsk.tt_version; % 'single', 'multienemy', 'multifriend'
session_number = ttsk.session_number; % 1;
participant_number_A = ttsk.participant_number_A; % 101;
participant_number_B = ttsk.participant_number_B; % 201;
wait_time = ttsk.wait_time; % 1;
fluct_ms = ttsk.fluct_ms; % 300;
rs_time = ttsk.rs_time; %2
% dt_time = ttsk.dt_time; %2
rs_duration = ttsk.rs_duration; %30 maybe
% dt_time_m_duration = ttsk.dt_time_m_duration; % 0.3 sec maybe
num_trials = ttsk.num_trials; % 10;
side.left = ttsk.side.left; %3;
side.right = ttsk.side.right; %1;
side.center = ttsk.side.center; %2;
reward.L = ttsk.reward.L; %-1;
reward.win = ttsk.reward.win; %10;
reward.loose = ttsk.reward.loose; %-100;
prob.growl_correctness = ttsk.prob.growl_correctness; %0.7;
if ~strcmp(tt_version,'single')
    prob.creek_side_correctness = ttsk.prob.creek_side_correctness; %0.8;
end
display.font_name = ttsk.display.font_name; %'Ariel';
display.font_size = ttsk.display.font_size; %40;
if ~strcmp(tt_version,'single')
    time.prediction = ttsk.time.prediction; %5;
end
time.choice = ttsk.time.choice; %5;
if ~strcmp(tt_version,'single')
    time.result_partner = ttsk.time.result_partner; %3;
end
time.result_your = ttsk.time.result_your; %3;
if strcmp(tt_version,'single')
    single = ttsk.single; %2;
end
if ~strcmp(tt_version,'single')
    enemy = ttsk.enemy; %4;
    friend = ttsk.friend; %5;
end
dot.colour_default = ttsk.dot.colour_default;
dot.colour_your = ttsk.dot.colour_your;
if ~strcmp(tt_version,'single')
    dot.colour_partner = ttsk.dot.colour_partner;
end
dot.size = ttsk.dot.size; % = 15;
%
%% extra parameters set based on te input parameters
% choosing the friend or the enemy setting
if ~strcmp(tt_version,'single')
    if ~isempty(strfind(tt_version,'enemy'))
        setting = 'enemy';
    elseif ~isempty(strfind(tt_version,'friend'))
        setting = 'friend';
    end
end
%
%% defaults
%
side.vector = [side.left side.right];
% setting
if strcmp(tt_version,'single')
    %     single = 2;
    A.setting = single;
    B.setting = single;
elseif ~strcmp(tt_version,'single')
    %     enemy = 4;
    %     friend = 5;
    if strcmp(setting,'enemy')
        A.setting = enemy;
        B.setting = enemy;
    elseif strcmp(setting,'friend')
        A.setting = friend;
        B.setting = friend;
    end
end

% output definition
if strcmp(tt_version,'single')
    out.definition = [{'sub_id'}, {'setting'}, {'session'}, {'trial_your'}, ...
        {'tiger_side'}, {'growl_side'}, {'growl_correct'}, {'action_your'}, {'action_your_rt'}, ...
        {'forced_action_listen'}, {'reward_your'},{'reward_relative_your'}, {'reward_cumulative_your'}];
elseif ~strcmp(tt_version,'single')
    out.definition = [{'sub_id'}, {'setting'}, {'session'}, {'trial_univ'}, {'trial_your'}, {'trial_partner'}, ...
        {'tiger_side'}, {'growl_side'}, {'growl_correct'}, {'creek_side'}, {'creek_correct'}, {'action_your'}, ...
        {'action_your_rt'}, {'prediction'}, {'prediction_rt'}, {'action_partner'}, {'action_partner_rt'}, ...
        {'prediction_partner'}, {'prediction_partner_rt'}, ...
        {'forced_action_listen'}, {'forced_prediction_listen'}, {'prediction_correct'}, {'reward_your'}, ...
        {'reward_relative_your'}, {'reward_cumulative_your'}, {'reward_partner'}, {'reward_relative_partner'}, ...
        {'reward_cumulative_partner'}];
end
%
%
%% reward structure
% reward calculation (modified matrix only)
reward.single.L = -1;
reward.single.win = 20;
reward.single.loose = -50;
reward.enemy.L_L = -1;
reward.enemy.L_win = -10;
reward.enemy.L_loose = 25;
reward.enemy.win_L = 20;
reward.enemy.win_win = 20;
reward.enemy.win_loose = 45;
reward.enemy.loose_L = -50;
reward.enemy.loose_win = -60;
reward.enemy.loose_loose = -50;
reward.friend.L_L = -1;
reward.friend.L_win = 10;
reward.friend.L_loose = -25;
reward.friend.win_L = 10;
reward.friend.win_win = 20;
reward.friend.win_loose = -15;
reward.friend.loose_L = -25;
reward.friend.loose_win = -15;
reward.friend.loose_loose = -50;

% % % reward calculation (original)
% % reward.single.L = reward.L;
% % reward.single.win = reward.win;
% % reward.single.loose = reward.loose;
% % reward.enemy.L_L = reward.L - (reward.L/2);
% % reward.enemy.L_win = reward.L - (reward.win/2);
% % reward.enemy.L_loose = reward.L - (reward.loose/2);
% % reward.enemy.win_L = reward.win - (reward.L/2);
% % reward.enemy.win_win = reward.win - (reward.win/2);
% % reward.enemy.win_loose = reward.win - (reward.loose/2);
% % reward.enemy.loose_L = reward.loose - (reward.L/2);
% % reward.enemy.loose_win = reward.loose - (reward.win/2);
% % reward.enemy.loose_loose = reward.loose - (reward.loose/2);
% % reward.friend.L_L = reward.L + (reward.L/2);
% % reward.friend.L_win = reward.L + (reward.win/2);
% % reward.friend.L_loose = reward.L + (reward.loose/2);
% % reward.friend.win_L = reward.win + (reward.L/2);
% % reward.friend.win_win = reward.win + (reward.win/2);
% % reward.friend.win_loose = reward.win + (reward.loose/2);
% % reward.friend.loose_L = reward.loose + (reward.L/2);
% % reward.friend.loose_win = reward.loose + (reward.win/2);
% % reward.friend.loose_loose = reward.loose + (reward.loose/2);
%
%% probabilities manupulation (for randomness)
if ~strcmp(tt_version,'single')
    prob.vector.creek_correctness = [ones(1,round(prob.creek_side_correctness * num_trials)),zeros(1,num_trials-round(prob.creek_side_correctness*num_trials))];
    prob.vector.creek_correctness=prob.vector.creek_correctness(randperm(length(prob.vector.creek_correctness)));
    prob.vector.growl_correctness = [ones(1,round(prob.growl_correctness * num_trials)),zeros(1,num_trials-round(prob.growl_correctness*num_trials))];
    prob.vector.growl_correctness=prob.vector.growl_correctness(randperm(length(prob.vector.growl_correctness)));
end
if strcmp(tt_version,'single')
    prob.vector.growl_correctness_A = [ones(1,round(prob.growl_correctness * num_trials)),zeros(1,num_trials-round(prob.growl_correctness*num_trials))];
    prob.vector.growl_correctness_A = prob.vector.growl_correctness_A(randperm(length(prob.vector.growl_correctness_A)));
    prob.vector.growl_correctness_B = [ones(1,round(prob.growl_correctness * num_trials)),zeros(1,num_trials-round(prob.growl_correctness*num_trials))];
    prob.vector.growl_correctness_B = prob.vector.growl_correctness_B(randperm(length(prob.vector.growl_correctness_B)));
end

if ~strcmp(tt_version,'single')
    prob.true_prob.creek_side_correctness = length(find(prob.vector.creek_correctness))/length(prob.vector.creek_correctness);
    prob.true_prob.growl_correctness = length(find(prob.vector.growl_correctness))/length(prob.vector.growl_correctness);
end
if strcmp(tt_version,'single')
    prob.true_prob.growl_correctness_A = length(find(prob.vector.growl_correctness_A))/length(prob.vector.growl_correctness_A);
    prob.true_prob.growl_correctness_B = length(find(prob.vector.growl_correctness_B))/length(prob.vector.growl_correctness_B);
end
% saving for output
if strcmp(tt_version,'single')
    probability.growl_correctness_A =  prob.growl_correctness;
    probability.growl_correctness_B =  prob.growl_correctness;
end
if ~strcmp(tt_version,'single')
    probability.creek_side_correctness = prob.creek_side_correctness;
    probability.growl_correctness =  prob.growl_correctness;
end
probability.true_prob = prob.true_prob;
out.probabilities = probability;
clear probability
%
%% setting up the screen
% Call some default settings for setting up Psychtoolbox

PsychDefaultSetup(2);
% Screen('Preference', 'SkipSyncTests', 1)
% VideoRecordingDemo('check_movie');

screens = Screen('Screens');
screenNumber = max(screens);
% Define black and white
colour.white = WhiteIndex(screenNumber);
colour.black = BlackIndex(screenNumber);
colour.grey = colour.white / 2;
colour.diode = colour.white;
% Open an on screen window and color it grey
[window, windowSize] = PsychImaging('OpenWindow', screenNumber, colour.grey);
%PsychDebugWindowConfiguration;
WaitSecs(wait_time);
% make the screen black
Screen('FillRect', window, colour.black);
% Setup the text type for the window
Screen('TextFont', window, display.font_name);
Screen('TextSize', window, display.font_size);
Screen('Flip', window);

WaitSecs(wait_time);
% KbStrokeWait;
%
%PsychDebugWindowConfiguration(0,0.5)
%% Timing
% Query the frame duration (Measure the vertical refresh rate of the monitor)
% frame_refresh_secs = Screen('GetFlipInterval', window);
% [width, height]=Screen('DisplaySize', screenNumber);
% mmtopix = [windowSize(3)/width windowSize(4)/height];
clear width height
% Retreive the maximum priority number
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% box colour
colour.transparency = 0.3;
colour.choice = [255/255 204/255 229/255 colour.transparency];
colour.prediction = [255/255 229/255 204/255 colour.transparency];
colour.result_your = [255/255 204/255 229/255 colour.transparency];
colour.result_partner = [255/255 229/255 204/255 colour.transparency];
colour.door_highlight = [255/255 255/255 102/255 colour.transparency];

%% images
%
image.door_closed_l = 'whitedoor_l_03.png';
image.door_closed_r = 'whitedoor_r_03.png';
image.door_open_l = 'whitedoor_knock_l_01.png';
image.door_open_r = 'whitedoor_knock_r_01.png';
image.door_highlight_listen_l = 'whitedoor_silence_l_01.png';
image.door_highlight_listen_r = 'whitedoor_silence_r_01.png';
image.door_highlight_gold_l = 'gold_behind_whitedoor_l_03.png';
image.door_highlight_gold_r = 'gold_behind_whitedoor_r_03.png';
image.door_highlight_tiger_l = 'tiger_behind_whitedoor_l_03.png';
image.door_highlight_tiger_r = 'tiger_behind_whitedoor_r_03.png';
image.door_gold_l = 'door_open_gold_l_02.png';
image.door_gold_r = 'door_open_gold_r_02.png';
image.door_tiger_l = 'door_open_tiger_l_02.png';
image.door_tiger_r = 'door_open_tiger_r_02.png';

% reward images (added p2 for pilot 2, new payout matrix. remove it if original wanted)
% single
image.reward.single.default ='p2Single_ownOnly.png';
% image.reward.single.L = 'Single_Listen_ownOnly.png';
image.reward.single.win = 'p2Single_Win_ownOnly.png';
image.reward.single.loose = 'p2Single_Loose_ownOnly.png';
% enemy
image.reward.enemy.default = 'p2Enemy_ownOnly.png';
% image.reward.enemy.L_L = 'Enemy_ListenListen_ownOnly.png';
% image.reward.enemy.L_win = 'Enemy_ListenWin_ownOnly.png';
% image.reward.enemy.L_loose = 'Enemy_ListenLoose_ownOnly.png';
image.reward.enemy.win_L = 'p2Enemy_WinListen_ownOnly.png';
image.reward.enemy.win_win = 'p2Enemy_WinWin_ownOnly.png';
image.reward.enemy.win_loose = 'p2Enemy_WinLoose_ownOnly.png';
image.reward.enemy.loose_L = 'p2Enemy_LooseListen_ownOnly.png';
image.reward.enemy.loose_win = 'p2Enemy_LooseWin_ownOnly.png';
image.reward.enemy.loose_loose = 'p2Enemy_LooseLoose_ownOnly.png';
% friend
image.reward.friend.default = 'p2Friend_ownOnly.png';
% image.reward.friend.L_L = 'Friend_ListenListen_ownOnly.png';
% image.reward.friend.L_win = 'Friend_ListenWin_ownOnly.png';
% image.reward.friend.L_loose = 'Friend_ListenLoose_ownOnly.png';
image.reward.friend.win_L = 'p2Friend_WinListen_ownOnly.png';
image.reward.friend.win_win = 'p2Friend_WinWin_ownOnly.png';
image.reward.friend.win_loose = 'p2Friend_WinLoose_ownOnly.png';
image.reward.friend.loose_L = 'p2Friend_LooseListen_ownOnly.png';
image.reward.friend.loose_win = 'p2Friend_LooseWin_ownOnly.png';
image.reward.friend.loose_loose = 'p2Friend_LooseLoose_ownOnly.png';

% cellfun(@size,A,'uni',false)
%% Get the centre coordinate of the window
[center.x, center.y] = RectCenter(windowSize);

% reward section
% reward center
center.rew.x = center.x;
center.rew.y = center.y - (windowSize(4) - center.y)/2;
center.rew.y = center.rew.y + (center.y - center.rew.y)/2;
% reward left and right center
center.rew.xl = center.rew.x/2;
center.rew.xr = 3*center.rew.x/2;
center.rew.yl = center.rew.y;
center.rew.yr = center.rew.y;
% reward, two equicenters from the two centers
center.rew.xl_l = center.rew.xl/2;
center.rew.xl_r = 3*center.rew.xl/2;
center.rew.xr_l = center.rew.x + (center.rew.xr-center.rew.x)/2;
center.rew.xr_r = center.rew.x + 3*(center.rew.xr-center.rew.x)/2;
center.rew.yl_l = center.rew.yl;
center.rew.yl_r = center.rew.yl;
center.rew.yr_l = center.rew.yr;
center.rew.yr_r = center.rew.yr;

% doors section
% shifting the center of y a bit lower for fitting the reward better
center.y = center.y + (windowSize(4) - center.y)/2;
center.y = center.y - (windowSize(4) - center.y)/2;
% left and right center
center.xl = center.x/2;
center.xr = 3*center.x/2;
center.yl = center.y;
center.yr = center.y;
% two equicenters from the two centers
center.xl_l = center.xl/2;
center.xl_r = 3*center.xl/2;
center.xr_l = center.x + (center.xr-center.x)/2;
center.xr_r = center.x + 3*(center.xr-center.x)/2;
center.yl_l = center.yl;
center.yl_r = center.yl;
center.yr_l = center.yr;
center.yr_r = center.yr;
%

% rectangle to color code the slides
rect.xl = (center.xl_l - 0)/2;
rect.yl = (center.yl_l - 0)/2;
rect.bg_l = [center.xl_l-rect.xl, center.yl_l-rect.yl, center.xl_r+rect.xl, center.yl_r+rect.yl];
rect.bg_r = [center.xr_l-rect.xl, center.yr_l-rect.yl, center.xr_r+rect.xl, center.yr_r+rect.yl];
rect.xl = rect.xl/2;
rect.yl = rect.yl/2;
% the door pics location
rect.pic_l.l = [center.xl_l-rect.xl, center.yl_l-rect.yl,center.xl_l+rect.xl,center.yl_l+rect.yl];
rect.pic_l.r = [center.xl_r-rect.xl, center.yl_r-rect.yl,center.xl_r+rect.xl,center.yl_r+rect.yl];
rect.pic_r.l = [center.xr_l-rect.xl, center.yr_l-rect.yl,center.xr_l+rect.xl,center.yr_l+rect.yl];
rect.pic_r.r = [center.xr_r-rect.xl, center.yr_r-rect.yl,center.xr_r+rect.xl,center.yr_r+rect.yl];

% the reward matrix pics location
% windowSize(4)/16
rect.rew.scale = 1.2;
rect.rew.l = [(center.rew.xl-center.rew.xl_l*(rect.rew.scale)), (center.rew.yl_l-(windowSize(4)/4)*(rect.rew.scale)), (center.rew.xl + center.rew.xl_l*(rect.rew.scale)), (center.rew.yl_r+(windowSize(4)/16)*(rect.rew.scale))];
rect.rew.r = [center.rew.xr-(center.rew.xr-center.rew.xr_l)*(rect.rew.scale), (center.rew.yr_l-(windowSize(4)/4)*(rect.rew.scale)), center.rew.xr+(center.rew.xr - center.rew.xr_l)*(rect.rew.scale), (center.rew.yr_r+(windowSize(4)/16)*(rect.rew.scale))];


%% automatic picture positioning
% the closed door pic left side for reference (for left side)
temp_image_c = image.door_closed_l;
temp_image_c = imread(strcat(image.image_folder,temp_image_c));
% the opendoor pic left side for reference (for left side)
temp_image_o = image.door_gold_l;
temp_image_o = imread(strcat(image.image_folder,temp_image_o));
%index_of_first = find(YourVector == TheValue, 1, 'first');
o.above = find(temp_image_o(:,1,1)>100,1,'first') - 1; % 100 for the change for the value from balck to white
o.below = length(temp_image_o(:,1,1)) - find(temp_image_o(:,1,1)>100,1,'last');
o.right = length(temp_image_o(1,:,1))-find(temp_image_o(floor(length(temp_image_o(:,1,1))/2),:,1)>100,1,'last');
c.above = find(temp_image_c(:,1,1)>100,1,'first') - 1;
c.below = length(temp_image_c(:,1,1)) - find(temp_image_c(:,1,1)>100,1,'last');
c.right = length(temp_image_c(1,:,1)) - find(temp_image_c(floor(length(temp_image_c(:,1,1))/2),:,1)>100,1,'last');
%
o.above = o.above - c.above;
o.below = o.below - c.below;
o.right = o.right - c.right;
% maybe here look for image reso

picr.x = size(temp_image_c,2)/(rect.pic_l.l(3)-rect.pic_l.l(1));
picr.y = size(temp_image_c,1)/(rect.pic_l.l(4)-rect.pic_l.l(2));

% amount of change for the particular scsreen to display on
o.above = o.above/picr.y; % y height
o.below = o.below/picr.y; % y height
o.right = o.right/picr.x; % x height
% the open door pics location
rect.pic_l.l_open = rect.pic_l.l + [0 -o.above o.right o.below];
rect.pic_l.r_open = rect.pic_l.r + [-o.right -o.above 0 o.below];
rect.pic_r.l_open = rect.pic_r.l + [0 -o.above o.right o.below];
rect.pic_r.r_open = rect.pic_r.r + [-o.right -o.above 0 o.below];
clear c o picr temp_image_o temp_image_c

%% the algorithm to display the cumulative reaward centered
% numel(num2str(the_num))
skstr.window = window;
skstr.c_background = colour.black;
skstr.c_foreground = colour.white;
skstr.loc_x = center.xl;
skstr.loc_y = center.y;
skstr.temp_text = '1';
[cum_rew_l.xpos(1),cum_rew_l.ypos(1)]=sk_center_cood(skstr); % for 1 digit
skstr.temp_text = '12';
[cum_rew_l.xpos(2),cum_rew_l.ypos(2)]=sk_center_cood(skstr); % for 2 digit
skstr.temp_text = '123';
[cum_rew_l.xpos(3),cum_rew_l.ypos(3)]=sk_center_cood(skstr); % for 3 digit
skstr.temp_text = '1234';
[cum_rew_l.xpos(4),cum_rew_l.ypos(4)]=sk_center_cood(skstr); % for 4 digit
skstr.temp_text = '12345';
[cum_rew_l.xpos(5),cum_rew_l.ypos(5)]=sk_center_cood(skstr); % for 5 digit
skstr.temp_text = '123456';
[cum_rew_l.xpos(6),cum_rew_l.ypos(6)]=sk_center_cood(skstr); % for 6 digit
skstr.loc_x = center.xr;
skstr.temp_text = '1';
[cum_rew_r.xpos(1),cum_rew_r.ypos(1)]=sk_center_cood(skstr); % for 1 digit
skstr.temp_text = '12';
[cum_rew_r.xpos(2),cum_rew_r.ypos(2)]=sk_center_cood(skstr); % for 2 digit
skstr.temp_text = '123';
[cum_rew_r.xpos(3),cum_rew_r.ypos(3)]=sk_center_cood(skstr); % for 3 digit
skstr.temp_text = '1234';
[cum_rew_r.xpos(4),cum_rew_r.ypos(4)]=sk_center_cood(skstr); % for 4 digit
skstr.temp_text = '12345';
[cum_rew_r.xpos(5),cum_rew_r.ypos(5)]=sk_center_cood(skstr); % for 5 digit
skstr.temp_text = '123456';
[cum_rew_r.xpos(6),cum_rew_r.ypos(6)]=sk_center_cood(skstr); % for 6 digit
%

%% opening port
% opening the port for trigger
if ttsk.trig.wanted
    handle = IOPort('OpenSerialPort', ttsk.trig.port_no,sprintf('BaudRate=%d',ttsk.trig.baudrate));
    %     IOPort('Write', handle, uint8(ttsk.trig.start_experiment));
end

%% Next
% Now horizontally and vertically centered:
temp_text = 'Bitte warten Sie auf die Versuchsleiter'; % please wait for the invigilator
skstr.window = window;
skstr.temp_text = temp_text;
skstr.loc_x = center.xr;
skstr.loc_y = center.y;
skstr.c_background = colour.black;
skstr.c_foreground = colour.white;
[temp_xr,temp_yr]=sk_center_cood(skstr);
skstr.temp_text = temp_text;
skstr.loc_x = center.xl;
[temp_xl,temp_yl]=sk_center_cood(skstr);
DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
Screen('Flip', window);
if get_screenshot
    % get image
    imwrite(Screen('GetImage', window), 'image_welcome.jpg');
end
clear temp_text
KbStrokeWait;

% start the experiment
if ttsk.trig.wanted
    IOPort('Write', handle, uint8(ttsk.trig.start_experiment));
end

%% Keyboard keys to be used
escapeKey = KbName('ESCAPE');
B.key.openleft = KbName('LeftArrow');
B.key.openright = KbName('RightArrow');
B.key.listen = KbName('UpArrow');
A.key.openleft = KbName('a');
A.key.openright = KbName('d');
A.key.listen = KbName('w');

%% Keyboard response values (what numbers mean what)
response.listen = side.center;
response.openleft = side.left;
response.openright = side.right;
response.action_vector = [response.openright,response.listen,response.openleft];

%% anti alising
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
%
%% Basics
% sub id
A.sub_id = participant_number_A;
% session number
A.session = session_number;
B.sub_id = participant_number_B;
B.session = session_number;
%
%% resting state section
if resting_state
    %%%%% EYES OPEN
    temp_text = 'Augen offen lassen'; % keep eyes open
    skstr.window = window;
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xr;
    skstr.loc_y = center.y;
    skstr.c_background = colour.black;
    skstr.c_foreground = colour.white;
    [temp_xr,temp_yr]=sk_center_cood(skstr);
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xl;
    [temp_xl,temp_yl]=sk_center_cood(skstr);
    DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
    DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
    Screen('Flip', window);
    if get_screenshot
        % get image
        imwrite(Screen('GetImage', window), 'image_eyes_open.jpg');
    end
    WaitSecs(rs_time);
    
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    if delay_test % at eyes open
        Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
    end
    Screen('Flip', window);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_eyes_open));
    end
    WaitSecs(rs_duration);
    
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_eyes_open));
    end
    %
    %%%%% EYES CLOSE
    temp_text = 'Augen schlieﬂen'; % close your eyes
    skstr.window = window;
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xr;
    skstr.loc_y = center.y;
    skstr.c_background = colour.black;
    skstr.c_foreground = colour.white;
    [temp_xr,temp_yr]=sk_center_cood(skstr);
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xl;
    [temp_xl,temp_yl]=sk_center_cood(skstr);
    DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
    DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
    Screen('Flip', window);
    if get_screenshot
        % get image
        imwrite(Screen('GetImage', window), 'image_eyes_closed.jpg');
    end
    WaitSecs(rs_time);
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    if delay_test % at eyes closed
        Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
    end
    Screen('Flip', window);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_eyes_closed));
    end
    WaitSecs(rs_duration);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_eyes_closed));
    end
    clear temp_text
end
%
%% After resting state, or the delay_test the experiment to start now
if delay_test || resting_state
    temp_text = 'Bitte warten Sie auf die Versuchsleiter'; % please wait for the invigilator
    skstr.window = window;
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xr;
    skstr.loc_y = center.y;
    skstr.c_background = colour.black;
    skstr.c_foreground = colour.white;
    [temp_xr,temp_yr]=sk_center_cood(skstr);
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xl;
    [temp_xl,temp_yl]=sk_center_cood(skstr);
    DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
    DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
    Screen('Flip', window);
    clear temp_text
    KbStrokeWait;
end
%
%
% start sequences
if ttsk.trig.wanted
    IOPort('Write', handle, uint8(ttsk.trig.start_sequence));
end
%
%% slides
%
participant_A =[];
participant_B =[];
% initialize trial number - PERSONAL
A.trial_your = 1;
B.trial_your = 1;

if ~strcmp(tt_version,'single')
    A.trial_partner = 1;
    B.trial_partner = 1;
end
%
% random tiger and gold side only if the loop_trial is changed / if door is opened
if strcmp(tt_version,'single')
    tiger_side_A = datasample(side.vector,1);
    gold_side_A = side.vector(side.vector~=tiger_side_A);
    tiger_side_B = datasample(side.vector,1);
    gold_side_B = side.vector(side.vector~=tiger_side_B);
elseif ~strcmp(tt_version,'single')
    tiger_side = datasample(side.vector,1);
    gold_side = side.vector(side.vector~=tiger_side);
end



%
% reward
A.reward = nan;
A.reward_relative = 0;
A.reward_cumulative = 0;
B.reward = nan;
B.reward_relative = 0;
B.reward_cumulative = 0;

%% Begin
% dots
Screen('FillRect', window, colour.black);
image.name = image.door_closed_l;
image.loc = rect.pic_l.l;
sk_psy_make_image(image,window)
image.name = image.door_closed_r;
image.loc = rect.pic_l.r;
sk_psy_make_image(image,window);
Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
image.name = image.door_closed_l;
image.loc = rect.pic_r.l;
sk_psy_make_image(image,window)
image.name = image.door_closed_r;
image.loc = rect.pic_r.r;
sk_psy_make_image(image,window);
Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
if strcmp(tt_version,'single')
    image.name = image.reward.single.default;
elseif ~strcmp(tt_version,'single')
    if strcmp(setting,'enemy')
        image.name = image.reward.enemy.default;
    elseif strcmp(setting,'friend')
        image.name = image.reward.friend.default;
    end
end
image.loc = rect.rew.l;
sk_psy_make_rew_image(image,window);
image.loc = rect.rew.r;
sk_psy_make_rew_image(image,window);
Screen('Flip', window);
%
WaitSecs(wait_time+randi(fluct_ms,1,1)/1000); % plus random 300 ms fluctuation


if ~strcmp(tt_version,'single')
    count_iterations = 0;
end
if strcmp(tt_version,'single')
    count_iterations_A = 0;
    count_iterations_B = 0;
end
loop_trial=1;
if strcmp(tt_version,'single')
    loop_trial_A = 1;
    loop_trial_B = 1;
end
while loop_trial <= num_trials
    %% 0.) trial basics
    if ~strcmp(tt_version,'single')
        count_iterations = count_iterations + 1;
    elseif strcmp(tt_version,'single')
        count_iterations_A = count_iterations_A + 1;
        count_iterations_B = count_iterations_B + 1;
    end
    % trial number - universal
    if ~strcmp(tt_version,'single')
        A.trial_univ = loop_trial;
        B.trial_univ = loop_trial;
    end
    % tiger_side
    if strcmp(tt_version,'single')
        A.tiger_side = tiger_side_A;
        B.tiger_side = tiger_side_B;
    elseif ~strcmp(tt_version,'single')
        A.tiger_side = tiger_side;
        B.tiger_side = tiger_side;
    end
    %% 1.) Prediction
    if ~strcmp(tt_version,'single')
        % heading
        %sk_double_heading('prediction',window,center,colour);
        %
        image.name = image.door_closed_l;
        image.loc = rect.pic_l.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_l.r;
        sk_psy_make_image(image,window);
        Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_partner, [], 2);
        image.name = image.door_closed_l;
        image.loc = rect.pic_r.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_r.r;
        sk_psy_make_image(image,window);
        Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_partner, [], 2);
        % colour coded background
        % Screen('FillRect', window, colour.prediction, rect.bg_l);
        % Screen('FillRect', window, colour.prediction, rect.bg_r);
        % reward matrix
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
        image.loc = rect.rew.l;
        sk_psy_make_rew_image(image,window);
        image.loc = rect.rew.r;
        sk_psy_make_rew_image(image,window);
        if delay_test % at prediction
            Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
        end
        Screen('Flip', window);
        %%% trigger part %%%
        if ttsk.trig.wanted
            IOPort('Write', handle, uint8(ttsk.trig.start_prediction));
        end
        %%%%%%%%%%%%%%%%%%%%
        A.prediction = NaN;
        B.prediction = NaN;
        A.time.end = NaN;
        B.time.end = NaN;
        time.start = GetSecs;
        time.count = time.start;
        flag_trig_A = 0;
        flag_trig_B = 0;
        while (time.count <= time.start + time.prediction)
            % Check the keyboard. The person should press the
            [~,~ , keyCode] = KbCheck;
            if keyCode(A.key.listen)
                A.time.end = GetSecs;
                A.prediction = response.listen; % listen
            elseif keyCode(A.key.openleft)
                A.time.end = GetSecs;
                A.prediction = response.openleft; %
            elseif keyCode(A.key.openright)
                A.time.end = GetSecs;
                A.prediction = response.openright; % open right
            else
                time.count = GetSecs;
            end
            if keyCode(A.key.listen) || keyCode(A.key.openleft) || keyCode(A.key.openright)
                % trigger section
                if (ttsk.trig.wanted) && (flag_trig_A==0)
                    IOPort('Write', handle, uint8(ttsk.trig.response_prediction_A));
                    flag_trig_A = 1;
                end
                image.name = image.door_closed_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window)
                image.name = image.door_closed_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
                Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
                image.name = image.door_closed_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window)
                image.name = image.door_closed_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
                if isnan(B.prediction)
                    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_partner, [], 2);
                elseif ~isnan(B.prediction)
                    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
                end
                if strcmp(setting,'enemy')
                    image.name = image.reward.enemy.default;
                elseif strcmp(setting,'friend')
                    image.name = image.reward.friend.default;
                end
                image.loc = rect.rew.l;
                sk_psy_make_rew_image(image,window);
                image.loc = rect.rew.r;
                sk_psy_make_rew_image(image,window);
                if delay_test % at prediction
                    Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
                end
                Screen('Flip', window);
            end
            if keyCode(B.key.listen)
                B.time.end = GetSecs;
                B.prediction = response.listen; % listen
            elseif keyCode(B.key.openleft)
                B.time.end = GetSecs;
                B.prediction = response.openleft; %
            elseif keyCode(B.key.openright)
                B.time.end = GetSecs;
                B.prediction = response.openright; % open right
            else
                time.count = GetSecs;
            end
            if keyCode(B.key.listen) || keyCode(B.key.openleft) || keyCode(B.key.openright)
                % trigger section
                if (ttsk.trig.wanted) && (flag_trig_B==0)
                    IOPort('Write', handle, uint8(ttsk.trig.response_prediction_B));
                    flag_trig_B = 1;
                end
                image.name = image.door_closed_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window)
                image.name = image.door_closed_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
                Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
                image.name = image.door_closed_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window)
                image.name = image.door_closed_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
                if isnan(A.prediction)
                    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_partner, [], 2);
                elseif ~isnan(A.prediction)
                    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
                end
                if strcmp(setting,'enemy')
                    image.name = image.reward.enemy.default;
                elseif strcmp(setting,'friend')
                    image.name = image.reward.friend.default;
                end
                image.loc = rect.rew.l;
                sk_psy_make_rew_image(image,window);
                image.loc = rect.rew.r;
                sk_psy_make_rew_image(image,window);
                if delay_test % at prediction
                    Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
                end
                Screen('Flip', window);
            end
        end
        %         GetSecs - time.start % check timing
        A.prediction_rt = A.time.end - time.start;
        B.prediction_rt = B.time.end - time.start;
        
        % forced listen
        if isnan(A.prediction)
            A.prediction = 2;
            A.forced_prediction_listen = 1;
        else
            A.forced_prediction_listen = 0;
        end
        if isnan(B.prediction)
            B.prediction = 2;
            B.forced_prediction_listen = 1;
        else
            B.forced_prediction_listen = 0;
        end
        
        % KbStrokeWait;
        
        % dots and doors
        Screen('FillRect', window, colour.black);
        image.name = image.door_closed_l;
        image.loc = rect.pic_l.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_l.r;
        sk_psy_make_image(image,window);
        image.name = image.door_closed_l;
        image.loc = rect.pic_r.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_r.r;
        sk_psy_make_image(image,window);
        Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
        Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
        image.loc = rect.rew.l;
        sk_psy_make_rew_image(image,window);
        image.loc = rect.rew.r;
        sk_psy_make_rew_image(image,window);
        Screen('Flip', window);
        %%% trigger part %%%
        if ttsk.trig.wanted
            IOPort('Write', handle, uint8(ttsk.trig.end_prediction));
        end
        %%%%%%%%%%%%%%%%%%%%
        WaitSecs(wait_time+randi(fluct_ms,1,1)/1000); % plus random 300 ms fluctuation
    end
    
    %% 2.) Choice
    % heading
    %sk_double_heading('your-action',window,center,colour);
    %
    image.name = image.door_closed_l;
    image.loc = rect.pic_l.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_l.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_your, [], 2);
    image.name = image.door_closed_l;
    image.loc = rect.pic_r.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_r.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_your, [], 2);
    %     end
    % colour coded background
    % Screen('FillRect', window, colour.choice, rect.bg_l);
    % Screen('FillRect', window, colour.choice, rect.bg_r);
    if strcmp(tt_version,'single')
        image.name = image.reward.single.default;
    elseif ~strcmp(tt_version,'single')
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
    end
    image.loc = rect.rew.l;
    sk_psy_make_rew_image(image,window);
    image.loc = rect.rew.r;
    sk_psy_make_rew_image(image,window);
    if delay_test % at choice
        Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
    end
    Screen('Flip', window);
    %%% trigger part %%%
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_choice));
    end
    %%%%%%%%%%%%%%%%%%%%
    %
    A.action_your = NaN;
    B.action_your = NaN;
    A.time.end = NaN;
    B.time.end = NaN;
    time.start = GetSecs;
    time.count = time.start;
    flag_trig_A = 0;
    flag_trig_B = 0;
    while (time.count <= time.start + time.choice)
        % Check the keyboard. The person should press the
        [~,~ , keyCode] = KbCheck;
        if keyCode(A.key.listen)
            A.time.end = GetSecs;
            A.action_your = response.listen; % open left
        elseif keyCode(A.key.openleft)
            A.time.end = GetSecs;
            A.action_your = response.openleft; % listen
        elseif keyCode(A.key.openright)
            A.time.end = GetSecs;
            A.action_your = response.openright; % open right
        else
            time.count = GetSecs;
        end
        if keyCode(A.key.listen) || keyCode(A.key.openleft) || keyCode(A.key.openright)
            % trigger section
            if (ttsk.trig.wanted) && (flag_trig_A==0)
                IOPort('Write', handle, uint8(ttsk.trig.response_choice_A));
                flag_trig_A = 1;
            end
            image.name = image.door_closed_l;
            image.loc = rect.pic_l.l;
            sk_psy_make_image(image,window)
            image.name = image.door_closed_r;
            image.loc = rect.pic_l.r;
            sk_psy_make_image(image,window);
            Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
            image.name = image.door_closed_l;
            image.loc = rect.pic_r.l;
            sk_psy_make_image(image,window)
            image.name = image.door_closed_r;
            image.loc = rect.pic_r.r;
            sk_psy_make_image(image,window);
            if isnan(B.action_your)
                Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_your, [], 2);
            elseif ~isnan(B.action_your)
                Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
            end
            if strcmp(tt_version,'single')
                image.name = image.reward.single.default;
            elseif ~strcmp(tt_version,'single')
                if strcmp(setting,'enemy')
                    image.name = image.reward.enemy.default;
                elseif strcmp(setting,'friend')
                    image.name = image.reward.friend.default;
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
            if delay_test % at choice
                Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
            end
            Screen('Flip', window);
        end
        %
        if keyCode(B.key.listen)
            B.time.end = GetSecs;
            B.action_your = response.listen; % open left
        elseif keyCode(B.key.openleft)
            B.time.end = GetSecs;
            B.action_your = response.openleft; % listen
        elseif keyCode(B.key.openright)
            B.time.end = GetSecs;
            B.action_your = response.openright; % open right
        else
            time.count = GetSecs;
        end
        if keyCode(B.key.listen) || keyCode(B.key.openleft) || keyCode(B.key.openright)
            % trigger section
            if (ttsk.trig.wanted) && (flag_trig_B==0)
                IOPort('Write', handle, uint8(ttsk.trig.response_choice_B));
                flag_trig_B = 1;
            end
            image.name = image.door_closed_l;
            image.loc = rect.pic_r.l;
            sk_psy_make_image(image,window)
            image.name = image.door_closed_r;
            image.loc = rect.pic_r.r;
            sk_psy_make_image(image,window);
            Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
            image.name = image.door_closed_l;
            image.loc = rect.pic_l.l;
            sk_psy_make_image(image,window)
            image.name = image.door_closed_r;
            image.loc = rect.pic_l.r;
            sk_psy_make_image(image,window);
            if isnan(A.action_your)
                Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_your, [], 2);
            elseif ~isnan(A.action_your)
                Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
            end
            if strcmp(tt_version,'single')
                image.name = image.reward.single.default;
            elseif ~strcmp(tt_version,'single')
                if strcmp(setting,'enemy')
                    image.name = image.reward.enemy.default;
                elseif strcmp(setting,'friend')
                    image.name = image.reward.friend.default;
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
            if delay_test % at choice
                Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
            end
            Screen('Flip', window);
        end
    end
    %             GetSecs - time.start % check timing
    A.action_your_rt = A.time.end - time.start;
    B.action_your_rt = B.time.end - time.start;
    %
    % forced listen
    if isnan(A.action_your)
        A.action_your = 2;
        A.forced_action_listen = 1;
    else
        A.forced_action_listen = 0;
    end
    if isnan(B.action_your)
        B.action_your = 2;
        B.forced_action_listen = 1;
    else
        B.forced_action_listen = 0;
    end
    %
    % partner
    if ~strcmp(tt_version,'single')
        A.action_partner = B.action_your;
        B.action_partner = A.action_your;
        A.action_partner_rt = B.action_your_rt;
        B.action_partner_rt = A.action_your_rt;
    end
    %
    % dots
    Screen('FillRect', window, colour.black);
    image.name = image.door_closed_l;
    image.loc = rect.pic_l.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_l.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    image.name = image.door_closed_l;
    image.loc = rect.pic_r.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_r.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    if strcmp(tt_version,'single')
        image.name = image.reward.single.default;
    elseif ~strcmp(tt_version,'single')
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
    end
    image.loc = rect.rew.l;
    sk_psy_make_rew_image(image,window);
    image.loc = rect.rew.r;
    sk_psy_make_rew_image(image,window);
    Screen('Flip', window);
    %%% trigger part %%%
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_choice));
    end
    %%%%%%%%%%%%%%%%%%%%
    WaitSecs(wait_time+randi(fluct_ms,1,1)/1000); % plus random 300 ms fluctuation
    
    
    %% 3.) result partner
    if ~strcmp(tt_version,'single')
        %heading
        %     heading_text = 'partner result';
        %     [temp_xr,temp_yr,temp_xl,temp_yl] = sk_double_heading(heading_text,window,center,colour);
        %
        temp_randomness = randperm(2,1); % only used for the wrong response
        time.start = GetSecs;
        time.count = time.start;
        %%% trigger part %%%
        if ttsk.trig.wanted
            IOPort('Write', handle, uint8(ttsk.trig.start_evidence_other_player));
        end
        %%%%%%%%%%%%%%%%%%%%
        while time.count <= time.start + time.result_partner
            % for participant A
            if (prob.vector.creek_correctness(count_iterations)==1) % correct action to show
                A.creek_side = B.action_your;
                if (B.action_your == response.listen)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_l.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_l.r;
                    sk_psy_make_image(image,window);
                end
                if (B.action_your == response.openleft)
                    image.name = image.door_open_l;
                    image.loc = rect.pic_l.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_l.r;
                    sk_psy_make_image(image,window);
                end
                if (B.action_your == response.openright)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_l.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_open_r;
                    image.loc = rect.pic_l.r;
                    sk_psy_make_image(image,window);
                end
            end
            if (prob.vector.creek_correctness(count_iterations)==0) % wrong action to show
                temp_response = response.action_vector(response.action_vector~=find(response.action_vector==B.action_your));
                A.creek_side = temp_response(temp_randomness);
                clear temp_response
                if (B.action_your == response.listen)
                    if temp_randomness==2
                        image.name = image.door_open_l;
                        image.loc = rect.pic_l.l;
                        sk_psy_make_image(image,window);
                        image.name = image.door_highlight_listen_r;
                        image.loc = rect.pic_l.r;
                        sk_psy_make_image(image,window);
                    elseif temp_randomness==1
                        image.name = image.door_highlight_listen_l;
                        image.loc = rect.pic_l.l;
                        sk_psy_make_image(image,window);
                        image.name = image.door_open_r;
                        image.loc = rect.pic_l.r;
                        sk_psy_make_image(image,window);
                    end
                end
                if (B.action_your == response.openleft)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_l.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_l.r;
                    sk_psy_make_image(image,window);
                end
                if (B.action_your == response.openright)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_l.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_l.r;
                    sk_psy_make_image(image,window);
                    
                end
            end
            % for participant B
            if (prob.vector.creek_correctness(count_iterations)==1) % correct action to show
                B.creek_side = A.action_your;
                if (A.action_your == response.listen)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_r.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_r.r;
                    sk_psy_make_image(image,window);
                end
                if (A.action_your == response.openleft)
                    image.name = image.door_open_l;
                    image.loc = rect.pic_r.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_r.r;
                    sk_psy_make_image(image,window);
                end
                if (A.action_your == response.openright)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_r.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_open_r;
                    image.loc = rect.pic_r.r;
                    sk_psy_make_image(image,window);
                end
            end
            if (prob.vector.creek_correctness(count_iterations)==0) % wrong action to show
                temp_response = response.action_vector(response.action_vector~=find(response.action_vector==A.action_your));
                B.creek_side = temp_response(temp_randomness);
                clear temp_response
                if (A.action_your == response.listen)
                    if temp_randomness==2
                        image.name = image.door_open_l;
                        image.loc = rect.pic_r.l;
                        sk_psy_make_image(image,window);
                        image.name = image.door_highlight_listen_r;
                        image.loc = rect.pic_r.r;
                        sk_psy_make_image(image,window);
                    elseif temp_randomness==1
                        image.name = image.door_highlight_listen_l;
                        image.loc = rect.pic_r.l;
                        sk_psy_make_image(image,window);
                        image.name = image.door_open_r;
                        image.loc = rect.pic_r.r;
                        sk_psy_make_image(image,window);
                    end
                end
                if (A.action_your == response.openleft)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_r.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_r.r;
                    sk_psy_make_image(image,window);
                end
                if (A.action_your == response.openright)
                    image.name = image.door_highlight_listen_l;
                    image.loc = rect.pic_r.l;
                    sk_psy_make_image(image,window);
                    image.name = image.door_highlight_listen_r;
                    image.loc = rect.pic_r.r;
                    sk_psy_make_image(image,window);
                end
            end
            % heading
            %         DrawFormattedText(window, heading_text, temp_xl,temp_yl, colour.white);
            %         DrawFormattedText(window, heading_text, temp_xr,temp_yr, colour.white);
            % dots
            %             Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_partner, [], 2);
            %             Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_partner, [], 2);
            Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
            Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
            if strcmp(setting,'enemy')
                image.name = image.reward.enemy.default;
            elseif strcmp(setting,'friend')
                image.name = image.reward.friend.default;
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
            if delay_test % at result partner
                Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
            end
            Screen('Flip', window);
            time.count = GetSecs;
        end
        % creek correctness
        A.creek_correct = prob.vector.creek_correctness(count_iterations);
        B.creek_correct = prob.vector.creek_correctness(count_iterations);
        
        % prediction correctness
        A.prediction_correct = nan;
        B.prediction_correct = nan;
        if A.forced_prediction_listen ~= 1
            if A.prediction == B.action_your
                A.prediction_correct = 1;
            else
                A.prediction_correct = 0;
            end
        end
        if B.forced_prediction_listen ~= 1
            if B.prediction == A.action_your
                B.prediction_correct = 1;
            else
                B.prediction_correct = 0;
            end
        end
        WaitSecs(wait_time);
        %
        Screen('FillRect', window, colour.black);
        image.name = image.door_closed_l;
        image.loc = rect.pic_l.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_l.r;
        sk_psy_make_image(image,window);
        image.name = image.door_closed_l;
        image.loc = rect.pic_r.l;
        sk_psy_make_image(image,window)
        image.name = image.door_closed_r;
        image.loc = rect.pic_r.r;
        sk_psy_make_image(image,window);
        Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
        Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
        image.loc = rect.rew.l;
        sk_psy_make_rew_image(image,window);
        image.loc = rect.rew.r;
        sk_psy_make_rew_image(image,window);
        Screen('Flip', window);
        %%% trigger part %%%
        if ttsk.trig.wanted
            IOPort('Write', handle, uint8(ttsk.trig.end_evidence_other_player));
        end
        %%%%%%%%%%%%%%%%%%%%
        WaitSecs(wait_time+randi(fluct_ms,1,1)/1000); % plus random 300 ms fluctuation
    end
    
    %% 4.) result your
    temp_o_action_performed.A = 0;
    temp_o_action_performed.B = 0;
    %heading
    %     heading_text = 'your result';
    %     [temp_xr,temp_yr,temp_xl,temp_yl] = sk_double_heading(heading_text,window,center,colour);
    %
    time.start = GetSecs;
    time.count = time.start;
    %%% trigger part %%%
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_evidence_own));
    end
    %%%%%%%%%%%%%%%%%%%%
    while time.count <= time.start + time.result_your
        % for participant A
        % reward calculation
        if strcmp(tt_version,'single')
            tiger_side = tiger_side_A;
            gold_side = gold_side_A;
        end
        if strcmp(tt_version,'single')
            if tiger_side_A==side.left
                if A.action_your==response.listen
                    A.reward = reward.single.L;
                elseif A.action_your==response.openleft
                    A.reward = reward.single.loose;
                elseif A.action_your==response.openright
                    A.reward = reward.single.win;
                end
            end
            if tiger_side_A==side.right
                if A.action_your==response.listen
                    A.reward = reward.single.L;
                elseif A.action_your==response.openleft
                    A.reward = reward.single.win;
                elseif A.action_your==response.openright
                    A.reward = reward.single.loose;
                end
            end
        elseif ~strcmp(tt_version,'single')
            if tiger_side==side.left
                if (A.action_your==response.listen) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_L;
                    end
                elseif (A.action_your==response.listen) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_loose;
                    end
                elseif (A.action_your==response.listen) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_win;
                    end
                end
                if (A.action_your==response.openleft) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_L;
                    end
                elseif (A.action_your==response.openleft) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_loose;
                    end
                elseif (A.action_your==response.openleft) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_win;
                    end
                end
                if (A.action_your==response.openright) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_L;
                    end
                elseif (A.action_your==response.openright) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_loose;
                    end
                elseif (A.action_your==response.openright) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_win;
                    end
                end
            elseif tiger_side==side.right
                if (A.action_your==response.listen) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_L;
                    end
                elseif (A.action_your==response.listen) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_loose;
                    end
                elseif (A.action_your==response.listen) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.L_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.L_win;
                    end
                end
                if (A.action_your==response.openleft) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_L;
                    end
                elseif (A.action_your==response.openleft) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_loose;
                    end
                elseif (A.action_your==response.openleft) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.win_win;
                    end
                end
                if (A.action_your==response.openright) && (A.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_L;
                    end
                elseif (A.action_your==response.openright) && (A.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_loose;
                    end
                elseif (A.action_your==response.openright) && (A.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        A.reward = reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        A.reward = reward.friend.loose_win;
                    end
                end
            end
        end
        %
        if strcmp(tt_version,'single')
            count_iterations = count_iterations_A;
            prob.vector.growl_correctness = prob.vector.growl_correctness_A;
        end
        if (prob.vector.growl_correctness(count_iterations)==1) % correct action to show
            if (A.action_your==response.listen)
                A.growl_side = tiger_side;
            end
            if (A.action_your==response.listen) && (tiger_side==side.left)
                image.name = image.door_highlight_tiger_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_gold_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
            end
            if (A.action_your==response.listen) && (tiger_side==side.right)
                image.name = image.door_highlight_gold_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_tiger_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
            end
            % reward
            if temp_o_action_performed.A == 0
                if strcmp(tt_version,'single')
                    image.name = image.reward.single.default;
                elseif ~strcmp(tt_version,'single')
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.default;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.default;
                    end
                end
                image.loc = rect.rew.l;
                sk_psy_make_rew_image(image,window);
            end
        end
        if (A.action_your == response.openleft) || (A.action_your == response.openright)
            temp_o_action_performed.A = 1;
        end
        if strcmp(tt_version,'single')
            tiger_side = tiger_side_A;
            gold_side = gold_side_A;
        end
        if (A.action_your == response.openleft) && (tiger_side==side.left)
            image.name = image.door_tiger_l;
            image.loc = rect.pic_l.l_open;
            sk_psy_make_image(image,window);
            image.name = image.door_closed_r;
            image.loc = rect.pic_l.r;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.loose;
            elseif ~strcmp(tt_version,'single')
                if A.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_L;
                    end
                end
                if A.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_loose;
                    end
                end
                if A.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_win;
                    end
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
        end
        if (A.action_your == response.openleft) && (tiger_side==side.right)
            image.name = image.door_gold_l;
            image.loc = rect.pic_l.l_open;
            sk_psy_make_image(image,window);
            image.name = image.door_closed_r;
            image.loc = rect.pic_l.r;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.win;
            elseif ~strcmp(tt_version,'single')
                if A.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_L;
                    end
                end
                if A.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_win;
                    end
                end
                if A.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_loose;
                    end
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
        end
        if (A.action_your == response.openright) && (tiger_side==side.left)
            image.name = image.door_closed_l;
            image.loc = rect.pic_l.l;
            sk_psy_make_image(image,window);
            image.name = image.door_gold_r;
            image.loc = rect.pic_l.r_open;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.win;
            elseif ~strcmp(tt_version,'single')
                if A.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_L;
                    end
                end
                if A.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_win;
                    end
                end
                if A.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_loose;
                    end
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
        end
        if (A.action_your == response.openright) && (tiger_side==side.right)
            image.name = image.door_closed_l;
            image.loc = rect.pic_l.l;
            sk_psy_make_image(image,window);
            image.name = image.door_tiger_r;
            image.loc = rect.pic_l.r_open;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.loose;
            elseif ~strcmp(tt_version,'single')
                if A.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_L;
                    end
                end
                if A.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_win;
                    end
                end
                if A.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_loose;
                    end
                end
            end
            image.loc = rect.rew.l;
            sk_psy_make_rew_image(image,window);
        end
        if (prob.vector.growl_correctness(count_iterations)==0) % wrong action to show
            if (A.action_your==response.listen)
                A.growl_side = gold_side;
            end
            if (A.action_your==response.listen) && (tiger_side==side.left)
                image.name = image.door_highlight_gold_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_tiger_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
            end
            if (A.action_your==response.listen) && (tiger_side==side.right)
                image.name = image.door_highlight_tiger_l;
                image.loc = rect.pic_l.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_gold_r;
                image.loc = rect.pic_l.r;
                sk_psy_make_image(image,window);
            end
            % reward
            if temp_o_action_performed.A == 0
                if strcmp(tt_version,'single')
                    image.name = image.reward.single.default;
                elseif ~strcmp(tt_version,'single')
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.default;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.default;
                    end
                end
                image.loc = rect.rew.l;
                sk_psy_make_rew_image(image,window);
            end
        end
        % for participant B
        % reward calculation
        if strcmp(tt_version,'single')
            tiger_side = tiger_side_B;
            gold_side = gold_side_B;
        end
        if strcmp(tt_version,'single')
            if tiger_side_B==side.left
                if B.action_your==response.listen
                    B.reward = reward.single.L;
                elseif B.action_your==response.openleft
                    B.reward = reward.single.loose;
                elseif B.action_your==response.openright
                    B.reward = reward.single.win;
                end
            end
            if tiger_side_B==side.right
                if B.action_your==response.listen
                    B.reward = reward.single.L;
                elseif B.action_your==response.openleft
                    B.reward = reward.single.win;
                elseif B.action_your==response.openright
                    B.reward = reward.single.loose;
                end
            end
        elseif ~strcmp(tt_version,'single')
            if tiger_side==side.left
                if (B.action_your==response.listen) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_L;
                    end
                elseif (B.action_your==response.listen) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_loose;
                    end
                elseif (B.action_your==response.listen) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_win;
                    end
                end
                if (B.action_your==response.openleft) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_L;
                    end
                elseif (B.action_your==response.openleft) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_loose;
                    end
                elseif (B.action_your==response.openleft) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_win;
                    end
                end
                if (B.action_your==response.openright) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_L;
                    end
                elseif (B.action_your==response.openright) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_loose;
                    end
                elseif (B.action_your==response.openright) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_win;
                    end
                end
            elseif tiger_side==side.right
                if (B.action_your==response.listen) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_L;
                    end
                elseif (B.action_your==response.listen) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_loose;
                    end
                elseif (B.action_your==response.listen) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.L_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.L_win;
                    end
                end
                if (B.action_your==response.openleft) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_L;
                    end
                elseif (B.action_your==response.openleft) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_loose;
                    end
                elseif (B.action_your==response.openleft) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.win_win;
                    end
                end
                if (B.action_your==response.openright) && (B.action_partner==response.listen)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_L;
                    end
                elseif (B.action_your==response.openright) && (B.action_partner==response.openright)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_loose;
                    end
                elseif (B.action_your==response.openright) && (B.action_partner==response.openleft)
                    if strcmp(setting,'enemy')
                        B.reward = reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        B.reward = reward.friend.loose_win;
                    end
                end
            end
        end
        %
        if strcmp(tt_version,'single')
            count_iterations = count_iterations_B;
            prob.vector.growl_correctness = prob.vector.growl_correctness_B;
        end
        if (prob.vector.growl_correctness(count_iterations)==1) % correct action to show
            if (B.action_your==response.listen)
                B.growl_side = tiger_side;
            end
            if (B.action_your==response.listen) && (tiger_side==side.left)
                image.name = image.door_highlight_tiger_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_gold_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
            end
            if (B.action_your==response.listen) && (tiger_side==side.right)
                image.name = image.door_highlight_gold_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_tiger_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
            end
            % reward
            if temp_o_action_performed.B == 0
                if strcmp(tt_version,'single')
                    image.name = image.reward.single.default;
                elseif ~strcmp(tt_version,'single')
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.default;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.default;
                    end
                end
                image.loc = rect.rew.r;
                sk_psy_make_rew_image(image,window);
            end
        end
        if (B.action_your == response.openleft) || (B.action_your == response.openright)
            temp_o_action_performed.B = 1;
        end
        if (B.action_your == response.openleft) && (tiger_side==side.left)
            image.name = image.door_tiger_l;
            image.loc = rect.pic_r.l_open;
            sk_psy_make_image(image,window);
            image.name = image.door_closed_r;
            image.loc = rect.pic_r.r;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.loose;
            elseif ~strcmp(tt_version,'single')
                if B.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_L;
                    end
                end
                if B.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_loose;
                    end
                end
                if B.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_win;
                    end
                end
            end
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
        end
        if (B.action_your == response.openleft) && (tiger_side==side.right)
            image.name = image.door_gold_l;
            image.loc = rect.pic_r.l_open;
            sk_psy_make_image(image,window);
            image.name = image.door_closed_r;
            image.loc = rect.pic_r.r;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.win;
            elseif ~strcmp(tt_version,'single')
                if B.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_L;
                    end
                end
                if B.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_loose;
                    end
                end
                if B.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_win;
                    end
                end
            end
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
        end
        if (B.action_your == response.openright) && (tiger_side==side.left)
            image.name = image.door_closed_l;
            image.loc = rect.pic_r.l;
            sk_psy_make_image(image,window);
            image.name = image.door_gold_r;
            image.loc = rect.pic_r.r_open;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.win;
            elseif ~strcmp(tt_version,'single')
                if B.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_L;
                    end
                end
                if B.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_loose;
                    end
                end
                if B.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.win_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.win_win;
                    end
                end
            end
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
        end
        if (B.action_your == response.openright) && (tiger_side==side.right)
            image.name = image.door_closed_l;
            image.loc = rect.pic_r.l;
            sk_psy_make_image(image,window);
            image.name = image.door_tiger_r;
            image.loc = rect.pic_r.r_open;
            sk_psy_make_image(image,window);
            % reward
            if strcmp(tt_version,'single')
                image.name = image.reward.single.loose;
            elseif ~strcmp(tt_version,'single')
                if B.action_partner == response.listen
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_L;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_L;
                    end
                end
                if B.action_partner == response.openright
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_loose;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_loose;
                    end
                end
                if B.action_partner == response.openleft
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.loose_win;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.loose_win;
                    end
                end
            end
            image.loc = rect.rew.r;
            sk_psy_make_rew_image(image,window);
        end
        if (prob.vector.growl_correctness(count_iterations)==0) % wrong action to show
            if (B.action_your==response.listen)
                B.growl_side = gold_side;
            end
            if (B.action_your==response.listen) && (tiger_side==side.left)
                image.name = image.door_highlight_gold_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_tiger_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
            end
            if (B.action_your==response.listen) && (tiger_side==side.right)
                image.name = image.door_highlight_tiger_l;
                image.loc = rect.pic_r.l;
                sk_psy_make_image(image,window);
                image.name = image.door_highlight_gold_r;
                image.loc = rect.pic_r.r;
                sk_psy_make_image(image,window);
            end
            % reward
            if temp_o_action_performed.B == 0
                if strcmp(tt_version,'single')
                    image.name = image.reward.single.default;
                elseif ~strcmp(tt_version,'single')
                    if strcmp(setting,'enemy')
                        image.name = image.reward.enemy.default;
                    elseif strcmp(setting,'friend')
                        image.name = image.reward.friend.default;
                    end
                end
                image.loc = rect.rew.r;
                sk_psy_make_rew_image(image,window);
            end
            %             end
        end
        % heading
        %         DrawFormattedText(window, heading_text, temp_xl,temp_yl, colour.white);
        %         DrawFormattedText(window, heading_text, temp_xr,temp_yr, colour.white);
        % dots
        
        if temp_o_action_performed.A == 1
            % show the participant the cumulative reward when they open door
            % A.reward_relative + A.reward; % cumulative reward until that point
            %             temp_num = numel(num2str(A.reward_relative+A.reward+A.reward_cumulative));
            %             DrawFormattedText(window, strcat('\n',num2str(A.reward_relative+A.reward+A.reward_cumulative)), cum_rew_l.xpos(temp_num), cum_rew_l.ypos(temp_num)+dot.size, colour.white);
            temp_num = numel(num2str(A.reward+A.reward_cumulative));
            DrawFormattedText(window, strcat('\n',num2str(A.reward+A.reward_cumulative)), cum_rew_l.xpos(temp_num), cum_rew_l.ypos(temp_num)+dot.size, colour.white);
            clear temp_num
        end
        Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
        if temp_o_action_performed.B == 1
            temp_num = numel(num2str(B.reward+B.reward_cumulative));
            DrawFormattedText(window, strcat('\n',num2str(B.reward+B.reward_cumulative)), cum_rew_r.xpos(temp_num), cum_rew_r.ypos(temp_num)+dot.size, colour.white);
            clear temp_num
        end
        Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
        if delay_test % at result your
            Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
        end
        Screen('Flip', window);
        time.count = GetSecs;
    end
    % 0 for opening door
    if A.action_your ~= response.listen
        A.growl_side = 0;
    end
    if B.action_your ~= response.listen
        B.growl_side = 0;
    end
    % for growl correctness
    if strcmp(tt_version,'single')
        if A.growl_side == tiger_side_A
            A.growl_correct = 1;
        else
            A.growl_correct = 0;
        end
        if B.growl_side == tiger_side_B
            B.growl_correct = 1;
        else
            B.growl_correct = 0;
        end
    elseif ~strcmp(tt_version,'single')
        if A.growl_side == tiger_side
            A.growl_correct = 1;
        else
            A.growl_correct = 0;
        end
        if B.growl_side == tiger_side
            B.growl_correct = 1;
        else
            B.growl_correct = 0;
        end
    end
    %     KbStrokeWait;
    WaitSecs(wait_time);
    %
    Screen('FillRect', window, colour.black);
    image.name = image.door_closed_l;
    image.loc = rect.pic_l.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_l.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    image.name = image.door_closed_l;
    image.loc = rect.pic_r.l;
    sk_psy_make_image(image,window)
    image.name = image.door_closed_r;
    image.loc = rect.pic_r.r;
    sk_psy_make_image(image,window);
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    if strcmp(tt_version,'single')
        image.name = image.reward.single.default;
    elseif ~strcmp(tt_version,'single')
        if strcmp(setting,'enemy')
            image.name = image.reward.enemy.default;
        elseif strcmp(setting,'friend')
            image.name = image.reward.friend.default;
        end
    end
    image.loc = rect.rew.l;
    sk_psy_make_rew_image(image,window);
    image.loc = rect.rew.r;
    sk_psy_make_rew_image(image,window);
    Screen('Flip', window);
    %%% trigger part %%%
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_evidence_own));
    end
    %%%%%%%%%%%%%%%%%%%%
    WaitSecs(wait_time+randi(fluct_ms,1,1)/1000); % plus random 300 ms fluctuation
    %
    % relative reward
    A.reward_relative = A.reward_relative + A.reward;
    B.reward_relative = B.reward_relative + B.reward;
    % cumulative reward
    A.reward_cumulative = A.reward_cumulative + A.reward;
    B.reward_cumulative = B.reward_cumulative + B.reward;
    %
    %% structuring the output
    if strcmp(tt_version,'single')
        participant_A = [participant_A;A.sub_id,A.setting,A.session,A.trial_your,A.tiger_side,A.growl_side,A.growl_correct,A.action_your,A.action_your_rt,A.forced_action_listen,A.reward,A.reward_relative,A.reward_cumulative];
        participant_B = [participant_B;B.sub_id,B.setting,B.session,B.trial_your,B.tiger_side,B.growl_side,B.growl_correct,B.action_your,B.action_your_rt,B.forced_action_listen,B.reward,B.reward_relative,B.reward_cumulative];
    elseif ~strcmp(tt_version,'single')
        participant_A = [participant_A;A.sub_id,A.setting,A.session,A.trial_univ,A.trial_your,A.trial_partner,A.tiger_side,A.growl_side,A.growl_correct,A.creek_side,A.creek_correct,A.action_your,A.action_your_rt,A.prediction,A.prediction_rt,A.action_partner,A.action_partner_rt,B.prediction,B.prediction_rt,A.forced_action_listen,A.forced_prediction_listen,A.prediction_correct,A.reward,A.reward_relative,A.reward_cumulative,B.reward,B.reward_relative,B.reward_cumulative];
        participant_B = [participant_B;B.sub_id,B.setting,B.session,B.trial_univ,B.trial_your,B.trial_partner,B.tiger_side,B.growl_side,B.growl_correct,B.creek_side,B.creek_correct,B.action_your,B.action_your_rt,B.prediction,B.prediction_rt,B.action_partner,B.action_partner_rt,A.prediction,A.prediction_rt,B.forced_action_listen,B.forced_prediction_listen,B.prediction_correct,B.reward,B.reward_relative,B.reward_cumulative,A.reward,A.reward_relative,A.reward_cumulative];
    end
    %% trial counts
    % personal
    if A.action_your ~= response.listen
        A.trial_your = A.trial_your + 1;
    end
    if B.action_your ~= response.listen
        B.trial_your = B.trial_your + 1;
    end
    if ~strcmp(tt_version,'single')
        A.trial_partner = B.trial_your;
        B.trial_partner = A.trial_your;
    end
    % to reshuffle the probabilities
    if strcmp(tt_version,'single')
        if count_iterations_A==num_trials
            prob.vector.growl_correctness_A = prob.vector.growl_correctness_A(randperm(length(prob.vector.growl_correctness_A)));
            count_iterations_A = 0;
        end
        if count_iterations_B==num_trials
            prob.vector.growl_correctness_B = prob.vector.growl_correctness_B(randperm(length(prob.vector.growl_correctness_B)));
            count_iterations_B = 0;
        end
    end
    if ~strcmp(tt_version,'single')
        if count_iterations==num_trials
            if ~strcmp(tt_version,'single')
                prob.vector.creek_correctness = prob.vector.creek_correctness(randperm(length(prob.vector.creek_correctness)));
            end
            prob.vector.growl_correctness = prob.vector.growl_correctness(randperm(length(prob.vector.growl_correctness)));
            count_iterations = 0;
        end
    end
    % overall
    if strcmp(tt_version,'single')
        if A.action_your~=response.listen
            loop_trial_A = loop_trial_A+1;
            % shuffling probabilities
            count_iterations_A = 0;
            prob.vector.growl_correctness_A = prob.vector.growl_correctness_A(randperm(length(prob.vector.growl_correctness_A)));
            % random tiger and gold side only if the loop_trial is changed / if door is opened
            tiger_side_A = datasample(side.vector,1);
            gold_side_A = side.vector(side.vector~=tiger_side_A);
            % relative reward is set to zero
            A.reward_relative = 0;
        end
        if B.action_your~=response.listen
            loop_trial_B = loop_trial_B+1;
            % shuffling probabilities
            count_iterations_B = 0;
            prob.vector.growl_correctness_B = prob.vector.growl_correctness_B(randperm(length(prob.vector.growl_correctness_B)));
            % random tiger and gold side only if the loop_trial is changed / if door is opened
            tiger_side_B = datasample(side.vector,1);
            gold_side_B = side.vector(side.vector~=tiger_side_B);
            % relative reward is set to zero
            B.reward_relative = 0;
        end
        if (A.action_your~=response.listen) || (B.action_your~=response.listen)  % if open action is performed
            loop_trial = min(loop_trial_A,loop_trial_B);
        end
    elseif ~strcmp(tt_version,'single')
        if (A.action_your~=response.listen) || (B.action_your~=response.listen)  % if open action is performed
            loop_trial = loop_trial+1;
            % shuffling probabilities
            count_iterations = 0;
            prob.vector.creek_correctness = prob.vector.creek_correctness(randperm(length(prob.vector.creek_correctness)));
            prob.vector.growl_correctness = prob.vector.growl_correctness(randperm(length(prob.vector.growl_correctness)));
            % random tiger and gold side only if the loop_trial is changed / if door is opened
            tiger_side = datasample(side.vector,1);
            gold_side = side.vector(side.vector~=tiger_side);
            % relative reward is set to zero
            A.reward_relative = 0;
            B.reward_relative = 0;
        end
    end
end


%% ending the experiment sequence
temp_text = 'Vielen Dank!';
skstr.window = window;
skstr.temp_text = temp_text;
skstr.loc_x = center.xr;
skstr.loc_y = center.y;
skstr.c_background = colour.black;
skstr.c_foreground = colour.white;
[temp_xr,temp_yr]=sk_center_cood(skstr);
skstr.temp_text = temp_text;
skstr.loc_x = center.xl;
[temp_xl,temp_yl]=sk_center_cood(skstr);
DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
Screen('Flip', window);
if get_screenshot
    % get image
    imwrite(Screen('GetImage', window), 'image_thank_you.jpg');
end
clear temp_text
% sequences end trigger
% disp('now seq strart');
if ttsk.trig.wanted
    IOPort('Write', handle, uint8(ttsk.trig.end_sequence));
end
WaitSecs(wait_time+wait_time);


%% Slider section (ask the two questions)
if ~strcmp(tt_version,'single')
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_questions));
    end
    ttsk.questions.enemy_1 = 'Wie sehr hast du versucht mehr als die andere Person zu gewinnen?';
    ttsk.questions.enemy_2 = 'Wie gut ist es dir gelungen mehr als die andere Person zu gewinnen?';
    ttsk.questions.friend_1 = 'Wie sehr hast du versucht dich mit der anderen Person zu koordinieren?';
    ttsk.questions.friend_2 = 'Wie gut ist es dir gelungen dich mit der anderen Person zu koordinieren?';
    lineWidth = 4;
    lineLength = 20;
    range_length = 100;
    %
    rating_A = nan(1,numel(fieldnames(ttsk.questions))/2);
    rating_B = nan(1,numel(fieldnames(ttsk.questions))/2);
    for loop_questions = 1:numel(fieldnames(ttsk.questions))/2
        heading_text = eval(strcat('ttsk.questions.',setting,'_',num2str(loop_questions)));
        heading_text = WrapString(heading_text,20);
        [temp_xr,temp_yr,temp_xl,temp_yl] = sk_double_headings(heading_text,window,center,colour);
        DrawFormattedText(window, heading_text, temp_xl,temp_yl, colour.white);
        DrawFormattedText(window, heading_text, temp_xr,temp_yr, colour.white);
        %
        horzLine_A = [center.xl_l-rect.xl center.yl center.xl_r+rect.xl center.yl];
        midTick_A    = [center.xl center.yl-lineLength center.xl center.yl+lineLength];
        leftTick_A    = [center.xl_l-rect.xl center.yl-lineLength center.xl_l-rect.xl center.yl+lineLength];
        rightTick_A    = [center.xl_r+rect.xl center.yl-lineLength center.xl_r+rect.xl center.yl+lineLength];
        horzLine_B = [center.xr_l-rect.xl center.yr center.xr_r+rect.xl center.yr];
        midTick_B    = [center.xr center.yr-lineLength center.xr center.yr+lineLength];
        leftTick_B    = [center.xr_l-rect.xl center.yr-lineLength center.xr_l-rect.xl center.yr+lineLength];
        rightTick_B    = [center.xr_r+rect.xl center.yr-lineLength center.xr_r+rect.xl center.yr+lineLength];
        range_A = [leftTick_A(1) : (rightTick_A(1)-leftTick_A(1))/range_length : rightTick_A(1)-(rightTick_A(1)-leftTick_A(1))/range_length];
        range_B = [leftTick_B(1) : (rightTick_B(1)-leftTick_B(1))/range_length : rightTick_B(1)-(rightTick_B(1)-leftTick_B(1))/range_length];
        %
        flag_A = 0;
        flag_B = 0;
        temp_slide_value_A = midTick_A(1);
        temp_slide_value_B = midTick_B(1);
        temp_slide_value_jump = 10;
        temp_colour_A = dot.colour_your;
        temp_colour_B = dot.colour_your;
        while (flag_A==0) || (flag_B==0)
            if flag_A == 0
                [~,~ , keyCode] = KbCheck;
                if keyCode(A.key.openleft)
                    temp_slide_value_A = temp_slide_value_A-temp_slide_value_jump;
                    if temp_slide_value_A < leftTick_A(1)
                        temp_slide_value_A = leftTick_A(1);
                    end
                end
                if keyCode(A.key.openright)
                    temp_slide_value_A = temp_slide_value_A+temp_slide_value_jump;
                    if temp_slide_value_A > rightTick_A(1)
                        temp_slide_value_A = rightTick_A(1);
                    end
                end
                if keyCode(A.key.listen)
                    flag_A = 1;
                    [~, rating_A(loop_questions)] = min(abs(range_A-temp_slide_value_A));
                    temp_colour_A = colour.white;
                end
            end
            if flag_B == 0
                [~,~ , keyCode] = KbCheck;
                if keyCode(B.key.openleft)
                    temp_slide_value_B = temp_slide_value_B-temp_slide_value_jump;
                    if temp_slide_value_B < leftTick_B(1)
                        temp_slide_value_B = leftTick_B(1);
                    end
                end
                if keyCode(B.key.openright)
                    temp_slide_value_B = temp_slide_value_B+temp_slide_value_jump;
                    if temp_slide_value_B > rightTick_B(1)
                        temp_slide_value_B = rightTick_B(1);
                    end
                end
                if keyCode(B.key.listen)
                    flag_B = 1;
                    [~, rating_B(loop_questions)] = min(abs(range_B-temp_slide_value_B));
                    temp_colour_B = colour.white;
                end
            end
            % heading
            DrawFormattedText(window, heading_text, temp_xl,temp_yl, colour.white);
            DrawFormattedText(window, heading_text, temp_xr,temp_yr, colour.white);
            % for participant A
            Screen('DrawLine',window,colour.white,midTick_A(1), midTick_A(2), midTick_A(3), midTick_A(4),lineWidth);% Mid tick
            Screen('DrawLine',window,colour.white,leftTick_A(1), leftTick_A(2), leftTick_A(3), leftTick_A(4),lineWidth);% left tick
            Screen('DrawLine',window,colour.white,rightTick_A(1), rightTick_A(2), rightTick_A(3), rightTick_A(4),lineWidth);% right tick
            Screen('DrawLine',window,colour.white,horzLine_A(1), horzLine_A(2), horzLine_A(3), horzLine_A(4),lineWidth); % Horizontal line
            Screen('DrawLine',window,temp_colour_A,temp_slide_value_A, midTick_A(2), temp_slide_value_A, midTick_A(4),lineWidth);% slider tick
            % for participant B
            Screen('DrawLine',window,colour.white,midTick_B(1), midTick_B(2), midTick_B(3), midTick_B(4),lineWidth);% Mid tick
            Screen('DrawLine',window,colour.white,leftTick_B(1), leftTick_B(2), leftTick_B(3), leftTick_B(4),lineWidth);% left tick
            Screen('DrawLine',window,colour.white,rightTick_B(1), rightTick_B(2), rightTick_B(3), rightTick_B(4),lineWidth);% right tick
            Screen('DrawLine',window,colour.white,horzLine_B(1), horzLine_B(2), horzLine_B(3), horzLine_B(4),lineWidth); % Horizontal line
            Screen('DrawLine',window,temp_colour_B,temp_slide_value_B, midTick_B(2), temp_slide_value_B, midTick_B(4),lineWidth);% slider tick
            if delay_test % at questions
                Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
            end
            Screen('Flip', window);
        end
        if get_screenshot
            % get image
            imwrite(Screen('GetImage', window), strcat('image_question_',num2str(loop_questions),'.jpg'));
        end
        WaitSecs(wait_time);
    end
    clear temp_text flag_A flag_B temp_slide_value_A temp_slide_value_B temp_slide_value_jump range_A range_B range_length temp_colour_A temp_colour_B
    ttsk.questions.rating_A = rating_A;
    ttsk.questions.rating_B = rating_B;
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_questions));
    end
end
WaitSecs(wait_time+wait_time);


%% resting state section after session over
if resting_state
    %%%%% EYES OPEN
    temp_text = 'Augen offen lassen';
    skstr.window = window;
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xr;
    skstr.loc_y = center.y;
    skstr.c_background = colour.black;
    skstr.c_foreground = colour.white;
    [temp_xr,temp_yr]=sk_center_cood(skstr);
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xl;
    [temp_xl,temp_yl]=sk_center_cood(skstr);
    DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
    DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
    Screen('Flip', window);
    WaitSecs(rs_time);    
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    if delay_test % at eyes open
        Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
    end
    Screen('Flip', window);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_eyes_open));
    end
    WaitSecs(rs_duration);
    
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_eyes_open));
    end
    %
    %%%%% EYES CLOSE
    temp_text = 'Augen schlieﬂen';
    skstr.window = window;
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xr;
    skstr.loc_y = center.y;
    skstr.c_background = colour.black;
    skstr.c_foreground = colour.white;
    [temp_xr,temp_yr]=sk_center_cood(skstr);
    skstr.temp_text = temp_text;
    skstr.loc_x = center.xl;
    [temp_xl,temp_yl]=sk_center_cood(skstr);
    DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
    DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
    Screen('Flip', window);
    WaitSecs(rs_time);
    Screen('DrawDots', window, [center.xr center.yr], dot.size, dot.colour_default, [], 2);
    Screen('DrawDots', window, [center.xl center.yl], dot.size, dot.colour_default, [], 2);
    if delay_test % at eyse closed
        Screen('FillRect', window, colour.diode, [windowSize(1) windowSize(4)*ttsk.scr_ratio_white windowSize(3) windowSize(4)]);
    end
    Screen('Flip', window);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.start_eyes_closed));
    end
    WaitSecs(rs_duration);
    if ttsk.trig.wanted
        IOPort('Write', handle, uint8(ttsk.trig.end_eyes_closed));
    end
    clear temp_text
end
WaitSecs(wait_time);
%
%% ending the experiment display
temp_text = 'Vielen Dank!';
skstr.window = window;
skstr.temp_text = temp_text;
skstr.loc_x = center.xr;
skstr.loc_y = center.y;
skstr.c_background = colour.black;
skstr.c_foreground = colour.white;
[temp_xr,temp_yr]=sk_center_cood(skstr);
skstr.temp_text = temp_text;
skstr.loc_x = center.xl;
[temp_xl,temp_yl]=sk_center_cood(skstr);
DrawFormattedText(window, temp_text, temp_xl,temp_yl, colour.white);
DrawFormattedText(window, temp_text, temp_xr,temp_yr, colour.white);
Screen('Flip', window);
clear temp_text


% experimet end trigger
if ttsk.trig.wanted
    IOPort('Write', handle, uint8(ttsk.trig.end_experiment));
end

%% close
WaitSecs(wait_time);
Priority(0);
sca;
%

%% trigger closing
if ttsk.trig.wanted
    IOPort('CloseAll');
end
%
%% saving section
% save_files = 1; % '1' to save , '0' to not save
if save_files
    if exist(data_folder_name,'dir') ~= 7
        mkdir(data_folder_name);
    end
    % file name
    if strcmp(tt_version,'single')
        filename_mat_A = sprintf('tt_single_sub%d_session%d',A.sub_id,A.session);
        filename_mat_B = sprintf('tt_single_sub%d_session%d',B.sub_id,B.session);
    elseif ~strcmp(tt_version,'single')
        if strcmp(setting,'enemy')
            filename_mat_A = sprintf('tt_multi_enemy_sub%d_session%d',A.sub_id,A.session);
            
            filename_mat_B = sprintf('tt_multi_enemy_sub%d_session%d',B.sub_id,B.session);
            
        elseif strcmp(setting,'friend')
            filename_mat_A = sprintf('tt_multi_friend_sub%d_session%d',A.sub_id,A.session);
            
            filename_mat_B = sprintf('tt_multi_friend_sub%d_session%d',B.sub_id,B.session);
            
        end
    end
    % saving the mat format
    out.data = participant_A;
    save(strcat(pwd,'\',data_folder_name,'\',filename_mat_A),'out','ttsk');
    %     if ~strcmp(tt_version,'single')
    out.data = participant_B;
    save(strcat(pwd,'\',data_folder_name,'\',filename_mat_B),'out','ttsk');
    %     end
    %saving the csv format
    filename_csv_A = strcat(pwd,'\',data_folder_name,'\',filename_mat_A,'.csv');
    %     if ~strcmp(tt_version,'single')
    filename_csv_B = strcat(pwd,'\',data_folder_name,'\',filename_mat_B,'.csv');
    %     end
    out.data = participant_A;
    fid = fopen(filename_csv_A, 'w') ;
    fprintf(fid, '%s,', out.definition{1,1:end-1});
    fprintf(fid, '%s\n', out.definition{1,end});
    fclose(fid);
    dlmwrite(filename_csv_A, out.data, '-append');
    %     if ~strcmp(tt_version,'single')
    out.data = participant_B;
    fid = fopen(filename_csv_B, 'w');
    fprintf(fid, '%s,', out.definition{1,1:end-1});
    fprintf(fid, '%s\n', out.definition{1,end});
    fclose(fid);
    dlmwrite(filename_csv_B, out.data, '-append');
    %     end
end

%% output
% just the output
% if strcmp(tt_version,'single')
%     out.data = participant_A;
% end
% if ~strcmp(tt_version,'single')
if save_files
    out = rmfield(out,'data');
end
out.dataA = participant_A;
out.dataB = participant_B;
% end
%
%% functions
    function sk_psy_make_image(image,window)
        image.theImageLocation  = strcat(image.image_folder,image.name);
        image.theImage = imread(image.theImageLocation);
        image.image_loc = image.loc;
        image.imageTexture = Screen('MakeTexture', window, image.theImage);
        Screen('DrawTexture', window, image.imageTexture, [], image.image_loc, 0);
        % to clear the texture space
        Screen('Close');
    end

    function sk_psy_make_rew_image(image,window)
        image.theImageLocation  = strcat(image.image_folder,image.name);
        image.theImage = imread(image.theImageLocation);
        image.image_loc = image.loc;
        temp_image = image.theImage;
        above = find(temp_image(:,1,1)>200); % find whites above
        rside = find(temp_image(max(above)+1,:,1)>200); % find whites on the right side
        temp_image(above,:,1:size(temp_image,3)) = 0;% replace the above white with the black
        temp_image(:,rside,1:size(temp_image,3)) = 0;% replace the right side white with black
        above = find(temp_image(:,round(size(temp_image,2)/2),1)>200); % find whites above (matrix)
        rside = find(temp_image(round(size(temp_image,1)/2),:,1)>200); % find whites on the right side (matrix)
        % making image equal all sides for better postitioning
        temp_image(size(temp_image,1)+(above(1)-(size(temp_image,1)-above(end))),size(temp_image,2)+(rside(1)-(size(temp_image,2)-rside(end))),size(temp_image,3)) = 0;
        image.theImage = temp_image;
        image.imageTexture = Screen('MakeTexture', window, image.theImage);
        Screen('DrawTexture', window, image.imageTexture, [], image.image_loc, 0);
    end

    function [temp_xr,temp_yr,temp_xl,temp_yl] = sk_double_heading(text,window,center,colour)
        skstr_in.window = window;
        skstr_in.temp_text = text;
        skstr_in.loc_x = center.xr;
        skstr_in.loc_y = center.yr/3 ;
        skstr_in.c_background = colour.black;
        skstr_in.c_foreground = colour.white;
        [temp_xr,temp_yr]=sk_center_cood(skstr_in);
        skstr_in.temp_text = text;
        skstr_in.loc_x = center.xl;
        skstr_in.loc_y = center.yr/3;
        [temp_xl,temp_yl]=sk_center_cood(skstr_in);
        DrawFormattedText(window, text, temp_xr,temp_yr, colour.white);
        DrawFormattedText(window, text, temp_xl,temp_yl, colour.white);
    end

    function [temp_x,temp_y]=sk_center_cood(skstr)
        % To print the text centered on the defined location
        % Gives out the adjusted x and y coordinate to print the text
        % getting the size of the text
        [temp_x,temp_y,~]=DrawFormattedText(skstr.window, skstr.temp_text, skstr.loc_x,skstr.loc_y, skstr.c_background);
        Screen('Flip', skstr.window);
        % centering the location
        temp_x = skstr.loc_x-(temp_x - skstr.loc_x)/2;
    end

    function [temp_xr,temp_yr,temp_xl,temp_yl] = sk_double_headings(text,window,center,colour)
        skstr_in.window = window;
        skstr_in.temp_text = text;
        skstr_in.loc_x = center.xr;
        skstr_in.loc_y = center.yr/3 ;
        skstr_in.c_background = colour.black;
        skstr_in.c_foreground = colour.white;
        [temp_xr,temp_yr]=sk_center_cood(skstr_in);
        skstr_in.temp_text = text;
        skstr_in.loc_x = center.xl;
        skstr_in.loc_y = center.yr/3;
        [temp_xl,temp_yl]=sk_center_cood(skstr_in);
        DrawFormattedText(window, text, temp_xr,temp_yr, colour.white);
        DrawFormattedText(window, text, temp_xl,temp_yl, colour.white);
    end


end