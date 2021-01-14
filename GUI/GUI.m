unction varargout = GUI(varargin)
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

<<<<<<< HEAD
% Last Modified by GUIDE v2.5 11-Jan-2021 18:25:47
=======
% Last Modified by GUIDE v2.5 22-Dec-2020 22:59:33
>>>>>>> parent of d28186e... Старая версия

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
movegui(gcf,'center');
global K x y z Start Fin SFcount Mode
Mode=0;
K = 0;
x=[];
y=[];
z=[];
Start =[];
Mode = 0;
Fin=[];
SFcount=0;
handles.uipanel2.Visible = 'off';
handles.uipanel3.Visible = 'off';
handles.uipanel4.Visible = 'off';
handles.uipanel5.Visible = 'off';
handles.pushbutton2.Enable = 'off';
%  tabgp = uitabgroup(gcf,'Position',[.05 .05 .3 .8]);%check
%  tab1 = uitab(tabgp,'Title','Main');
%  uipanel6
%  tab2 = uitab(tabgp,'Title','Options');

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
global x y z Start Fin SFcount Mode priority
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
                handles.pushbutton2.Enable='off';
                pt =  get(gca, 'CurrentPoint');
                minIdx=FindCoord(x,y,pt);
                Start=minIdx;
                hold on
                plot3(x(minIdx),y(minIdx),z(minIdx),'Marker','o','MarkerFaceColor','Green','Hittest','off','MarkerSize',11);
                hold off
            case 2
                axes(handles.axes1);
                set(gca,'Hittest','On');
                handles.pushbutton2.Enable='on';
                pt =  get(gca, 'CurrentPoint');
                minIdx=FindCoord(x,y,pt);
                Fin=minIdx;
                hold on
                plot3(x(minIdx),y(minIdx),z(minIdx),'Marker','o','MarkerFaceColor','Red','Hittest','off','MarkerSize',11);
                hold off 
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
handles.pushbutton2.Enable = 'on';
if K==0
    K = K+1;
    if handles.radiobutton4.Value == 1
        display(K);
        handles.uipanel3.Visible = 'on';
        handles.pushbutton1.Enable = 'off';
    else
        handles.uipanel4.Visible = 'on';
    end
    handles.uipanel1.Visible = 'off';
    
elseif K==1
    handles.uipanel4.Visible = 'off';
    if handles.radiobutton3.Value == 1
        handles.uipanel5.Visible = 'on';
    else
        handles.uipanel2.Visible = 'on';
    end
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
    if handles.radiobutton2.Value == 0
        priority=zeros(1,PointCount);
    elseif handles.radiobutton2.Value == 1
        priority=randi([2,10],1,PointCount);
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
    handles.pushbutton1.Enable = 'off';
    K=K+1;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global K Mode Start Fin 
if K == 1
    Mode = 0;
    handles.pushbutton1.Enable = 'on';
    handles.pushbutton2.Enable = 'off';
    handles.uipanel4.Visible = 'off';
    handles.uipanel3.Visible = 'off';
    handles.uipanel1.Visible = 'on';
    rotate3d off
    cla;
    Start=[];
    Fin=[];
    view(0,90);
elseif K==2
    cla;
    Start=[];
    Fin=[];
    Mode = 0;
    view(0,90);
   if handles.radiobutton3.Value == 1
        handles.uipanel5.Visible = 'off';
   else
       handles.uipanel2.Visible = 'off';
   end
   handles.pushbutton1.Enable = 'on';
   handles.uipanel4.Visible = 'on';
