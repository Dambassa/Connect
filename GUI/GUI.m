function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop. All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 12-Oct-2020 10:15:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes1);
global K x y z Start Fin SFcount Mode % K - счетчик для перехода между менюшками:)
Mode=0;
K = 0;
x=[];
y=[];
z=[];
Start =[];
Mode = 0;
Fin=[];
SFcount=0;
handles.pushbutton1.Enable = 'off';
handles.pushbutton3.Enable = 'off';
handles.pushbutton4.Enable = 'off';
handles.pushbutton5.Enable='off';
% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K
global x y z priority PointCount Random colormatrix Scale
global Mode
if K==0
    handles.uipanel6.Visible = 'off';
    handles.uipanel2.Visible = 'on';
    if handles.radiobutton11.Value == 1
        handles.checkbox1.Visible = 'on';
        handles.checkbox1.Value = 1.0;
    end
    handles.text19.String = 'Выберите количество точек на графике и задайте тип случайного генератора точек, затем нажмите далее. Если хотите вернуться назад - нажмите "Назад"';
    K = K+1;
elseif K==1
    format long
    PointCount = str2double(get(handles.edit5, 'String'));
    Random = str2double(get(handles.edit6, 'String'));
    Scale=200;
    rng(Random);
    handles.pushbutton3.Enable = 'on';
    handles.pushbutton4.Enable = 'off';
    handles.pushbutton1.Enable = 'off';
    %%%%%%%%%%%%%%%%%%%%
    axes(handles.axes1);
    ax=gca;
    ax.HitTest='on';
    %%%%%%%%%%%%%%%%%%
    %pd = makedist('Normal','mu',Scale/2,'sigma',20); %нормальное распределение
    %x = random(pd,[1,PointCount]);
    %y = random (pd,[1,PointCount]);
    x=rand(1,PointCount)*Scale;
    y=rand(1,PointCount)*Scale;
    if handles.radiobutton4.Value==1 %если 2д
        z=zeros(1,PointCount);
    elseif handles.radiobutton5.Value==1 %3д
        z=rand(1,PointCount)*Scale; 
    end
    %%%%%%%%%%%%%%%%%%%%%    
    x(1,1)=0;
    y(1,1)=200;
    z(1,1)=0;
    %%%%%%%%%%%%%%%%%%Приоритеты
    if get(handles.checkbox1,'Value')
        priority=randi([2,10],1,PointCount);
    else
        priority=zeros(1,PointCount);
    end
    colormatrix=colorPriority(priority);
    %%%%%%%%%%%%%%%%%%%%
    axes(handles.axes1);
    cla(handles.axes1);
    hold on
    xlim([-50 Scale+50]);
    ylim([-50 Scale+50]);
    zlim([-50 Scale+50]);
    for i=1:1:length(x)
        plot3(x(1,i),y(1,i),z(1,i),'Marker','o','MarkerEdgeColor','#ffcd75','MarkerFaceColor',colormatrix(1,i),'Hittest','off','MarkerSize',11);
    end
    a=zeros(1,length(x));
    for i=1:length(x)
        a(1,i)=i;
    end
    text(x(:)-0.7,y(:)+0.1,z(:),string(a),'Fontsize',8,'Hittest','off');
    hold off
    %%%%%%%%%%%% кто б знал зачем это...Было в pushbutton3(Его больше нет)
    format long
    Mode = 1;
    handles.pushbutton1.Enable = 'off';
    handles.pushbutton2.Enable = 'off';
    handles.pushbutton3.Enable = 'off';
    handles.pushbutton4.Enable = 'off';
    %%%%%%%%%%%%
    
    if handles.radiobutton13.Value == 1
        handles.uipanel1.Visible = 'on';
        handles.uipanel2.Visible = 'off';
    elseif handles.radiobutton11.Value == 1
        handles.uipanel1.Visible = 'on';
        handles.uipanel2.Visible = 'off';
    elseif handles.radiobutton12.Value == 1
        handles.uipanel4.Visible = 'on';
        handles.uipanel1.Visible = 'off';
        handles.uipanel2.Visible = 'off';
    end
    K=K+1;
elseif K == 2
    
end


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


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z Start Fin priority PointCount Random colormatrix Scale Rad CheckPoint Mode
Sigma = str2double(get(handles.edit4, 'String'));
Rad = str2double(get(handles.edit3,'String'));
Scale=200;
handles.pushbutton3.Enable = 'off';
handles.pushbutton4.Enable = 'off';
Mode=0;
rng(Random);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%тест
assignin('base','x',x);
assignin('base','y',y);
assignin('base','z',z);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%колличество контрольных точек
priority(1,Start)=0;
priority(1,Fin)=0;
CheckPoint=[];
j=1;
for i=1:1:PointCount
    if  priority(1,i)==1
        CheckPoint(1,j)=i; 
        j=j+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% путь между контрольными точками 
