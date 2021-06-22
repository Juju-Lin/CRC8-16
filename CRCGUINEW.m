
% ===========================
% 开发者：Lim （林政扬）    |  Author: Lim
% 开发时间：2021-04-08      |  Time: 04/08/2021
% 版本：210408.1            |  Version: 210408.1
% ===========================


function varargout = CRCGUI(varargin)
% CRCGUI MATLAB code for CRCGUI.fig
%      CRCGUI, by itself, creates a new CRCGUI or raises the existing
%      singleton*.
%
%      H = CRCGUI returns the handle to a new CRCGUI or the handle to
%      the existing singleton*.
%
%      CRCGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRCGUI.M with the given input arguments.
%
%      CRCGUI('Property','Value',...) creates a new CRCGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRCGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRCGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRCGUI

% Last Modified by GUIDE v2.5 19-Jun-2021 14:50:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRCGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CRCGUI_OutputFcn, ...
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
%
global CRC8;
global CRC16;
global Totaldata;
global BinResult;
global DecResult;
global HexResult;
global OptDeveloper;
global Reck;
global binout;
global language;
OptDeveloper=0;


CRC8=[0 0 0,0 1 1 1];
CRC16=[1 0 0,0 0 0 0, 0 0 0 0,0 1 0 1];
% End initialization code - DO NOT EDIT


% --- Executes just before CRCGUI is made visible.
function CRCGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CRCGUI (see VARARGIN)

% Choose default command line output for CRCGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CRCGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CRCGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in Opt.
function Opt_Callback(hObject, eventdata, handles)
% hObject    handle to Opt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global OptDev;
OptDev= get(handles.Opt,'value');




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode;
global binout;
global OptDev;
% Get data from Input box
data=get(handles.Input,'string');
value=get(handles.Mode,'value');
switch value
    case 1
        mode='CRC8';
    case 2
        mode='CRC16';
    otherwise
        mode='CRC8';
end  

if ~OptDev %non-developer mode
% Calculate
[BinResult,DecResult,HexResult,TranferedData]=RCRmian(data,mode);
binout=strcat(TranferedData,BinResult);
decout=bin2dec(binout);
hexout=strcat('0x',dec2hex(decout));
% Print Binary Box 
set(handles.BinInput,'string',TranferedData);
% Print Output and Redundancy
outputmode=get(handles.OutputMode,'value');
switch outputmode
    case 1
        code=BinResult;
        output=binout;
    case 2
        code=DecResult;
        output=decout;
    case 3
        code=HexResult;
        output=hexout;
    otherwise
        code=BinResult;
        output=binout;
end        
set(handles.Redundancy,'string',code);
set(handles.Output,'string',output);
% Print State
Sentence1=['Inout data are :',data,'        '];
Sentence2=['Redundancy Code are :',code,'        '];
Sentence3=['Output Code are :',output,'        '];

set(handles.State,'string',[Sentence1,Sentence2,Sentence3]);

end

if OptDev %developer mode
    SentenceDev=['Developer Mode is closed! Add us to maintain'];
    set(handles.State,'string',[SentenceDev]);
end




