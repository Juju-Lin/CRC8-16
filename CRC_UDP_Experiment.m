function varargout = CRC_UDP_Experiment(varargin)
%CRC_UDP_EXPERIMENT MATLAB code file for CRC_UDP_Experiment.fig
%      CRC_UDP_EXPERIMENT, by itself, creates a new CRC_UDP_EXPERIMENT or raises the existing
%      singleton*.
%
%      H = CRC_UDP_EXPERIMENT returns the handle to a new CRC_UDP_EXPERIMENT or the handle to
%      the existing singleton*.
%
%      CRC_UDP_EXPERIMENT('Property','Value',...) creates a new CRC_UDP_EXPERIMENT using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to CRC_UDP_Experiment_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      CRC_UDP_EXPERIMENT('CALLBACK') and CRC_UDP_EXPERIMENT('CALLBACK',hObject,...) call the
%      local function named CALLBACK in CRC_UDP_EXPERIMENT.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRC_UDP_Experiment

% Last Modified by GUIDE v2.5 22-Jun-2021 22:20:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRC_UDP_Experiment_OpeningFcn, ...
                   'gui_OutputFcn',  @CRC_UDP_Experiment_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before CRC_UDP_Experiment is made visible.
function CRC_UDP_Experiment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for CRC_UDP_Experiment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global CRC8;
global CRC16;
global Totaldata;
global BinResult;
global DecResult;
global HexResult;
global OptDeveloper;
global Reck;
global binout;
global pic;
if isempty(pic)
    pic='hdu.jfif';
end
BG(pic);
global language;
if isempty(language)
    language='English';
end
OptDeveloper=0;
ExpDefault_Callback(hObject, eventdata, handles);




% UIWAIT makes CRC_UDP_Experiment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CRC_UDP_Experiment_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when uipanel3 is resized.
function uipanel3_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel22 is resized.
function uipanel22_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
global mode;
global binout;
global OptDev;
global OptDev;
global language;
global TranferedData;
OptDev= get(handles.Developer,'value');
% Get data from Input box
data=get(handles.Input,'string');%Inputdata--- char
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
set(handles.BinResult,'string',TranferedData);
% Print Output and Redundancy
outputmode=get(handles.Base,'value');
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
% Print StateWin
switch language
    case 'English'
    Sentence1=['Input data are :',data,'        '];
    Sentence2=['Redundancy Code are :',code,'        '];
    Sentence3=['Output Code are :',output,'        '];
    case 'Simplified Chinese'
    Sentence1=['输入数据 :',data,'        '];
    Sentence2=['冗余码 :',code,'        '];
    Sentence3=['输出结果 :',output,'        '];
    case 'Traditional Chinese'
    Sentence1=['輸入數據 :',data,'        '];
    Sentence2=['冗餘碼 :',code,'        '];
    Sentence3=['輸出程式碼 :',output,'        '];
    case 'Spanish'
    Sentence1=['Área de datos de entrada :',data,'        '];
    Sentence2=['Código de redundancia :',code,'        '];
    Sentence3=['Código de salida are:',output,'        '];
    otherwise
    Sentence1=['Input data are :',data,'        '];
    Sentence2=['Redundancy Code are :',code,'        '];
    Sentence3=['Output Code are :',output,'        '];
end

set(handles.State,'string',[Sentence1,Sentence2,Sentence3]);

end

if OptDev %developer mode
    switch language
        case 'English'
        SentenceDev=['Developer Mode is closed. Add us to maintain!'];
        case 'Spanish'
        SentenceDev=['El modo de Desarrollador está cerrado,añadir nosotros para mantener!'];
        case 'Simplified Chinese'
        SentenceDev=['开发者模式已关闭，请加入我们进行维护！'];
        case 'Traditional Chinese'
        SentenceDev=['開發者模式已關閉，請加入我們進行維護！'];
        otherwise
        SentenceDev=['Developer Mode is closed. Add us to maintain!'];
    end
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


% --- Executes on button press in OwnCheck.
function OwnCheck_Callback(hObject, eventdata, handles)
global Reck;
Reck=get(handles.OwnCheck,'value');


