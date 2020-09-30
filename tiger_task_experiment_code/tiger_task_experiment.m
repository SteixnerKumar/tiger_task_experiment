function varargout = tiger_task_experiment(varargin)
% *******************************************************
% ***  The main function to run the entire experiment ***
% *******************************************************
%
% TIGER_TASK_EXPERIMENT MATLAB code for tiger_task_experiment.fig
%      TIGER_TASK_EXPERIMENT, by itself, creates a new TIGER_TASK_EXPERIMENT or raises the existing
%      singleton*.
%
%      H = TIGER_TASK_EXPERIMENT returns the handle to a new TIGER_TASK_EXPERIMENT or the handle to
%      the existing singleton*.
%
%      TIGER_TASK_EXPERIMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIGER_TASK_EXPERIMENT.M with the given input arguments.
%
%      TIGER_TASK_EXPERIMENT('Property','Value',...) creates a new TIGER_TASK_EXPERIMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tiger_task_experiment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tiger_task_experiment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% author:
% Saurabh Steixner-Kumar (s.steixner-kumar@uke.de)
%


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @tiger_task_experiment_OpeningFcn, ...
    'gui_OutputFcn',  @tiger_task_experiment_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before tiger_task_experiment is made visible.
function tiger_task_experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tiger_task_experiment (see VARARGIN)
imshow(strcat(pwd,'\images\title_01.png.'));
% Choose default command line output for tiger_task_experiment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tiger_task_experiment wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% handlesArray_begin = [handles.sessionnumber, handles.sub1, handles.sub2, handles.begin, handles.s_side, handles.money_calculation, handles.exp_over];
% set(handlesArray_begin, 'Enable', 'off');


% --- Outputs from this function are returned to the command line.
function varargout = tiger_task_experiment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function sub1_Callback(hObject, eventdata, handles)
% hObject    handle to sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of sub1 as text
%        str2double(get(hObject,'String')) returns contents of sub1 as a double
set(handles.sub2, 'String', num2str((str2double(get(handles.sub1,'string'))+200)));


% --- Executes during object creation, after setting all properties.
function sub1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in version.
function version_Callback(hObject, eventdata, handles)
% hObject    handle to version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% temp_handlesArray = [handles.s_side];
temp_handlesArray_1 = [handles.money_calculation, handles.exp_over];
str = get(handles.version,'String');
val = get(handles.version,'Value');
if strcmp(str(find(cell2mat(val))),'single player version')
%     set(temp_handlesArray, 'Enable', 'on');
    set(temp_handlesArray_1, 'Enable', 'off');
elseif strcmp(str(find(cell2mat(val))),'multi-compititive version') || strcmp(str(find(cell2mat(val))),'multi-cooperative version')
%     set(temp_handlesArray, 'Enable', 'off');
    set(temp_handlesArray_1, 'Enable', 'on');
end
% Hint: get(hObject,'Value') returns toggle state of version

% --- Executes on selection change in sessionnumber.
function sessionnumber_Callback(hObject, eventdata, handles)
% hObject    handle to sessionnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sessionnumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sessionnumber


% --- Executes during object creation, after setting all properties.
function sessionnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sub2_Callback(hObject, eventdata, handles)
% hObject    handle to sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.sub1, 'String', num2str((str2double(get(handles.sub2,'string'))-200)));
% Hints: get(hObject,'String') returns contents of sub2 as text
%        str2double(get(hObject,'String')) returns contents of sub2 as a double


% --- Executes during object creation, after setting all properties.
function sub2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in money_calculation.
function money_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to money_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handlesArray2 = [handles.sessionnumber, handles.version, handles.sub1, handles.sub2, handles.begin, handles.money_calculation, handles.exp_over];
% some checks
str = get(handles.version,'String');
val = get(handles.version,'Value');
if strcmp(str(find(cell2mat(val))),'single player version')
    set(handlesArray2, 'Enable', 'off');
    uiwait(msgbox('Please select a multi.player version. The bonus calculation is not done for the single-player version', 'Error','error'));
    set(handlesArray2, 'Enable', 'on');
    error('Please select a multi.player version. The bonus calculation is not done for the single-player version');
end
if ~get(handles.exp_over,'value')
    set(handlesArray2, 'Enable', 'off');
    uiwait(msgbox('If experiment is over Please check the "Experiment over" box, then calculate', 'Error','error'));
    set(handlesArray2, 'Enable', 'on');
    error('If experiment is over Please check the "Experiment over" box, then calculate');
end
sub1 = str2double(get(handles.sub1,'string'));
sub2 = str2double(get(handles.sub2,'string'));
str = get(handles.version,'String');
val = get(handles.version,'Value');
if strcmp(str(find(cell2mat(val))),'single player version')
    type = 'single';
elseif strcmp(str(find(cell2mat(val))),'multi-compititive version')
    type = 'enemy';
    temp_sub1 = sub1;%  + 2000;
    temp_sub2 = sub2;%  + 2000;