end
K=K-1;
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
function pushbutton6_Callback(hObject, eventdata, handles)%кластеризация
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z colormatrix Scale
assignin('base','x',x);
clusterRad=str2double(get(handles.edit5, 'String'));
[clusterCoord clusterDots]=Forel(x,y,z,clusterRad,Scale);
assignin('base','clusterDots',clusterDots);
axes(handles.axes1);
cla;
hold on
DrawLines([],[],[],[],[],[],x,y,z,colormatrix);
view(0,90);
if  handles.radiobutton5.Value == 1 
for i=1:size(clusterCoord,1)
circleCenter=[clusterCoord(i,1) clusterCoord(i,2)];
plot(circleCenter(1),circleCenter(2),'Marker','o','MarkerEdgeColor','red','MarkerSize',20);
viscircles(circleCenter,clusterRad,'Color','blue','LineWidth',1); 
% for i=1:1:size(clusterDots,3)
%     pause(1);
%     color=randi([1 16777215]);
%     tempx(1,:)=clusterDots(:,1,i);
%     tempy(1,:)=clusterDots(:,2,i);
%     tempz(1,:)=clusterDots(:,3,i);
%     dotsCount=clusterDots(1,4,i);
%     DrawLines([],[],0,[],dotsCount,[],tempx,tempy,tempz,color);
% end
end
elseif handles.radiobutton6.Value == 1 
    rotate3d on
    for i=1:1:size(clusterDots,3)
    color=randi([1 16777215]);
    tempx(1,:)=clusterDots(:,1,i);
    tempy(1,:)=clusterDots(:,2,i);
    tempz(1,:)=clusterDots(:,3,i);
    dotsCount=clusterDots(1,4,i);
    plot3(clusterCoord(i,1),clusterCoord(i,2),clusterCoord(i,3),'Marker','o','MarkerEdgeColor','red','MarkerSize',20);
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
        y_pos=y_pos+(sqrt(3)/2*circle_rad);
        even=xor(even,1);
end
for i=1:1:counter
    circleCenter=[x(1,i) y(1,i)];
    viscircles(circleCenter,circle_rad,'Color','blue','LineWidth',1);
    hold on
    plot(x(i),y(i),'o','MarkerEdgeColor','red');
    hold off
end



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

if (Scale - mod((Scale-0.5*circle_rad),(3*circle_rad))<0.5*circle_rad)   
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
    y_pos=y_pos+side;
end
for i=1:1:counter
    circleCenter=[x(1,i) y(1,i)];
    viscircles(circleCenter,circle_rad,'Color','blue','LineWidth',1); 
    hold on
    plot(x(i),y(i),'o','MarkerEdgeColor','red');
    hold off
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
    cla;
    if handles.radiobutton6.Value==1
    rotate3d on
    else  
    rotate3d off
    end
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
if length(CheckPoint)>9 %Не раобтает. убрать/сделать ?
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
if handles.radiobutton6.Value==1
    rotate3d on
else  
    rotate3d off
end
Way = [x(1,FullRute(1,:)); y(1,FullRute(1,:)); z(1,FullRute(1,:))];
hold on
   DrawLines(Way,CheckPoint,cost,Start,Fin,FullRute,x,y,z,colormatrix);
hold off


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)%замощение шестиугольниками
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Scale
cla(handles.axes1);
circle_rad=str2double(get(handles.edit6,'String'));
Scale=200;
counter=1;
bias = 0;
y_pos = 0.5*circle_rad;
x_pos = bias;
even=0;
for j=0:1:1
    while y_pos<=Scale
        x_pos = bias;
        while x_pos<=Scale
          x(1,counter)=x_pos;
          y(1,counter)=y_pos;
          x_pos=x_pos+2*circle_rad;
          counter=counter+1;
        end
        y_pos=y_pos+(1.5*circle_rad);
        even=xor(even,1);
    end
    bias = circle_rad;
    x_pos = bias;
    y_pos=circle_rad;
end
for i=1:1:counter
    circleCenter=[x(1,i) y(1,i)];
    viscircles(circleCenter,circle_rad,'Color','blue','LineWidth',1);
    hold on
    plot(x(i),y(i),'o','MarkerEdgeColor','red');
    hold off
end
   
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


<<<<<<< HEAD
% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pushbutton11.Visible='off';
handles.pushbutton12.Visible='on';
handles.uipanel7.Visible='on';
handles.uipanel8.Visible='off';
=======