% --- Executes on button press in Check.
function Check_Callback(hObject, eventdata, handles)
global binout;
global mode;
global Reck;
global CRC8;
global CRC16;
global language;
global BinRecovery;
SentenceErr1=[''];
Reck=get(handles.OwnCheck,'value');
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
            switch language
                case 'English'
                msgbox('Check Data is invalid!');
                error('Check Data is invalid!');
                case 'Simplified'
                msgbox('检验码是不合理的!');
                error('检验码是不合理的!');
                case 'Traditional Chinese'
                msgbox('!');
                error('檢查數據無效!');
                case 'Spanish'
                msgbox('Comprobación de datos inválidos!');
                error('Comprobación de datos inválidos!');
                otherwise
                msgbox('Check Data is invalid!');
                error('Check Data is invalid!');
            end
        end
    end

    lenCheCod=length(CheckCode);

    if strcmp(mode,'CRC8')
        
            if lenCheCod<length(CRC8)+1
                % Ensure the length of the check code is longer than Exp's.
                supplynum=length(CRC8)+1-lenCheCod;
                relay=zeros(1,length(CRC8)+1);
                switch language
                    case 'English'
                    SentenceErr1=['The check code is less than CRC. Automatically add ',...
                        num2str(supplynum),' zeros after the code to make sure the format is correct!'];
                    case 'Simplified Chinese'
                    SentenceErr1=['检验码比CRC码要少， 自动在检验码后添加 ',...
                        num2str(supplynum),' 个零来确保检验格式正确!'];
                    case 'Spanish'
                    SentenceErr1=['El Código de verificación es menor que el Código CRC, añadir automáticamente ',...
                        num2str(supplynum),' ceros después del código de verificación para asegurar el formato correcto!'];
                    case 'Traditional Chinese'
                    SentenceErr1=['檢驗碼比CRC碼要少，自動在檢驗碼後添加',...
                        num2str(supplynum),' 個零來確保檢驗格式正確！'];
                    otherwise
                    SentenceErr1=['The check code is less than CRC. Automatically add ',...
                        num2str(supplynum),' zeros after the code to make sure the format is correct!'];
                end
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
                switch language
                    case 'English'
                    SentenceErr1=['The check code is less than CRC. Automatically add ',...
                        num2str(supplynum),' zeros after the code to make sure the format is correct!'];
                    case 'Simplified Chinese'
                    SentenceErr1=['检验码比CRC码要少， 自动在检验码后添加 ',...
                        num2str(supplynum),' 个零来确保检验格式正确!'];
                    case 'Spanish'
                    SentenceErr1=['El Código de verificación es menor que el Código CRC, añadir automáticamente ',...
                        num2str(supplynum),' ceros después del código de verificación para asegurar el formato correcto!'];
                    case 'Traditional Chinese'
                    SentenceErr1=['檢驗碼比CRC碼要少，自動在檢驗碼後添加',...
                        num2str(supplynum),' 個零來確保檢驗格式正確！'];
                    otherwise
                    SentenceErr1=['The check code is less than CRC. Automatically add ',...
                        num2str(supplynum),' zeros after the code to make sure the format is correct!'];
                end
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
%print statewin
if str2num(BinRecovery)==0
    switch language
        case 'English'
        Sentence4=['The Check Result is Correct!'];
        case 'Simplified Chinese'
        Sentence4=['检验结果正确！'];
        case 'Traditional Chinese'
        Sentence4=['檢驗結果正確！'];
        case 'Spanish'
        Sentence4=['Los resultados de la inspección son correctos!'];
        otherwise
        Sentence4=['The Check Result is Correct!'];
    end
else
    switch language
        case 'English'
        Sentence4=['The Check Result is Wrong!'];
        case 'Simplified Chinese'
        Sentence4=['检验结果错误！'];
        case 'Traditional Chinese'
        Sentence4=['檢驗結果錯誤！'];
        case 'Spanish'
        Sentence4=['Error en los resultados de la Inspección!'];
        otherwise
        Sentence4=['The Check Result is Wrong!'];
    end
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
function ExpDefault_Callback(hObject, eventdata, handles)
global Reck;
Reck=get(handles.OwnCheck,'value');
global language;
global OptDev;
OptDev= get(handles.Developer,'value');
TranlationSet(language,handles)

