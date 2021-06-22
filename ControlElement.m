
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





% --- Executes on button press in Binary.
function Binary_Callback(hObject, eventdata, handles)
% hObject    handle to Binary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Binary


% --- Executes on button press in Hexadecimal.
function Hexadecimal_Callback(hObject, eventdata, handles)
% hObject    handle to Hexadecimal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Hexadecimal



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
                % Ensure the length of the check code is longer than CRC's.
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
            % Ensure the length of the check code is longer than CRC's.
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

global OptDev;
OptDev= get(handles.Opt,'value');

set(handles.Input,'string','Input');
set(handles.BinInput,'string','Binary Input');
set(handles.Redundancy,'string','Redundant Code');
set(handles.Output,'string','Output');
set(handles.Recovery,'string','Recovery');
set(handles.Recheck,'string','Recheck Code');
set(handles.State,'string','>>Default');


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