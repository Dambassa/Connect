function varargout = GUI(varargin)
%GUI MATLAB code file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 09-Dec-2020 09:20:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z priority PointCount Random colormatrix Scale Mode K 
if K==0
    K = K+1;
    if handles.radiobutton4 == 1
        handles.uipanel5.Visible = 'on';
        handles.pushbutton1.Enable = 'off';
    else
        handles.uipanel4.Visible = 'on';
    end
    handles.uipanel1.Visible = 'off';
    
elseif K==1
    handles.uipanel4.Visible = 'off';
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%задание основных параметров
    PointCount = str2double(get(handles.edit3, 'String'));
    Random = str2double(get(handles.edit4, 'String'));
    Scale=200;
    rng(Random);
    %%%%%%%%%%%%%%%%%%
    %pd = makedist('Normal','mu',Scale/2,'sigma',20); %нормальное распределение
    %x = random(pd,[1,PointCount]);
    %y = random (pd,[1,PointCount]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    x=rand(1,PointCount)*Scale;
    y=rand(1,PointCount)*Scale;
    if handles.radiobutton5.Value==1 %если 2д
        z=zeros(1,PointCount);
    elseif handles.radiobutton6.Value==1 %3д
        z=rand(1,PointCount)*Scale; 
    end
    %%%%%%%%%%%%%%%%%%%%%need fix   
    x(1,1)=0;
    y(1,1)=200;
    z(1,1)=0;
    %%%%%%%%%%%%%%%%%%Приоритеты
    if handles.radiobutton1.Value == 1
        priority=zeros(1,PointCount);
    elseif handles.radiobutton2.Value == 1
            priority=randi([2,10],1,PointCount);
    elseif handles.radiobutton3.Value == 1
        handles.uipanel4.Visible = 'on';
    end
    
    colormatrix=colorPriority(priority);
    %%%%%%%%%%%%%%%%%%%%подготовка axes
    rotate3d off
    view(0,90);
    axes(handles.axes1);
    set(handles.axes1,'HitTest','on');
    cla(handles.axes1);
    hold on
    xlim([-50 Scale+50]);
    ylim([-50 Scale+50]);
    zlim([-50 Scale+50]);
    DrawLines([],[],[],[],[],[],x,y,z,colormatrix);
    hold off
    %%%%%%%%%%%%
    Mode = 1;
    %%%%%%%%%%%% 
    handles.pushbutton1.Visible = 'off';
    K=K+1;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K Mode
display(K);
if K == 1
    Mode = 0;
    handles.uipanel2.Visible = 'off';
    handles.uipanel6.Visible = 'on';
    handles.text19.String = 'Выберите необходимый режим работы и нажмите "Продолжить"';
elseif K==2
    cla;
    Mode = 0;
    handles.pushbutton7.Visible = 'on';
    handles.uipanel4.Visible = 'off';
    handles.uipanel1.Visible = 'off';
    handles.uipanel6.Visible = 'off';
    handles.uipanel2.Visible = 'on';
    if handles.radiobutton11.Value == 1
        handles.checkbox1.Visible = 'on';
        handles.checkbox1.Value = 1.0;
    end
    handles.text19.String = 'Выберите количество точек на графике и задайте схему построения точек, нажмите "Продолжить". Вернуться назад - кнопка "Назад"'; 
end
if K>1
    K=K-1;
else
    K=K-1;
    handles.pushbutton16.Visible = 'off';
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
closereq;



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


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z colormatrix Scale
assignin('base','x',x);
clusterRad=str2double(get(handles.edit7, 'String'));
[clusterCoord clusterDots]=Forel(x,y,z,clusterRad,Scale);
assignin('base','clusterDots',clusterDots);
axes(handles.axes1);
cla;
hold on
DrawLines([],[],[],[],[],[],x,y,z,colormatrix);
view(0,90);
if  handles.radiobutton5.Value == 1 
%for i=1:size(clusterCoord,1)
%circleCenter=[clusterCoord(i,1) clusterCoord(i,2)];
%viscircles(circleCenter,clusterRad,'Color','blue','LineWidth',1); 
pause(1);
for i=1:1:size(clusterDots,3)
    pause(1);
    color=randi([1 16777215]);
    tempx(1,:)=clusterDots(:,1,i);
    tempy(1,:)=clusterDots(:,2,i);
    tempz(1,:)=clusterDots(:,3,i);
    dotsCount=clusterDots(1,4,i);
    DrawLines([],[],0,[],dotsCount,[],tempx,tempy,tempz,color);

end
elseif handles.radiobutton6.Value == 1 
    rotate3d on
    for i=1:1:size(clusterDots,3)
    color=randi([1 16777215]);
    pause(1);
    tempx(1,:)=clusterDots(:,1,i);
    tempy(1,:)=clusterDots(:,2,i);
    tempz(1,:)=clusterDots(:,3,i);
    dotsCount=clusterDots(1,4,i);
    DrawLines([],[],0,[],dotsCount,[],tempx,tempy,tempz,color);
    end 
    
end
hold off



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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Scale
cla(handles.axes1);
circle_rad=str2double(get(handles.edit6,'String'));
Scale=200;
y_pos=0;
even=0;
counter=1;
while y_pos<=Scale    
    if even
        x_pos=2*circle_rad;
    else
        x_pos=0.5*circle_rad;
    end
    while x_pos<=Scale
        x(1,counter)=x_pos;
        y(1,counter)=y_pos;
        x_pos=x_pos+3*circle_rad;
        counter=counter+1;
    end
    if even
    x(1,counter)=Scale;
    y(1,counter)=y_pos;
    end
    counter=counter+1;
    y_pos=y_pos+(sqrt(3)/2*circle_rad);
    even=xor(even,1);
end
y_pos=Scale;
    if even
        x_pos=2*circle_rad;
    else
        x_pos=0.5*circle_rad;
    end
    while x_pos<=Scale
        x(1,counter)=x_pos;
        y(1,counter)=y_pos;
        x_pos=x_pos+3*circle_rad;
        counter=counter+1;
    end 
    x(1,counter)=Scale;
    y(1,counter)=y_pos;
for i=1:1:counter
    circleCenter=[x(1,i) y(1,i)];
    viscircles(circleCenter,circle_rad,'Color','blue','LineWidth',1); 
end
hold on
plot(x(:),y(:),'o','MarkerEdgeColor','red');
hold off


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Scale
cla(handles.axes1);
circle_rad=str2double(get(handles.edit6,'String'));
side=(2*circle_rad)/sqrt(2);
Scale=200;

if (Scale-(mod((Scale-0.5*circle_rad)/(3*circle_rad)))<0.5*circle_rad)
    
    
end


y_pos=side/2;
counter=1;
while y_pos<=Scale    
    x_pos=side/2;
    while x_pos<=Scale
        x(1,counter)=x_pos;
        y(1,counter)=y_pos;
        x_pos=x_pos+side;
        counter=counter+1;
    end
    x(1,counter)=Scale;
    y(1,counter)=y_pos;
    counter=counter+1;
    y_pos=y_pos+side;
end
y_pos=Scale;
x_pos=side/2;
    while x_pos<=Scale
        x(1,counter)=x_pos;
        y(1,counter)=y_pos;
        x_pos=x_pos+side;
        counter=counter+1;
    end 
    x(1,counter)=Scale;
    y(1,counter)=y_pos;
for i=1:1:counter
    circleCenter=[x(1,i) y(1,i)];
    viscircles(circleCenter,circle_rad,'Color','blue','LineWidth',1); 
end
hold on
plot(x(:),y(:),'o','MarkerEdgeColor','red');
hold off



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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
    rotate3d on
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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z Start Fin priority PointCount Random colormatrix Scale Rad CheckPoint Mode
%%%%%%%%%%%%%%%%%%%%%задание основных значений
Sigma = str2double(get(handles.edit2, 'String'));
Rad = str2double(get(handles.edit1,'String'));
Scale=200;
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
[cost,FullRute]=main(x,y,z,priority,Start,Fin,Rad,Sigma,CheckPoint);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%отрисовка маршрута
cla(handles.axes1);
if handles.radiobutton5.Value==1 %если 3д
   rotate3d on
end
Way = [x(1,FullRute(1,:)); y(1,FullRute(1,:)); z(1,FullRute(1,:))];
hold on
    DrawLines(Way,CheckPoint,cost,Start,Fin,FullRute,x,y,z,colormatrix);
hold off
