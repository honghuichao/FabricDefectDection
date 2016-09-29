%本程序可以完成布匹疵点检测且本程序是批处理程序。
function varargout = FabricGui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FabricGui_OpeningFcn, ...
    'gui_OutputFcn',  @FabricGui_OutputFcn, ...
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

% --- Executes just before FabricGui is made visible.
function FabricGui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = FabricGui_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;

function hedit_detect_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_detect_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in ptnRun.
function ptnRun_Callback(hObject, eventdata, handles)
%批处理
srcDir=uigetdir('Choose source directory.'); %获得选择的文件夹
cd(srcDir);
allnames=struct2cell(dir('*.bmp')); %只处理8位的bmp文件
[k,len]=size(allnames); %获得bmp文件的个数
%得到设置的参数
P=str2num(get(handles.hedit_zhouqi,'string')); %获得织物纹理周期
T1=str2num(get(handles.hedit_yuzhifenge,'string')); %分割阈值
T2=str2num(get(handles.hedit_yuzhihou,'string')); %后处理阈值
numwu=0;numyou=0;
for ii=1:len
    %逐次取出文件
    cd(srcDir);
    name=allnames{1,ii};
    I=imread(name); %读取文件
    axes(handles.hyuanshiaxes); %显示图像
    imshow(I);
    cd('..');
    I0=I;
    %预处理
    I=double(I0); %数据类型的转换
    [M,N]=size(I);%得到待检测图像的大小
    J=junzhicaiyang(I,M,N,P); %调用均值下采样函数
    J=uint8(J);
    %双线性插值，恢复原来的图像大小
    I1=imresize(J,P,'bilinear'); %双线性插值，恢复原来图像的大小。
    %进行方差下采样，用于增强图像疵点信息
    I1=double(I1);
    J1=fangchacaiyang(I1,M,N,P); %调用方差下采样函数
    J1=uint8(J1);
    %双线性插值，恢复原来图像的大小。
    I=imresize(J1,P,'bilinear');
    %进行二值化及其后处理
    T=Otsu(I);
    %解决了利用大津法不能分辨是否含有疵点的缺陷的缺点，统计发现无疵点图像otsu得到阈值均小于8
    if T<=T1
        T=T1+1;
    end
    I=im2bw(I,T/255); %调用自己编写的Otsu大津法进行二值化操作
    Ibw=imfill(I,'holes'); %填充空洞，特别是对于油污破洞等区域类缺陷来说是必要的
    %去掉小面积的值
    Ibw=bwareaopen(Ibw,T2); %这也是一个可调节的参数
    axes(handles.hyuchuliaxes);
    imshow(Ibw);
    [L,m]=bwlabel(Ibw,8);
    if m>=1
        numyou=numyou+1;
        set(handles.hedit_detect,'string','含疵点')
    else
        numwu=numwu+1;
        set(handles.hedit_detect,'string','无疵点')
    end
end
%统计各种疵点的个数
set(handles.hedit_wu,'string',num2str(numwu));
set(handles.hedit_you,'string',num2str(numyou));
msgbox('织物疵点检测与识别执行完毕！')


% --- Executes on button press in ptnExit.
function ptnExit_Callback(hObject, eventdata, handles)
% hObject    handle to ptnExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.MainFig);

function hedit_zhouqi_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_zhouqi_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hedit_yuzhifenge_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_yuzhifenge_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hedit_yuzhihou_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_yuzhihou_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hedit_you_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_you_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hedit_wu_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function hedit_wu_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
