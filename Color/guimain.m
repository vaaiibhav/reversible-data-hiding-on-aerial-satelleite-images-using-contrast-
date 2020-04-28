function varargout = guimain(varargin)
% GUIMAIN MATLAB code for guimain.fig
%      GUIMAIN, by itself, creates a new GUIMAIN or raises the existing
%      singleton*.
%
%      H = GUIMAIN returns the handle to a new GUIMAIN or the handle to
%      the existing singleton*.
%
%      GUIMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIMAIN.M with the given input arguments.
%
%      GUIMAIN('Property','Value',...) creates a new GUIMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guimain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guimain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guimain

% Last Modified by GUIDE v2.5 28-Aug-2018 13:44:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guimain_OpeningFcn, ...
                   'gui_OutputFcn',  @guimain_OutputFcn, ...
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


% --- Executes just before guimain is made visible.
function guimain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guimain (see VARARGIN)

% Choose default command line output for guimain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guimain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guimain_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_selectImage.
function btn_selectImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_selectImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Change direction
prev_dir = pwd; file_dir = fileparts(mfilename('fullpath')); cd(file_dir);
addpath(genpath(pwd));
%% Main code
% I = double(imread('lenna.pgm'));
[filen, pathn] =uigetfile('*.*','Select Image');
imagefile = strcat(pathn,filen);
I = imread(imagefile);
answer = inputdlg('Enter The String to Watermark','Reversible Watermarking',1);
embedRate = 0.5;
[wI,actualEmbedRate,PSNR,embedded_string] = reversible(I,embedRate,answer);
axes(handles.axes1);
imshow(I);
title('orignal image ');
figure(2)
hist(I(3),0:255) 
hist(I(1),0:255) 
hist(I(2),0:255) 

axes(handles.axes3);
imshow(wI/255);
title('Hiding Image'); 
figure(2)
redChannel = I(:, :, 1);
greenChannel = I(:, :, 2);
blueChannel = I(:, :, 3);
%J = histeq(I);
hsv = rgb2hsv(I);
h = hsv(:, :, 1); % Hue image.
s = hsv(:, :, 2); % Saturation image.
v = hsv(:, :, 3); % Value (intensity) image.
V_hist = histeq(v);
HSV_IM = [h,s,v];

improvedHSVImage = cat(3, h, s, mat2gray(V_hist));
J = hsv2rgb(improvedHSVImage);
axes(handles.axes3);
imshow(J);
title('Enhanced Image'); 
ree = ree(I,J);
rce= rce(I,J);
rmbe = rmbe(I,J);


fprintf('The PSNR of Image is: %.2f dB \n',PSNR);
fprintf('The actual embedding rate is %.2f bpp \n',actualEmbedRate);
h = msgbox(embedded_string);

ree =0;
rce=0;
rmbe = 0;
ree = ree(I,J);
rce= rce(I,J);
rmbe = rmbe(I,J);
%rss = rss(I,J);
fprintf ('THe Ree ');
disp(ree);
fprintf ('THe Rce ');
disp(rce);
fprintf ('THe Rmbe' );
disp(rmbe);
% %fprintf ('THe Rss '+rss);
fprintf('The PSNR of Image is: %.2f dB \n',PSNR);
fprintf('The actual embedding rate is %.2f bpp \n',actualEmbedRate);
% h = msgbox(embedded_string);
set(handles.text3, 'String', embedded_string);

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


% --- Executes on button press in btn_encrypttext.
function btn_encrypttext_Callback(hObject, eventdata, handles)
% hObject    handle to btn_encrypttext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
