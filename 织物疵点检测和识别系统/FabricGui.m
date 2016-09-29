%�����������ɲ�ƥ�õ����ұ����������������
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
%������
srcDir=uigetdir('Choose source directory.'); %���ѡ����ļ���
cd(srcDir);
allnames=struct2cell(dir('*.bmp')); %ֻ����8λ��bmp�ļ�
[k,len]=size(allnames); %���bmp�ļ��ĸ���
%�õ����õĲ���
P=str2num(get(handles.hedit_zhouqi,'string')); %���֯����������
T1=str2num(get(handles.hedit_yuzhifenge,'string')); %�ָ���ֵ
T2=str2num(get(handles.hedit_yuzhihou,'string')); %������ֵ
numwu=0;numyou=0;
for ii=1:len
    %���ȡ���ļ�
    cd(srcDir);
    name=allnames{1,ii};
    I=imread(name); %��ȡ�ļ�
    axes(handles.hyuanshiaxes); %��ʾͼ��
    imshow(I);
    cd('..');
    I0=I;
    %Ԥ����
    I=double(I0); %�������͵�ת��
    [M,N]=size(I);%�õ������ͼ��Ĵ�С
    J=junzhicaiyang(I,M,N,P); %���þ�ֵ�²�������
    J=uint8(J);
    %˫���Բ�ֵ���ָ�ԭ����ͼ���С
    I1=imresize(J,P,'bilinear'); %˫���Բ�ֵ���ָ�ԭ��ͼ��Ĵ�С��
    %���з����²�����������ǿͼ��õ���Ϣ
    I1=double(I1);
    J1=fangchacaiyang(I1,M,N,P); %���÷����²�������
    J1=uint8(J1);
    %˫���Բ�ֵ���ָ�ԭ��ͼ��Ĵ�С��
    I=imresize(J1,P,'bilinear');
    %���ж�ֵ���������
    T=Otsu(I);
    %��������ô�򷨲��ֱܷ��Ƿ��дõ��ȱ�ݵ�ȱ�㣬ͳ�Ʒ����޴õ�ͼ��otsu�õ���ֵ��С��8
    if T<=T1
        T=T1+1;
    end
    I=im2bw(I,T/255); %�����Լ���д��Otsu��򷨽��ж�ֵ������
    Ibw=imfill(I,'holes'); %���ն����ر��Ƕ��������ƶ���������ȱ����˵�Ǳ�Ҫ��
    %ȥ��С�����ֵ
    Ibw=bwareaopen(Ibw,T2); %��Ҳ��һ���ɵ��ڵĲ���
    axes(handles.hyuchuliaxes);
    imshow(Ibw);
    [L,m]=bwlabel(Ibw,8);
    if m>=1
        numyou=numyou+1;
        set(handles.hedit_detect,'string','���õ�')
    else
        numwu=numwu+1;
        set(handles.hedit_detect,'string','�޴õ�')
    end
end
%ͳ�Ƹ��ִõ�ĸ���
set(handles.hedit_wu,'string',num2str(numwu));
set(handles.hedit_you,'string',num2str(numyou));
msgbox('֯��õ�����ʶ��ִ����ϣ�')


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
