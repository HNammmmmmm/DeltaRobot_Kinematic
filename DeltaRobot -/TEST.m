function varacrgout = TEST(varargin)
% TEST MATLAB code for TEST.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TEST_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TEST_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TEST

% Last Modified by GUIDE v2.5 12-Apr-2022 22:30:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TEST_OpeningFcn, ...
                   'gui_OutputFcn',  @TEST_OutputFcn, ...
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


% --- Executes just before TEST is made visible.
function TEST_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TEST (see VARARGIN)

% Choose default command line output for TEST
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TEST wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TEST_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
theta1=get(handles.slider1,'value');
set(handles.edit1,'string',num2str(theta1));
theta2=get(handles.slider2,'value');
set(handles.edit2,'string',num2str(theta2));
theta3=get(handles.slider3,'value');
set(handles.edit3,'string',num2str(theta3));

%%Gán giá tr? thu duoc vao angle
L=110; %  upper arm
l=215; % lower arm
f=80; % fixed base
e=63.25; % end-effector
a=(f/2-e)/sqrt(3);
b=e/2-f/4;
c=(e-f/2)/(2*sqrt(3));
len=[L,l,f,e,a,b,c];
pi = 3.141592653; % PI
drt = pi/180.0;

%% values used in functions
% rotation around Z axis
R=[cos(-2*pi/3) -sin(-2*pi/3) 0;sin(-2*pi/3) cos(-2*pi/3) 0;0 0 1];
% three joints on fixed base
J1=[0 -f/(2*sqrt(3)) 0];
J2=J1*R;
J3=J2*R;
% calc and plot robot e plate
E1=[0 -e/sqrt(3) 0];
E2=E1*R;
E3=E2*R;
% other easy-cal values
wb=f/(2*sqrt(3));
con=[J1; J2; J3; E1; E2; E3];

angle=[theta1*drt,theta2*drt,theta3*drt];

[x,y,z]=delta_calcForward(theta1,theta2,theta3);% l?y giá tr? c?a v? trí khâu thao tác

pose = [x,y,z];

hold off;

Drawing(len,pose,angle,con,R,wb);

%%%%____________________________________________________________________________



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
theta1=get(handles.slider1,'value');
set(handles.edit1,'string',num2str(theta1));
theta2=get(handles.slider2,'value');
set(handles.edit2,'string',num2str(theta2));
theta3=get(handles.slider3,'value');
set(handles.edit3,'string',num2str(theta3));

%%Gán giá tr? thu duoc vao angle
L=110; %  upper arm
l=215; % lower arm
f=80; % fixed base
e=63.25; % end-effector
a=(f/2-e)/sqrt(3);
b=e/2-f/4;
c=(e-f/2)/(2*sqrt(3));
len=[L,l,f,e,a,b,c];
pi = 3.141592653; % PI
drt = pi/180.0;

%% values used in functions
% rotation around Z axis
R=[cos(-2*pi/3) -sin(-2*pi/3) 0;sin(-2*pi/3) cos(-2*pi/3) 0;0 0 1];
% three joints on fixed base
J1=[0 -f/(2*sqrt(3)) 0];
J2=J1*R;
J3=J2*R;
% calc and plot robot e plate
E1=[0 -e/sqrt(3) 0];
E2=E1*R;
E3=E2*R;
% other easy-cal values
wb=f/(2*sqrt(3));
con=[J1; J2; J3; E1; E2; E3];

angle=[theta1*drt,theta2*drt,theta3*drt];

[x,y,z]=delta_calcForward(theta1,theta2,theta3);% l?y giá tr? c?a v? trí khâu thao tác

pose = [x,y,z];


Drawing(len,pose,angle,con,R,wb)
%%%%____________________________________________________________________________

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




%%%%_____________________________________________________________________________

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

%Set giá tr? thu ???c t? slider
theta1=get(handles.slider1,'value');
set(handles.edit1,'string',num2str(theta1));
theta2=get(handles.slider2,'value');
set(handles.edit2,'string',num2str(theta2));
theta3=get(handles.slider3,'value');
set(handles.edit3,'string',num2str(theta3));