% --------------------------------------------------------------------
function ExpStatement_Callback(hObject, eventdata, handles)
% hObject    handle to ExpStatement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CRCState_Callback(hObject, eventdata, handles)
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
    StartString=set(hObject.Start,'String','Start');
end
ht = findobj(h, 'Type', 'text');
set(ht, 'FontSize', 12, 'Unit', 'normal');
set(h,'position',[220,70,450,400]);



% --------------------------------------------------------------------
function UDPState_Callback(hObject, eventdata, handles)
global language;
option='off';
setcrcvisible(option,handles);
switch language
    case 'Simplified Chinese'
          helpdlg('该实验尚未开发！','提示');
    case 'Traditional Chinese'
          helpdlg('該實驗尚未開發！','提示');
    case 'English'
          helpdlg('This experiment has not been developed yet!','Tip');
    case 'Spanish'
          helpdlg('El experimento aún no se ha desarrollado!','Prompt');
    otherwise
          helpdlg('This experiment has not been developed yet!','Tip');
end


% --------------------------------------------------------------------
function Language_Callback(hObject, eventdata, handles)
% hObject    handle to Language (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function CRCExp_Callback(hObject, eventdata, handles)
option='on';
setcrcvisible(option,handles);




% --------------------------------------------------------------------
function UDPExp_Callback(hObject, eventdata, handles)
global language;
option='off';
setcrcvisible(option,handles);
switch language
    case 'Simplified Chinese'
          helpdlg('该实验尚未开发！','提示');
    case 'Traditional Chinese'
          helpdlg('該實驗尚未開發！','提示');
    case 'English'
          helpdlg('This experiment has not been developed yet!','Tip');
    case 'Spanish'
          helpdlg('El experimento aún no se ha desarrollado!','Prompt');
    otherwise
          helpdlg('This experiment has not been developed yet!','Tip');
end


% --------------------------------------------------------------------
function Chinese1_Callback(hObject, eventdata, handles)
global language;
language='Simplified Chinese';
ExpDefault_Callback(hObject, eventdata, handles)



% --------------------------------------------------------------------
function Chinese2_Callback(hObject, eventdata, handles)
global language;
language='Traditional Chinese';
ExpDefault_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function English_Callback(hObject, eventdata, handles)
global language;
language='English';
ExpDefault_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Spanish_Callback(hObject, eventdata, handles)
global language;
language='Spanish';
ExpDefault_Callback(hObject, eventdata, handles)

% --- Executes on button press in Default.
function Default_Callback(hObject, eventdata, handles)
global Reck;
Reck=get(handles.Check,'value');
global language;
global OptDev;
OptDev= get(handles.Developer,'value');
TranlationSet(language,handles)




% --- Executes on button press in Clear1.
function Clear1_Callback(hObject, eventdata, handles)
set(handles.Input,'string','');


% --- Executes on button press in Clear2.
function Clear2_Callback(hObject, eventdata, handles)
set(handles.Recheck,'string','');


% --- Executes on selection change in Base.
function Base_Callback(hObject, eventdata, handles)
% hObject    handle to Base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Base contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Base


% --- Executes during object creation, after setting all properties.
function Base_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Base (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Developer.
function Developer_Callback(hObject, eventdata, handles)
global OptDev;
OptDev= get(handles.Developer,'value');


% --------------------------------------------------------------------
function Background_Callback(hObject, eventdata, handles)
% hObject    handle to Background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function yubanmeiqin_Callback(hObject, eventdata, handles)
global pic;
pic='yubanmeiqin.jfif';
BG(pic);

% --------------------------------------------------------------------
function Red_Callback(hObject, eventdata, handles)
global pic;
pic='red.jpg';
BG(pic);


% --------------------------------------------------------------------
function White_Callback(hObject, eventdata, handles)
global pic;
pic='white.jpg';
BG(pic);


% --------------------------------------------------------------------
function Hdu_Callback(hObject, eventdata, handles)
global pic;
pic='hdu.jfif';
BG(pic);

% --------------------------------------------------------------------
function Chip_Callback(hObject, eventdata, handles)
global pic;
pic='chips.jfif';
BG(pic);

% --------------------------------------------------------------------
function BinAry=bin2array(BinaryString)
for i=1:length(BinaryString)
    if strcmp(BinaryString(i),'0')%Judge '0'
        BinAry(i)=0;
    else
        BinAry(i)=1;
    end
end

% --------------------------------------------------------------------
function [YDynData,XDynData,spanLen]=DynamicGraphData(TransferData,flag)
% flag is the option to accelerate
k=1;
if length(TransferData)<2000
    if flag==0
        spanLen=0.01;
    elseif flag==1
        spanLen=0.02;
    end
else
    if flag==0
        spanLen=0.02;
    elseif flag==1
        spanLen=0.05;
    end
end
t=0:spanLen:length(TransferData);
for i=1:length(t)-2
    if mod(i,1/spanLen)==0
        k=k+1;
    end
    YDynData(i)=TransferData(k);
end
XDynData=t(1:end-2);

% --------------------------------------------------------------------
function BG(pic)
ha=axes('units','normalized','position',[0 0 1 1]);
uistack(ha,'up');
II=imread(pic);
image(II);
colormap Gray;
set(ha,'handlevisibility','off','visible','off');

function TranlationSet(language,handles)
switch language
    case 'English'
    set(handles.Input,'string','Input');
    set(handles.BinResult,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
    set(handles.start,'String','Start');
    set(handles.Input,'String','Input');
    set(handles.Check,'String','Check');
    set(handles.StateWin,'String','State');
    set(handles.Clear1,'String','Clear');
    set(handles.Clear2,'String','Clear');
    set(handles.text21,'String','Input');
    set(handles.text22,'String','Binary');
    set(handles.text24,'String','Redundancy');
    set(handles.text25,'String','Output');
    set(handles.Default,'String','Default');
    set(handles.CRCPanel,'Title','CRC8/16 Experiment');
    set(handles.Exp,'Text','Experiment');
    set(handles.CRCExp,'Text','CRC8/16 Experiment');
    set(handles.UDPExp,'Text','UDP Checksum Test');
    set(handles.ExpTool,'Text','Tool');
    set(handles.Language,'Text','Language');
    set(handles.ExpDefault,'Text','Default');
    set(handles.ExpStatement,'Text','Statement');
    set(handles.Caution,'String',...
'*When we acquire hexadecimal it does not mean we know the initial zero number. You''d better start the data with ‘1’.');
    set(handles.OwnCheck,'String','Enter your own code');
    set(handles.Background,'Text','Background');
    set(handles.Base,'String',{'Binary';'Decimal';'Hexadecimal'});
    set(handles.Developer,'String','Developer');
    set(handles.Play1,'String','Play');
    set(handles.Play2,'String','Play');
    set(handles.Fast1,'String','Fast');
    set(handles.Fast2,'String','Fast');
    set(handles.CRCState,'Text','CRC8/16 Experiment');
    set(handles.UDPState,'Text','UDP Checksum Test');
    
    case 'Spanish'
    set(handles.Input,'string','Input');
    set(handles.BinResult,'string','Input binaria');
    set(handles.Redundancy,'string','Código redundante');
    set(handles.Output,'string','Salida');
    set(handles.Recovery,'string','Recuperación');
    set(handles.Recheck,'string','Código de reexamen');
    set(handles.State,'string','>>Predeterminado');
    set(handles.start,'String','Inicio');
    set(handles.Input,'String','Input');
    set(handles.Check,'String','Inspección');
    set(handles.StateWin,'String','Estado');
    set(handles.Clear1,'String','Limpieza');
    set(handles.Clear2,'String','Limpieza');
    set(handles.text21,'String','Input');
    set(handles.text22,'String','Input binaria');
    set(handles.text24,'String','Código redundante');
    set(handles.text25,'String','Salida');
    set(handles.Default,'String','Predeterminado');
    set(handles.CRCPanel,'Title','CRC8/16 Experimento');
    set(handles.Exp,'Text','Experimento');
    set(handles.CRCExp,'Text','CRC8/16 Experimento');
    set(handles.UDPExp,'Text','Prueba de suma de verificación UDP');
    set(handles.ExpTool,'Text','Herramientas');
    set(handles.Language,'Text','Idioma');
    set(handles.ExpDefault,'Text','Incumplimiento');
    set(handles.ExpStatement,'Text','Declaración');
    set(handles.Caution,'String',...
'Cuando obtenemos un número hexadecimal, no significa que conozcamos el cero inicial.Será mejor que empieces con "1".');
    set(handles.OwnCheck,'String','Introduzca su propio código');
    set(handles.Background,'Text','Antecedentes');
    set(handles.Base,'String',{'Binario';'Decimal';'Hexadecimal'});
    set(handles.Developer,'String','Desarrollador');
    set(handles.Play1,'String','Reproducir');
    set(handles.Play2,'String','Reproducir');
    set(handles.Fast1,'String','Rápido');
    set(handles.Fast2,'String','Rápido');
    set(handles.CRCState,'Text','CRC8/16 Experimento');
    set(handles.UDPState,'Text','Prueba de suma de verificación UDP');

    case 'Traditional Chinese'
    set(handles.Input,'string','輸入');
    set(handles.BinResult,'string','二進位輸入');
    set(handles.Redundancy,'string','冗餘碼');
    set(handles.Output,'string','輸出');
    set(handles.Recovery,'string','恢復');
    set(handles.Recheck,'string','重檢驗碼');
    set(handles.State,'string','>>默認');
    set(handles.start,'String','開始');
    set(handles.Input,'String','輸入');
    set(handles.Check,'String','檢驗');
    set(handles.StateWin,'String','狀態');
    set(handles.Clear1,'String','清除');
    set(handles.Clear2,'String','清除');
    set(handles.text21,'String','輸入');
    set(handles.text22,'String','對應二進位');
    set(handles.text24,'String','冗餘碼');
    set(handles.text25,'String','輸出');
    set(handles.Default,'String','默認');
    set(handles.CRCPanel,'Title','CRC8/16實驗');
    set(handles.Exp,'Text','實驗');
    set(handles.CRCExp,'Text','CRC8/16 實驗');
    set(handles.UDPExp,'Text','UDP校驗和實驗');
    set(handles.ExpTool,'Text','工具');
    set(handles.Language,'Text','語言');
    set(handles.ExpDefault,'Text','默認');
    set(handles.ExpStatement,'Text','說明');
    set(handles.Caution,'String',...
'*當我們得到十六進位數時，並不意味著我們知道初始的零數,你最好從“1”開始。');
    set(handles.OwnCheck,'String','輸入你自己的程式碼');
    set(handles.Background,'Text','背景');
    set(handles.Base,'String',{'二進位';'十進位';'十六進位'});
    set(handles.Developer,'String','開發者');
    set(handles.Play1,'String','動畫');
    set(handles.Play2,'String','動畫');
    set(handles.Fast1,'String','加速');
    set(handles.Fast2,'String','加速');
    set(handles.CRCState,'Text','CRC8/16實驗');
    set(handles.UDPState,'Text','UDP校驗和實驗');
    
    case 'Simplified Chinese'
    set(handles.Input,'string','输入');
    set(handles.BinResult,'string','二进制输入');
    set(handles.Redundancy,'string','冗余码');
    set(handles.Output,'string','输出');
    set(handles.Recovery,'string','恢复');
    set(handles.Recheck,'string','重检验码');
    set(handles.State,'string','>>默认');
    set(handles.start,'String','开始');
    set(handles.Input,'String','输入');
    set(handles.Check,'String','检验');
    set(handles.StateWin,'String','状态');
    set(handles.Clear1,'String','清除');
    set(handles.Clear2,'String','清除');
    set(handles.text21,'String','输入');
    set(handles.text22,'String','对应二进制');
    set(handles.text24,'String','冗余码');
    set(handles.text25,'String','输出');
    set(handles.Default,'String','默认');
    set(handles.CRCPanel,'Title','CRC8/16 实验')
    set(handles.Exp,'Text','实验');
    set(handles.CRCExp,'Text','CRC8/16 实验');
    set(handles.UDPExp,'Text','UDP 校验和实验');
    set(handles.ExpTool,'Text','工具');
    set(handles.Language,'Text','语言');
    set(handles.ExpDefault,'Text','默认');
    set(handles.ExpStatement,'Text','说明');
    set(handles.Caution,'String',...
'*当我们得到十六进制数时，并不意味着我们知道初始的零数，你最好从“1”开始。');
    set(handles.OwnCheck,'String','输入自己的检验码');
    set(handles.Background,'Text','背景');
    set(handles.Base,'String',{'二进制';'十进制';'十六进制'});
    set(handles.Developer,'String','开发者');
        set(handles.Play1,'String','动画');
    set(handles.Play2,'String','动画');
    set(handles.Fast1,'String','加速');
    set(handles.Fast2,'String','加速');
    set(handles.CRCState,'Text','CRC8/16 实验');
    set(handles.UDPState,'Text','UDP 校验和实验');
    
    otherwise
    set(handles.Input,'string','Input');
    set(handles.BinResult,'string','Binary Input');
    set(handles.Redundancy,'string','Redundant Code');
    set(handles.Output,'string','Output');
    set(handles.Recovery,'string','Recovery');
    set(handles.Recheck,'string','Recheck Code');
    set(handles.State,'string','>>Default');
    set(handles.start,'String','Start');
    set(handles.Input,'String','Input');
    set(handles.Check,'String','Check');
    set(handles.StateWin,'String','State');
    set(handles.Clear1,'String','Clear');
    set(handles.Clear2,'String','Clear');
    set(handles.text21,'String','Input');
    set(handles.text22,'String','Binary');
    set(handles.text24,'String','Redundancy');
    set(handles.text25,'String','Output');
    set(handles.Default,'String','Default');
    set(hangdles.CRCPanel,'Title','CRC8/16 Experiment');
    set(handles.CRCPanel,'Title','CRC8/16 Experiment');
    set(handles.Exp,'Text','Experiment');
    set(handles.CRCExp,'Text','CRC8/16 Experiment');
    set(handles.UDPExp,'Text','UDP Checksum Test');
    set(handles.ExpTool,'Text','Tool');
    set(handles.Language,'Text','Language');
    set(handles.ExpDefault,'Text','Default');
    set(handles.ExpStatement,'Text','Statement');
    set(handles.Caution,'String',...
'*When we acquire hexadecimal it does not mean we know the initial zero number. You''d better start the data with ‘1’.');
    set(handles.OwnCheck,'String','Enter your own code');
    set(handles.Background,'Text','Background');
    set(handles.Base,'String',{'Binary';'Decimal';'Hexadecimal'});
    set(handles.Developer,'String','Developer');
    set(handles.Play1,'String','Play');
    set(handles.Play2,'String','Play');
    set(handles.Fast1,'String','Fast');
    set(handles.Fast2,'String','Fast');
    set(handles.CRCState,'Text','CRC8/16 Experiment');
    set(handles.UDPState,'Text','UDP Checksum Test');
end
% --------------------------------------------------------------------

% --- Executes on button press in Play2.
function Play2_Callback(hObject, eventdata, handles)
global BinRecovery;
global TranferedData;
global mode;
global language;
data=get(handles.Input,'string');%Inputdata--- char
[ou1,ou2,ou3,ou4]=RCRmian(data,mode);
Fast1=get(handles.Fast1,'value');
Fast2=get(handles.Fast2,'value');
opt='check';
opt2='none';
if Fast1%Whether accelerate
    flag1=1;
else
    flag1=0;
end
if Fast2
    flag2=1;
else
    flag2=0;
end
BinAry=bin2array(TranferedData);%Inputdata--- Array
[YDynData,XDynData,spanLen]=DynamicGraphData(BinAry,flag1);%Data used to draw dynamic graph
if str2num(BinRecovery)==0
    if flag2==0
        comet(handles.axes2,XDynData,YDynData);%Draw Graph
        set(handles.axes2,'XGrid','on');
        set(handles.axes2,'XTick',[1:1:max(XDynData)]);
        setlegend(handles,language,opt);
    else
        plot(handles.axes2,XDynData,YDynData);%Draw Graph  
        set(handles.axes2,'XGrid','on');
        set(handles.axes2,'XTick',[1:1:max(XDynData)]);
        setlegend(handles,language,opt);
    end
else
	plot(handles.axes2,0,0);%Draw Graph  
	set(handles.axes2,'XGrid','on');
	set(handles.axes2,'XTick',[1:1:max(XDynData)]);
	setlegend(handles,language,opt2)
end

    


% --------------------------------------------------------------------
% --- Executes on button press in Play1.
function Play1_Callback(hObject, eventdata, handles)
global TranferedData;
global binout;
global mode;
global language;
opt1='input';
opt2='redundancy';

data=get(handles.Input,'string');%Inputdata--- char
[ou1,ou2,ou3,ou4]=RCRmian(data,mode);
Fast1=get(handles.Fast1,'value');
Fast2=get(handles.Fast2,'value');
if Fast1%Whether accelerate
    flag1=1;
else
    flag1=0;
end
if Fast2
    flag2=1;
else
    flag2=0;
end
BinAry=bin2array(TranferedData);%Inputdata--- Array
[YDynData,XDynData,spanLen]=DynamicGraphData(BinAry,flag1);%Data used to draw dynamic graph
OutputBinAry2=bin2array(binout);%Redundancy--- Array
[YDynData2,XDynData2]=DynamicGraphData(OutputBinAry2,flag2);%Data used to draw dynamic graph
if flag1==0
    comet(handles.axes1,XDynData,YDynData);%Draw Graph
    set(handles.axes1,'XGrid','on');
    set(handles.axes1,'XTick',[1:1:max(XDynData)]);
    setlegend(handles,language,opt1);
    OutputBinAry2=bin2array(binout);%Redundancy--- Array
    comet(handles.axes2,XDynData2,YDynData2);%Draw Graph
    set(handles.axes2,'XGrid','on');
    set(handles.axes2,'XTick',[1:1:max(XDynData2)]);
    setlegend(handles,language,opt2);
else
    plot(handles.axes1,XDynData,YDynData);%Draw Graph  
    set(handles.axes1,'XGrid','on');
    set(handles.axes1,'XTick',[1:1:max(XDynData)]);
    setlegend(handles,language,opt1);
    plot(handles.axes2,XDynData2,YDynData2);%Draw Graph
    set(handles.axes2,'XGrid','on');
    set(handles.axes2,'XTick',[1:1:max(XDynData2)]);
    setlegend(handles,language,opt2);
end




% --------------------------------------------------------------------
% --- Executes on button press in Fast2.
function Fast2_Callback(hObject, eventdata, handles)
% hObject    handle to Fast2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fast2


% --- Executes on button press in Fast1.
function Fast1_Callback(hObject, eventdata, handles)
% hObject    handle to Fast1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fast1
% --------------------------------------------------------------------
function setcrcvisible(opt,handles)
if strcmp(opt,'off')
    set(handles.uipanel1,'Visible','off');
    set(handles.uipanel2,'Visible','off');
    set(handles.uipanel3,'Visible','off');
    set(handles.uipanel4,'Visible','off');
    set(handles.uipanel5,'Visible','off');
    set(handles.uipanel6,'Visible','off');
    set(handles.uipanel7,'Visible','off');
    set(handles.uipanel8,'Visible','off');
    set(handles.uipanel9,'Visible','off');
    set(handles.uipanel10,'Visible','off');
    set(handles.uipanel11,'Visible','off');
    set(handles.uipanel12,'Visible','off');
    set(handles.uipanel13,'Visible','off');
    set(handles.uipanel14,'Visible','off');
    set(handles.uipanel15,'Visible','off');
    set(handles.uipanel16,'Visible','off');
    set(handles.uipanel17,'Visible','off');
    set(handles.uipanel18,'Visible','off');
    set(handles.uipanel19,'Visible','off');
    set(handles.uipanel20,'Visible','off');
    set(handles.uipanel21,'Visible','off');
    set(handles.uipanel22,'Visible','off');
    set(handles.uipanel24,'Visible','off');
    set(handles.uipanel25,'Visible','off');
    set(handles.uipanel26,'Visible','off');
    set(handles.CRCPanel,'Visible','off');
    set(handles.uipanel29,'Visible','off');
end
if strcmp(opt,'on')
    set(handles.uipanel1,'Visible','on');
    set(handles.uipanel2,'Visible','on');
    set(handles.uipanel3,'Visible','on');
    set(handles.uipanel4,'Visible','on');
    set(handles.uipanel5,'Visible','on');
    set(handles.uipanel6,'Visible','on');
    set(handles.uipanel7,'Visible','on');
    set(handles.uipanel8,'Visible','on');
    set(handles.uipanel9,'Visible','on');
    set(handles.uipanel10,'Visible','on');
    set(handles.uipanel11,'Visible','on');
    set(handles.uipanel12,'Visible','on');
    set(handles.uipanel13,'Visible','on');
    set(handles.uipanel14,'Visible','on');
    set(handles.uipanel15,'Visible','on');
    set(handles.uipanel16,'Visible','on');
    set(handles.uipanel17,'Visible','on');
    set(handles.uipanel18,'Visible','on');
    set(handles.uipanel19,'Visible','on');
    set(handles.uipanel20,'Visible','on');
    set(handles.uipanel21,'Visible','on');
    set(handles.uipanel22,'Visible','on');
    set(handles.uipanel24,'Visible','on');
    set(handles.uipanel25,'Visible','on');
    set(handles.uipanel26,'Visible','on');
    set(handles.CRCPanel,'Visible','on');
    set(handles.uipanel29,'Visible','on');
end
% --------------------------------------------------------------------
function setlegend(handles,language,opt)
global language
if strcmp(opt,'check')
    switch language
        case 'Simplified Chinese'
            legend(handles.axes2,'校验恢复输入码','location','best');
        case 'Traditional Chinese'
            legned(handles.axes2,'校驗恢復輸入碼','location','best');
        case 'English'
            legend(handles.axes2,'Recover the input','location','best');
        case 'Spanish'
            legend(handles.axes2,'Código de entrada de recuperación',...
                'location','best');
        otherwise
             legend(handles.axes2,'Recover the input','location','best');
    end
end
if strcmp(opt,'input')
    switch language
        case 'Simplified Chinese'
            legend(handles.axes1,'输入码','location','best');
        case 'Traditional Chinese'
            legned(handles.axes1,'輸入碼','location','best');
        case 'English'
            legend(handles.axes1,'Input','location','best');
        case 'Spanish'
            legend(handles.axes1,'Código de entrada',...
                'location','best');
        otherwise
             legend(handles.axes1,'Input','location','best');
    end
end
if strcmp(opt,'redundancy')
    switch language
        case 'Simplified Chinese'
            legend(handles.axes2,'发送全码','location','best');
        case 'Traditional Chinese'
            legned(handles.axes2,'發送全碼','location','best');
        case 'English'
            legend(handles.axes2,'Total input','location','best');
        case 'Spanish'
            legend(handles.axes2,'Enviar código completo',...
                'location','best');
        otherwise
             legend(handles.axes2,'Total input','location','best');
    end
end
if strcmp(opt,'none')
    switch language
        case 'Simplified Chinese'
            legend(handles.axes2,'校验结果出错，无法恢复输入码',...
                'FontSize',12,'FontWeight','Bold');
        case 'Traditional Chinese'
            legend(handles.axes2,'校驗結果出錯，無法恢復輸入碼',...
                'FontSize',12,'FontWeight','Bold');
        case 'English'
            legend(handles.axes2,...
                'Error in verification result, unable to recover input code',...
                'FontSize',6,'FontWeight','Bold');
        case 'Spanish'
            legend(handles.axes2,...
'Error en el resultado de la verificación, no se puede recuperar el Código de entrada',...
                'FontSize',6,'FontWeight','Bold');
        otherwise
            legend(handles.axes2,...
                'Error in verification result, unable to recover input code',...
                'FontSize',6,'FontWeight','Bold');
    end
end

            
% --------------------------------------------------------------------
% --- Executes on button press in Fast1.
function Fast_Callback(hObject, eventdata, handles)
% hObject    handle to Fast1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Fast1