elseif strcmp(str(find(cell2mat(val))),'multi-cooperative version')
    type = 'friend';
    temp_sub1 = sub1;%  + 3000;
    temp_sub2 = sub2;%  + 3000;
end
% always chek if the folder name is corrrect
folder_name = strcat(pwd,'\data_storage_behaviour\');
addpath(folder_name);
% for sub1
bonus_sub1 = nan(1,100);
count_bonus_sub1 = 0;
for loop_session =  1:6
    temp_file_name = strcat('tt_multi_',type,'_sub',num2str(temp_sub1),'_session',num2str(loop_session),'.mat');
    if exist(temp_file_name, 'file') == 2
        count_bonus_sub1 = count_bonus_sub1+1;
        bonus_sub1(1,count_bonus_sub1) = sk_tt_moneywon(temp_sub1,type,loop_session);
    end
end
bonus_sub1 = bonus_sub1(~isnan(bonus_sub1));
% for sub2
bonus_sub2 = nan(1,100);
count_bonus_sub2 = 0;
for loop_session =  1:6
    temp_file_name = strcat('tt_multi_',type,'_sub',num2str(temp_sub2),'_session',num2str(loop_session),'.mat');
    if exist(temp_file_name, 'file') == 2
        count_bonus_sub2 = count_bonus_sub2+1;
        bonus_sub2(1,count_bonus_sub2) = sk_tt_moneywon(temp_sub2,type,loop_session);
    end
end
bonus_sub2 = bonus_sub2(~isnan(bonus_sub2));
rmpath(folder_name);
if isempty(bonus_sub1) || isempty(bonus_sub2)
    set(handlesArray2, 'Enable', 'off');
    uiwait(msgbox('No recording found. Please check the participant IDs', 'Error','error'));
    set(handlesArray2, 'Enable', 'on');
    error('No recording found. Please check the participant IDs');
end
participant_1_result = sprintf('participant_%d, all bonus: %s',sub1,num2str(bonus_sub1));
participant_2_result = sprintf('participant_%d, all bonus: %s',sub2,num2str(bonus_sub2));
participant_1_bonus = sprintf('participant_%d, WON : %d EUR',sub1,ceil(max(bonus_sub1)))
participant_2_bonus = sprintf('participant_%d, WON : %d EUR',sub2,ceil(max(bonus_sub2)))
participants_result = {participant_1_result,participant_2_result,'','',participant_1_bonus,participant_2_bonus};
set(handles.money_result,'String',participants_result);


% --- Executes during object creation, after setting all properties.
function money_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to money_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in begin.
function begin_Callback(hObject, eventdata, handles)
% hObject    handle to begin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sub1 = str2double(get(handles.sub1,'string'));
sub2 = str2double(get(handles.sub2,'string'));
val = get(handles.sessionnumber,'Value');
str = get(handles.sessionnumber,'String');
session = str2double(str{val});
str = get(handles.version,'String');
val = get(handles.version,'Value');
if strcmp(str(find(cell2mat(val))),'single player version')
    type = 'single';
elseif strcmp(str(find(cell2mat(val))),'multi-compititive version')
    type = 'enemy';
elseif strcmp(str(find(cell2mat(val))),'multi-cooperative version')
    type = 'friend';
end
%
%% Error checks in the input
handlesArray = [handles.sessionnumber, handles.version, handles.sub1, handles.sub2, handles.begin, handles.exp_over, handles.money_calculation];
if isnan(sub1) || isnan(sub2)
    set(handlesArray, 'Enable', 'off');
    uiwait(msgbox('Please check the participant-ID again', 'Error','error'));
    set(handlesArray, 'Enable', 'on');
    error('Please check the participant-ID again');
    %     set(handlesArray, 'Enable', 'off');
elseif isnan(session)
    set(handlesArray, 'Enable', 'off');
    uiwait(msgbox('Please check the session number again', 'Error','error'));
    set(handlesArray, 'Enable', 'on');
    error('Please check the session number again');
    %     set(handlesArray, 'Enable', 'off');
elseif get(handles.exp_over,'Value')==2
    set(handlesArray, 'Enable', 'off');
    uiwait(msgbox('Experiment is over (Its checked). Cant run !', 'Error','error'));
    set(handlesArray, 'Enable', 'on');
    error('Experiment is over (Its checked). Cant run !');
end
%% calling the function to start the experiment
ttsk=[];
ttsk.sub1 = sub1;
ttsk.sub2 = sub2;
ttsk.type = type;
ttsk.session = session;
ttsk.handlesArray = handlesArray;
sk_tt_experiment_wrapper(ttsk);

%% message for success
set(handlesArray, 'Enable', 'off');
% uiwait(msgbox('Operation Completed','Success','modal'));
myicon = imread(strcat(pwd,'\images\welldone_01.png.'));
uiwait(msgbox('Well Done ! ','Success','custom',myicon));
set(handlesArray, 'Enable', 'on');

%%
% --- Executes on button press in exp_over.
function exp_over_Callback(hObject, eventdata, handles)
% hObject    handle to exp_over (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of exp_over