if length(CheckPoint)>9 
    answer=questdlg('Too much checkpoints. Do you want to use an imprecise method ?',...
        'Menu',...
        'Yes','No','Return');
    switch answer
        case 'Yes'
        case 'No'
            pushbutton2_Callback(hObject, eventdata, handles);
        case 'Refresh'
            pushbutton2_Callback(hObject, eventdata, handles);
    end 
else
[cost,FullRute]=main(x,y,z,priority,Start,Fin,Rad,Sigma,CheckPoint);%norm
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
cla;
handles.pushbutton5.Enable='on';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Way = [x(1,FullRute(1,:)); y(1,FullRute(1,:));z(1,FullRute(1,:))];%norm
hold on
DrawLines(Way,CheckPoint,cost,Start,Fin,FullRute,x,y,z,colormatrix);%norm
hold off
%%%%%%%%%%%%%%%%%%


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

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z Start Fin SFcount Mode priority pt
format long
if isempty(x) && isempty(y)
Mode = 0;
end
switch Mode
    case 0    
    case 1 %выбор старта и финиша
        SFcount = SFcount + 1;
        switch SFcount
            case 1
                axes(handles.axes1);
                set(gca,'Hittest','On');
                pt =  get(gca, 'CurrentPoint');
                minIdx=FindCoord(x,y,pt);
                Start=minIdx;
                hold on
                plot3(x(minIdx),y(minIdx),z(minIdx),'Marker','o','MarkerFaceColor','Green','Hittest','off','MarkerSize',11);
                hold off
            case 2
                axes(handles.axes1);
                set(gca,'Hittest','On');
                pt =  get(gca, 'CurrentPoint');
                minIdx=FindCoord(x,y,pt);
                Fin=minIdx;
                hold on
                plot3(x(minIdx),y(minIdx),z(minIdx),'Marker','o','MarkerFaceColor','Red','Hittest','off','MarkerSize',11);
                hold off 
                handles.pushbutton1.Enable = 'on';
                handles.pushbutton2.Enable = 'on';
                handles.pushbutton3.Enable = 'off';
                handles.pushbutton4.Enable = 'on';
                %set(gca,'Hittest','Off');
                SFcount = 0;
                Mode=2;
       end
    case 2 %выбор контрольных точек
        pt =  get(gca, 'CurrentPoint');
        minIdx=FindCoord(x,y,pt);
        priority(1,minIdx)=1;
        hold on
        plot3(x(minIdx),y(minIdx),z(minIdx),'Marker','o','MarkerFaceColor','Blue','Hittest','off','MarkerSize',11);
        hold off
 
end      

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mode
Mode = 2;
axes(handles.axes1);
set(gca,'Hittest','On');

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton4.
function pushbutton4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
global x y z priority Start Fin Rad CheckPoint colormatrix
len=length(x);
anySigmaRute=zeros(Rad,len);
counter=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%
for sigma=0.1:0.1:Rad
counter=counter+1;    
[cost,FullRute]=main(x,y,z,priority,Start,Fin,Rad,sigma,CheckPoint);
for j=1:1:length(FullRute)
    anySigmaRute(counter,j)=FullRute(1,j);  
end
if cost==Inf
    anySigmaRute(counter,len+1)=0;
else
    anySigmaRute(counter,len+1)=length(FullRute);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
[goodSigma]=findSigma(anySigmaRute,Rad);
for i=1:length(goodSigma)
    a=[];
    for j=1:1:anySigmaRute(goodSigma(1,i),size(anySigmaRute,2))
    a(1,j)=anySigmaRute(goodSigma(1,i),j);%матрица точек нормальной сигмы
    end
    figure (i);
    cla;
    cost=10;%костыль
    hold on
    Way = [x(1,a(1,:)); y(1,a(1,:)); z(1,a(1,:))];
    title(['\fontsize{16}σ = ',num2str(goodSigma(i)/10)]);
    DrawLines(Way,CheckPoint,cost,Start,Fin,a,x,y,z,colormatrix);
    hold off
end
assignin('base','anySigmaRute',anySigmaRute);
assignin('base','goodSigma',goodSigma);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y Scale
assignin('base','x',x);
clusterRad=str2double(get(handles.edit7, 'String'));
[clusterCoord clusterDots]=Forel(x,y,clusterRad,Scale);
assignin('base','clusterDots',clusterDots);
axes(handles.axes1);
for i=1:size(clusterCoord,1)
viscircles(clusterCoord(i,:),clusterRad,'Color','blue','LineWidth',1);  
end