function Input_Callback(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Input as text
%        str2double(get(hObject,'String')) returns contents of Input as a double


% --- Executes during object creation, after setting all properties.
function Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RecheckButton.
function RecheckButton_Callback(hObject, eventdata, handles)
% hObject    handle to RecheckButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Reck;
Reck=get(handles.RecheckButton,'value');


% Hint: get(hObject,'Value') returns toggle state of RecheckButton


% --- Executes on button press in Check.

    




% --- Executes on selection change in Mode.
function Mode_Callback(hObject, eventdata, handles)
% hObject    handle to Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Mode


% --- Executes during object creation, after setting all properties.
function Mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in OutputMode.
function OutputMode_Callback(hObject, eventdata, handles)
% hObject    handle to OutputMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns OutputMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from OutputMode


% --- Executes during object creation, after setting all properties.
function OutputMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% Hint: get(hObject,'Value') returns toggle state of Opt


% --- Executes on button press in Check.
function Check_Callback(hObject, eventdata, handles)
% hObject    handle to Check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global binout;
global mode;
global Reck;
global CRC8;
global CRC16;
SentenceErr1=[''];
if ~Reck
    relay=zeros(1,length(binout));
    for i=1:length(binout)
        relay(i)=str2num(binout(i));
    end
end
if Reck    
    CheckInput=get(handles.Recheck,'string');
    %Judge the input format    
    [CheckCode]=IdentifyInput(CheckInput);
    while ~str2num(CheckCode(1))
        CheckCode(1)=[];
        if isempty(CheckCode) 
            msgbox('Check Data is invalid!');
            error('Check Data is invalid!');
        end
    end

    lenCheCod=length(CheckCode);

    if strcmp(mode,'CRC8')
        
            if lenCheCod<length(CRC8)+1
                % Ensure the length of the check code is longer than Exp's.
                supplynum=length(CRC8)+1-lenCheCod;
                relay=zeros(1,length(CRC8)+1);
                SentenceErr1=['The check code is less than CRC. Automatically add ',num2str(supplynum),...
                    ' zeros after the code to make sure the format is correct!'];
            end
            if lenCheCod>=length(CRC8)+1
                relay=zeros(1,lenCheCod);
            end
    end
            
    if strcmp('CRC16',mode)
        
            if lenCheCod<length(CRC16)+1
            % Ensure the length of the check code is longer than Exp's.
                supplynum=length(CRC16)+1-lenCheCod;
                relay=zeros(1,length(CRC16)+1);
                SentenceErr1=['The check code is less than CRC. Automatically add ',num2str(supplynum),...
                    ' zeros after the code to make sure the format is correct!'];
            end
            if lenCheCod>=length(CRC16)+1
                relay=zeros(1,lenCheCod);
            end
    end
    
           
    for i=1:lenCheCod
        relay(i)=str2num(CheckCode(i));
    end
end 
[BinRecovery,DecRecovery,HexRecovery]=CheckResult(relay,mode);
set(handles.Recovery,'string',BinRecovery);
%print state
if str2num(BinRecovery)==0
    Sentence4=['The Check Result is Correct!'];
else
    Sentence4=['The Check Result is Wrong!'];
end
set(handles.State,'string',[SentenceErr1,'               ',Sentence4]);



function Recheck_Callback(hObject, eventdata, handles)
% hObject    handle to Recheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Recheck as text
%        str2double(get(hObject,'String')) returns contents of Recheck as a double


% --- Executes during object creation, after setting all properties.
function Recheck_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Recheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Default.
function Default_Callback(hObject, eventdata, handles)
% hObject    handle to Default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Reck;
Reck=get(handles.RecheckButton,'value');
global language;
global OptDev;
OptDev= get(handles.Opt,'value');

switch language
    case 'English'
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
    case 'Spanish'
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Input binaria');
    set(handles.Redundancy,'string','Código redundante');
    set(handles.Output,'string','Salida');
    set(handles.Recovery,'string','Recuperación');
    set(handles.Recheck,'string','Código de reexamen');
    set(handles.State,'string','>>Predeterminado');
    case 'Traditional Chinese'
    set(handles.Input,'string','輸入');
    set(handles.BinInput,'string','二進位輸入');
    set(handles.Redundancy,'string','冗餘碼');
    set(handles.Output,'string','輸出');
    set(handles.Recovery,'string','恢復');
    set(handles.Recheck,'string','重檢驗碼');
    set(handles.State,'string','>>默認');
    case 'Simplified Chinese'
    set(handles.Input,'string','输入');
    set(handles.BinInput,'string','二进制输入');
    set(handles.Redundancy,'string','冗余码');
    set(handles.Output,'string','输出');
    set(handles.Recovery,'string','恢复');
    set(handles.Recheck,'string','重检验码');
    set(handles.State,'string','>>默认');
    otherwise
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
end


% --- Executes on button press in ClearInput.
function ClearInput_Callback(hObject, eventdata, handles)
% hObject    handle to ClearInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Input,'string','');