>>>>>>> parent of d28186e... Старая версия

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
<<<<<<< HEAD
handles.pushbutton12.Visible='off';
handles.pushbutton11.Visible='on';
handles.uipanel7.Visible='off';
handles.uipanel8.Visible='on';
word = actxserver('Word.Application');
wdoc = word.Documents.Open('C:\Users\Om\Desktop\Theory.docx');
=======
global K
if handles.radiobutton10.Value==1%тест кластеризации
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%настрока видимости
    handles.uipanel4.Visible=1;
    handles.uipanel8.Visible=1;
   %%%%%%%%%%%%%%%%%%%%%%%%%%  
elseif handles.radiobutton11.Value==1%тест построения маршрутов
    K=0;
    pushbutton1_Callback(hObject, eventdata, handles);
    handles.uipanel10.Visible=1;
elseif handles.radiobutton12.Value==1
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton12.
function pushbutton12_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.uipane7.Visible=xor(handles.uipanel7.Visible,1);

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)%тест кластеризации
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PointCount=str2double(get(handles.edit3,'String'));
Random = str2double(get(handles.edit4, 'String'));
downstep=str2double(get(handles.edit11,'String'));
step=str2double(get(handles.edit9,'String'));
start_radius=str2double(get(handles.edit8,'String'));
fin_radius=str2double(get(handles.edit10,'String'));
Scale=200;
rng(Random); 
cluster_radius=[];
dots_count=[];
dots_matrix=[];
dots_table_names=[];  
for rad=start_radius:step:fin_radius
    cluster_radius=[cluster_radius; rad];      
end
radius_table=table(cluster_radius);
tempPC=PointCount;
while tempPC>0
   for rad=start_radius:step:fin_radius
        x=rand(1,tempPC)*Scale;
        y=rand(1,tempPC)*Scale;
        if handles.radiobutton5.Value==1 %если 2д
            z=zeros(1,tempPC);
        elseif handles.radiobutton6.Value==1 %3д
            z=rand(1,tempPC)*Scale;
        end
       [clusterCoord clusterDots]=Forel(x,y,z,rad,Scale);
       dots_count=[dots_count; size(clusterDots,3)];
   end
       dots_matrix=[dots_matrix dots_count];%кол-во точек в каждом кластере
       dots_count=[];
       dots_table_names=[dots_table_names,strcat("Clusters_count_(",num2str(tempPC),"_dots)")];
       tempPC=tempPC-downstep;
end
dots_table=array2table(dots_matrix);
dots_table.Properties.VariableNames=dots_table_names;
result_table=cat(2,radius_table,dots_table); 
name=strcat('t1_Rng',num2str(Random),'_PC',num2str(PointCount),'_Scale',num2str(Scale),'.xls');
[filename path]=uiputfile(name);
path=strcat(path,filename);
writetable(result_table,path,'Sheet',filename);


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)%тест маршрутов
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x y z Start Fin priority Random PointCount
Scale=200;
step=str2double(get(handles.edit14,'String'));
startradius=str2double(get(handles.edit12,'String'));
endradius=str2double(get(handles.edit15,'String'));
cost=NaN;
rute_array=[];
cost_array=[];
rad_array=[];
for i=startradius:step:endradius
[cost,FullRute]=main(x,y,z,priority,Start,Fin,i,0,[]);
if cost>2
    cost=NaN;
    FullRute=[];
end
rute_array=[rute_array;length(FullRute)];
cost_array=[cost_array;cost];
rad_array=[rad_array;i];
end
result_table=table(rad_array,rute_array,cost_array);
result_table.Properties.VariableNames={'action_radius','dots_in_rute','rute_cost'};
name=strcat('t2_Rng',num2str(Random),'_PC',num2str(PointCount),'_Scale',num2str(Scale),'.xls');
[filename path]=uiputfile(name);
path=strcat(path,filename);
writetable(result_table,path,'Sheet',filename);


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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





function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
>>>>>>> parent of d28186e... Старая версия
