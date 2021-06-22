function varargout = CRC_UDP(varargin)
% CRC_UDP MATLAB code for CRC_UDP.fig
%      CRC_UDP, by itself, creates a new CRC_UDP or raises the existing
%      singleton*.
%
%      H = CRC_UDP returns the handle to a new CRC_UDP or the handle to
%      the existing singleton*.
%
%      CRC_UDP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CRC_UDP.M with the given input arguments.
%
%      CRC_UDP('Property','Value',...) creates a new CRC_UDP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CRC_UDP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CRC_UDP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CRC_UDP

% Last Modified by GUIDE v2.5 19-Jun-2021 14:48:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CRC_UDP_OpeningFcn, ...
                   'gui_OutputFcn',  @CRC_UDP_OutputFcn, ...
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


% --- Executes just before CRC_UDP is made visible.
function CRC_UDP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CRC_UDP (see VARARGIN)

% Choose default command line output for CRC_UDP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CRC_UDP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CRC_UDP_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