% --- Executes on button press in ClearRecheck.
function ClearRecheck_Callback(hObject, eventdata, handles)
% hObject    handle to ClearRecheck (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Recheck,'string','');

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function Exp_Callback(hObject, eventdata, handles)
% hObject    handle to Exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ExpTool_Callback(hObject, eventdata, handles)
% hObject    handle to ExpTool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CRC_Default_Callback(hObject, eventdata, handles)
% hObject    handle to CRC_Default (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Language_Callback(hObject, eventdata, handles)
% hObject    handle to Language (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CRCExp_Callback(hObject, eventdata, handles)
% hObject    handle to CRCExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CRCAllCallBack


% --------------------------------------------------------------------
function UDPExp_Callback(hObject, eventdata, handles)
% hObject    handle to UDPExp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.CRCPanel,'visible','off');


% --------------------------------------------------------------------
function Chinese1_Callback(hObject, eventdata, handles)
% hObject    handle to Chinese1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global language;
language='Simplified Chinese';


% --------------------------------------------------------------------
function Chinese2_Callback(hObject, eventdata, handles)
% hObject    handle to Chinese2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global language;
language='Traditional Chinese';


% --------------------------------------------------------------------
function English_Callback(hObject, eventdata, handles)
% hObject    handle to English (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global language;
language='English';


% --------------------------------------------------------------------
function Spanish_Callback(hObject, eventdata, handles)
% hObject    handle to Spanish (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global language;
language='Spanish';


% --------------------------------------------------------------------
function ExpDefault_Callback(hObject, eventdata, handles)
% hObject    handle to ExpDefault (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Reck;
Reck=get(handles.RecheckButton,'value');

global OptDev;
OptDev= get(handles.Opt,'value');

global language;

switch language
    case 'English'
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
    case 'Spanish'
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Input binaria');
    set(handles.Redundancy,'string','Código redundante');
    set(handles.Output,'string','Salida');
    set(handles.Recovery,'string','Recuperación');
    set(handles.Recheck,'string','Código de reexamen');
    set(handles.State,'string','>>Predeterminado');
    case 'Traditional Chinese'
    set(handles.Input,'string','輸入');
    set(handles.BinInput,'string','二進位輸入');
    set(handles.Redundancy,'string','冗餘碼');
    set(handles.Output,'string','輸出');
    set(handles.Recovery,'string','恢復');
    set(handles.Recheck,'string','重檢驗碼');
    set(handles.State,'string','>>默認');
    case 'Simplified Chinese'
    set(handles.Input,'string','输入');
    set(handles.BinInput,'string','二进制输入');
    set(handles.Redundancy,'string','冗余码');
    set(handles.Output,'string','输出');
    set(handles.Recovery,'string','恢复');
    set(handles.Recheck,'string','重检验码');
    set(handles.State,'string','>>默认');
    otherwise
    set(handles.Input,'string','Input');
    set(handles.BinInput,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
end


% --------------------------------------------------------------------
function ExpStatement_Callback(hObject, eventdata, handles)
% hObject    handle to ExpStatement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CRCState_Callback(hObject, eventdata, handles)
% hObject    handle to CRCState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global language;
switch language
    case 'English'
    h=msgbox({'Welcome to CRC8/CRC16 Experiment!'
    'Version ：210408.1'
    'Editor : Lim'
    '*******************************************'
    'Please input data you want to sent in ''Input'' box!'
    'Start with ''0x'' or ''0X'' if the format is hexadecimal.'
    '(case insensitive)'
    'Only allow ''1'' or ''0'' in binary format!'
    'CRC8=X^7+X^2+X+1'
    'CRC16=X^15+X^14+X^2+1'
    '*******************************************'
    'Put ''Start'' button after inputing data in ''Input'' box.'
    '* ''Developer'' button to switch to the develop mode.'
    '*''Check ''button to check result. If output is 0 completely,'
    '*the result is correct, otherwise the result is wrong.'
    '*Users can input your own data to check.'
    '(Only support binary or hexadecimal)'},'CRC8/CRC16 Experiment Statement','help');
    case 'Simplified Chinese'
            h=msgbox({'欢迎来到 CRC8/CRC16 实验!'
    '版本号 ：210608.1'
    '开发者 : 林政扬'
    '*******************************************'
    '请在“输入”中输入你的数据，'
    '如果输入16进制的数据，请以“0x”或“0X”开头。'
    '（不区分大小写）'
    '在2进制中只能输入“0”或是“1”的数字。'
    'CRC8=X^7+X^2+X+1'
    'CRC16=X^15+X^14+X^2+1'
    '*******************************************'
    '在“输入”里输入数据后方可点击开始'
    '* 点击“开发者”进入开发者模式'
    '*“检查”按钮是用来检测结果的，如果结果全部是0说明结果正确'
    '*否则，校验结果是错误的。'
    '*用户可以输入自己的校验码进行检验。'
    '（结果仅支持2进制和16进制）'},'CRC8/CRC16 实验说明','help');
    case 'Traditional Chinese'
                    h=msgbox({'歡迎來到CRC8/CRC16實驗!'
    '版本號 ：210608.1'
    '開發者 : 林政揚'
    '*******************************************'
    '請在“輸入”中輸入你的數據，'
    '如果輸入16進制的數據，請以“0x”或“0X”開頭。'
    '（不區分大小寫）'
    '在2進制中只能輸入“0”或是“1”的數位。'
    'CRC8=X^7+X^2+X+1'
    'CRC16=X^15+X^14+X^2+1'
    '*******************************************'
    '在“輸入”裏輸入數據後方可點擊開始'
    '* 點擊“開發者”進入開發者模式'
    '*“檢查”按鈕是用來檢測結果的，如果結果全部是0說明結果正確'
    '*否則，校驗結果是錯誤的。'
    '*用戶可以輸入自己的校驗碼進行檢驗。'
    '結果僅支持2進制和16進制）'},'CRC8/CRC16 Experiment Statement','help');
    case 'Spanish'
        h=msgbox({'Bienvenidos al experimento CRC8/CRC16!'
    'Versión: 210408.1'
    'Desarrollador: Lin Zhengyang'
    '*******************************************'
    'Por favor, introduzca sus datos en la entrada.'
    'Si introduce datos hexadecimales, comience con "0x" o "0x".'
    '(insensible a mayúsculas)'
    'Sólo se pueden introducir números "0" o "1" en el sistema binario.'
    'CRC8=X^7+X^2+X+1'
    'CRC16=X^15+X^14+X^2+1'
    '*******************************************'
    'Introduzca los datos en "Input" antes de hacer clic en inicio'
    '* Haga clic en "desarrollador" para entrar en el modo desarrollador'
    '* El botón "Check" se utiliza para comprobar los resultados. Si todos los resultados son 0,'
    '* el resultado es correcto,de lo contrario, el resultado de la verificación es incorrecto.'
    '*El usuario puede introducir su propio Código de verificación para la verificación.'
    '(los resultados sólo soportan sistemas binarios y hexadecimales)'},'CRC8/CRC16 descripción del experimento','help');
    otherwise
        h=msgbox({'Welcome to CRC8/CRC16 Experiment!'
    'Version ：210408.1'
    'Editor : Lim'
    '*******************************************'
    'Please input data you want to sent in ''Input'' box!'
    'Start with ''0x'' or ''0X'' if the format is hexadecimal.'
    '(case insensitive)'
    'Only allow ''1'' or ''0'' in binary format!'
    'CRC8=X^7+X^2+X+1'
    'CRC16=X^15+X^14+X^2+1'
    '*******************************************'
    'Put ''Start'' button after inputing data in ''Input'' box.'
    '* ''Developer'' button to switch to the develop mode.'
    '*''Check ''button to check result. If output is 0 completely,'
    '*the result is correct, otherwise the result is wrong.'
    '*Users can input your own data to check.'
    '(Only support binary or hexadecimal)'},'CRC8/CRC16 實驗說明','help');
end
ht = findobj(h, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(h,'position',[220,70,450,400]);


% --------------------------------------------------------------------
function UDPState_Callback(hObject, eventdata, handles)
% hObject    handle to UDPState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.



function CRCAllCallBack
 Opt_Callback(hObject, eventdata, handles);
 pushbutton1_Callback(hObject, eventdata, handles);
 Input_Callback(hObject, eventdata, handles);
 Input_CreateFcn(hObject, eventdata, handles);
 RecheckButton_Callback(hObject, eventdata, handles);
 Mode_Callback(hObject, eventdata, handles);
 Mode_CreateFcn(hObject, eventdata, handles);
 OutputMode_Callback(hObject, eventdata, handles);
 OutputMode_CreateFcn(hObject, eventdata, handles);
 Check_Callback(hObject, eventdata, handles);
 Recheck_Callback(hObject, eventdata, handles);
 Recheck_CreateFcn(hObject, eventdata, handles);
 pushbutton6_Callback(hObject, eventdata, handles);
 Default_Callback(hObject, eventdata, handles);
 ClearInput_Callback(hObject, eventdata, handles);
 ClearRecheck_Callback(hObject, eventdata, handles);
 figure1_CreateFcn(hObject, eventdata, handles);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
