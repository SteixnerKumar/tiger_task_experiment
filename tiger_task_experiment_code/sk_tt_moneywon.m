function [final_rew] = sk_tt_moneywon(participant_id,setting,session_no)
%
% USAGE
% ______________________________________________________
% sk_tt_moneywon(participant_id,setting,session_no)
% ______________________________________________________
%
% ______________________________________________________
% INPUT
% participant_id : The participant id number used in the multiplayer version
% setting : the enemy or the feriend setting used
% session_no : the correct session for which the calculation needs to be made
% ______________________________________________________
% author: Saurabh Steixner-Kumar (s.steixner-kumar@uke.de)
%

% check for all sessions and see which is the most. Pay that (only for the multienemy and multifriend)
% calculating the bonus money won for this particular session
% its for 10 trials


%% basics (parameters to set in case one wants to run without the function call)
% participant_id = 12000;
% setting = 'enemy'; % % 'enemy', 'friend'
% session_no = 1;



%%
file_name = strcat('tt_multi_',setting,'_sub',num2str(participant_id),'_session',num2str(session_no),'.mat');
%file_name = strcat(pwd,'\',file_name);
load(file_name);


% PUNISHMENT for wrong door open in money
num_sessions = 1;
total_bonus = 5; % 5 is default

% single_player, multi_player ? 
% total bonus per session
bonus_amt = total_bonus/num_sessions;

% Positive score at the end of session you dont loose anything
% Negative score at the end of session you loose according to the formula below

% single player
%-100 * 10 (10 trials) is the maximum to loose || 10 * 10 (10 trials) is the maximum to win
%thats, 10EUR/1000 -> 0.01 EUR per point (for 10 EUR) || 10EUR/100 -> 0.1 EUR per point (for 10 EUR)
%
% Enemy setting
%-105*10 is max to loose || 60*10 is max to win
%thats, 10EUR/1050 -> 0.0095 EUR per point || 
%
% Friend setting
%-150*10 is max to loose || 15*10 is max to win
%thats, 10EUR/1500 -> 0.0067 EUR per point
% the points
% % % if strcmp(setting,'single')
% % %     lpnteur = bonus_amt/1000; % for 10 trials
% % %     wpnteur = bonus_amt/100; % for 10 trials
% % % %     pnteur = 0.01;
% % % end

%% the maximums of winning and loosing for 10 trails
total_trials = 10;
% % original matrix
% % enemy_max_loose = 105;
% % enemy_max_win = 60;
% % friend_max_loose = 150;
% % friend_max_win = 15;
% modified matrix
enemy_max_loose = 60;
enemy_max_win = 45;
friend_max_loose = 50;
friend_max_win = 20;

%%

if strcmp(setting,'enemy')
    lpnteur = bonus_amt/(total_trials*enemy_max_loose); % for 10 trials
    wpnteur = bonus_amt/(total_trials*enemy_max_win); % for 10 trials
%     pnteur = 0.0095;
end
if strcmp(setting,'friend')
    lpnteur = bonus_amt/(total_trials*friend_max_loose); % for 10 trials
    wpnteur = bonus_amt/(total_trials*friend_max_win); % for 10 trials
%     pnteur = 0.0067;
end

% getting the column number of cumulative reward
col.cumm_reward = find(strcmp(out.definition(1,:),'reward_cumulative_your'));

% getting the cumulative reward for the session 
temp_rew = out.data(end,col.cumm_reward);

if (temp_rew*lpnteur)<0
    final_rew = round(bonus_amt+(temp_rew*lpnteur),2);
elseif (temp_rew*lpnteur)>0
    final_rew = round(bonus_amt+(temp_rew*wpnteur),2);
elseif (temp_rew*lpnteur)==0
    final_rew = round(bonus_amt,2);
else
    final_rew = 10;
end

% calculating the final reward
if (temp_rew*lpnteur)<0
    fprintf('The bonus amount won: %.2f\n',round(bonus_amt+(temp_rew*lpnteur),2));
elseif (temp_rew*lpnteur)>0
    fprintf('The bonus amount won: %.2f\n',round(bonus_amt+(temp_rew*wpnteur),2));
elseif (temp_rew*lpnteur)==0
    fprintf('The bonus amount won: %.2f\n',round(bonus_amt,2));
else
    fprintf('The bonus amount won: %.2f\n',10);
end

%
%
%

%%




end