%%Gán giá tr? thu duoc vao angle
L=110; %  upper arm
l=215; % lower arm
f=80; % fixed base
e=63.25; % end-effector
a=(f/2-e)/sqrt(3);
b=e/2-f/4;
c=(e-f/2)/(2*sqrt(3));
len=[L,l,f,e,a,b,c];
pi = 3.141592653; % PI
drt = pi/180.0;

%% values used in functions
% rotation around Z axis
R=[cos(-2*pi/3) -sin(-2*pi/3) 0;sin(-2*pi/3) cos(-2*pi/3) 0;0 0 1];
% three joints on fixed base
J1=[0 -f/(2*sqrt(3)) 0];
J2=J1*R;
J3=J2*R;
% calc and plot robot e plate
E1=[0 -e/sqrt(3) 0];
E2=E1*R;
E3=E2*R;
% other easy-cal values
wb=f/(2*sqrt(3));
con=[J1; J2; J3; E1; E2; E3];

angle=[theta1*drt,theta2*drt,theta3*drt];

[x,y,z]=delta_calcForward(theta1,theta2,theta3);% l?y giá tr? c?a v? trí khâu thao tác

pose = [x,y,z];


Drawing(len,pose,angle,con,R,wb)
%%%%_____________________________________________________________________________






% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in start_bt.
function start_bt_Callback(hObject, eventdata, handles)
% hObject    handle to start_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
L=110; %  upper arm
l=215; % lower arm
f=80; % fixed base
e=63.25; % end-effector
a=(f/2-e)/sqrt(3);
b=e/2-f/4;
c=(e-f/2)/(2*sqrt(3));
len=[L,l,f,e,a,b,c];
pi = 3.141592653; % PI
drt = pi/180.0;

%% values used in functions
% rotation around Z axis
R=[cos(-2*pi/3) -sin(-2*pi/3) 0;sin(-2*pi/3) cos(-2*pi/3) 0;0 0 1];
% three joints on fixed base
J1=[0 -f/(2*sqrt(3)) 0];
J2=J1*R;
J3=J2*R;
% calc and plot robot e plate
E1=[0 -e/sqrt(3) 0];
E2=E1*R;
E3=E2*R;
% other easy-cal values
wb=f/(2*sqrt(3));
con=[J1; J2; J3; E1; E2; E3];

angle=[0,0,0];

[x,y,z]=delta_calcForward(0,0,0);% l?y giá tr? c?a v? trí khâu thao tác

pose = [x,y,z];

Drawing(len,pose,angle,con,R,wb)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stop_bt.
function stop_bt_Callback(hObject, eventdata, handles)
% hObject    handle to stop_bt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%Get data from GUIDE

X=str2num(get(handles.edit4, 'String'));
%set(handles.edit1,'string',num2str(theta1));
Y=str2num(get(handles.edit5, 'String'));
%set(handles.edit2,'string',num2str(theta2));
Z=str2num(get(handles.edit6, 'String'));
%set(handles.edit3,'string',num2str(theta3));



%% values used in Commissioning
% set length
L=110; %  upper arm
l=215; % lower arm
f=80; % fixed base
e=63.25; % end-effector
a=(f/2-e)/sqrt(3);
b=e/2-f/4;
c=(e-f/2)/(2*sqrt(3));
len=[L,l,f,e,a,b,c];
pi = 3.141592653; % PI
drt = pi/180.0;

%% values used in functions
% rotation around Z axis
R=[cos(-2*pi/3) -sin(-2*pi/3) 0;sin(-2*pi/3) cos(-2*pi/3) 0;0 0 1];
% three joints on fixed base
J1=[0 -f/(2*sqrt(3)) 0];
J2=J1*R;
J3=J2*R;
% calc and plot robot e plate
E1=[0 -e/sqrt(3) 0];
E2=E1*R;
E3=E2*R;
% other easy-cal values
wb=f/(2*sqrt(3));
con=[J1; J2; J3; E1; E2; E3];

[q1,q2,q3]=delta_calcInverse(X,Y,Z);% l?y giá tr? c?a v? trí khâu thao tác

angle=[q1*drt,q2*drt,q3*drt];

set(handles.edit9,'string',num2str(q1));
set(handles.edit8,'string',num2str(q2));
set(handles.edit7,'string',num2str(q3));


pose = [X,Y,Z];

Drawing(len,pose,angle,con,R,wb)




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
