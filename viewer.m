function varargout = viewer(varargin)
% VIEWER M-file for viewer.fig
%      VIEWER, by itself, creates a new VIEWER or raises the existing
%      singleton*.
%
%      H = VIEWER returns the handle to a new VIEWER or the handle to
%      the existing singleton*.
%
%      VIEWER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIEWER.M with the given input arguments.
%
%      VIEWER('Property','Value',...) creates a new VIEWER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before viewer_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to viewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help viewer

% Last Modified by GUIDE v2.5 24-Feb-2010 15:10:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @viewer_OpeningFcn, ...
                   'gui_OutputFcn',  @viewer_OutputFcn, ...
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


% --- Executes just before viewer is made visible.
function viewer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to viewer (see VARARGIN)

% Choose default command line output for viewer
handles.output = hObject;


% UIWAIT makes viewer wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Load image, and set the two sliders to the min and max values of the
% image.
handles.img = varargin{1};
handles.imgmax = max(max(handles.img));
handles.imgmin = min(min(handles.img));
% Show the image
axes(handles.axes1);
image((handles.img-handles.imgmin)*60/(handles.imgmax-handles.imgmin));
colormap(jet(128));
% Set the scales
set(handles.sliderLow, 'Min', handles.imgmin);
set(handles.sliderLow, 'Max', handles.imgmax);
set(handles.sliderLow, 'Value', handles.imgmin);
set(handles.sliderHigh, 'Min', handles.imgmin);
set(handles.sliderHigh, 'Max', handles.imgmax);
set(handles.sliderHigh, 'Value', handles.imgmax)
set(handles.slider3, 'Min', 1);
set(handles.slider3, 'Max', size(handles.img, 1));
set(handles.slider3, 'Value', floor(size(handles.img, 1) / 2));
redrawImage(handles);

% Plot one line from the image
axes(handles.axes2);
linen = floor(get(handles.slider3, 'Value'));
plot(handles.img(linen, :));
axes(handles.axes1);
line([0, size(handles.img, 2)], [linen, linen]);



% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = viewer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function sliderLow_Callback(hObject, eventdata, handles)
% hObject    handle to sliderLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.edit1, 'String', get(handles.sliderLow, 'Value'));
set(handles.edit2, 'String', get(handles.sliderHigh, 'Value'));
set(handles.axes2, 'YLim', [get(handles.sliderLow, 'Value'), get(handles.sliderHigh, 'Value')]);
redrawImage(handles);

% --- Executes during object creation, after setting all properties.
function sliderLow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderLow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function sliderHigh_Callback(hObject, eventdata, handles)
% hObject    handle to sliderHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.edit1, 'String', get(handles.sliderLow, 'Value'));
set(handles.edit2, 'String', get(handles.sliderHigh, 'Value'));
set(handles.axes2, 'YLim', [get(handles.sliderLow, 'Value'), get(handles.sliderHigh, 'Value')]);
redrawImage(handles);

% --- Executes during object creation, after setting all properties.
function sliderHigh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderHigh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% Plot one line from the image
axes(handles.axes2);
linen = floor(get(handles.slider3, 'Value'));
linen = 1 + size(handles.img, 1) - linen;
plot(handles.img(linen, :));
set(handles.axes2, 'XLim', [0, size(handles.img, 2)]);
set(handles.axes2, 'YLim', [get(handles.sliderLow, 'Value'), get(handles.sliderHigh, 'Value')]);
axes(handles.axes1);
redrawImage(handles);
%linen = linen / size(handles.img, 1);
%imin = get(handles.sliderLow, 'Value');
%imax = get(handles.sliderHigh, 'Value');
%image((handles.img-imin)*64/(imax-imin));
line([0, size(handles.img, 2)], [linen, linen]);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

axes(handles.axes1);
contents = get(hObject, 'String');
colormap(gray(256));
colormap(contents{get(hObject, 'Value')});


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

colormaps{1} = 'JET';
colormaps{2} = 'Autumn';
colormaps{3} = 'Gray';
set(hObject, 'String', colormaps);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double

set(handles.sliderLow, 'Value', str2double(get(hObject,'String')));
redrawImage(handles);


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

set(handles.sliderHigh, 'Value', str2double(get(hObject,'String')));
redrawImage(handles);


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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

filename = get(handles.edit3,'String');
disp(strcat('Exporting image: "', filename, '"'));

% Rescale image
imin = get(handles.sliderLow, 'Value');
imax = get(handles.sliderHigh, 'Value');
temp = double((double(handles.img)-imin)/(imax-imin));

% Truncate the range
id = temp > 1;
temp(id) = 1;
id = temp < 0;
temp(id) = 0;

contents = get(handles.popupmenu1, 'String');
selectedColorMap = contents{get(handles.popupmenu1, 'Value')};

if(strcmp(selectedColorMap, 'JET'))
    imwrite(128*temp, jet(128), filename);
end
if(strcmp(selectedColorMap, 'Autumn'))
    imwrite(128*temp, autumn(128), filename);
end
if(strcmp(selectedColorMap, 'Gray'))
    imwrite(128*temp, gray(128), filename);
end


% --- Executes on button press in pushbuttonZoom.
function pushbuttonZoom_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
zoom


function redrawImage(handles)

axes(handles.axes1);
zoom reset;
imin = get(handles.sliderLow, 'Value');
imax = get(handles.sliderHigh, 'Value');
temp = double((handles.img-imin))/(imax-imin);

% Truncate the range
id = temp > 1;
temp(id) = 1;
id = temp < 0;
temp(id) = 0;

image(256*temp);
zoom out;

return;


% --- Executes on button press in pushbuttonReloadImage.
function pushbuttonReloadImage_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonReloadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
imin = get(handles.sliderLow, 'Value');
imax = get(handles.sliderHigh, 'Value');
image((handles.img-imin)*256/(imax-imin));
redrawImage(handles);


% --- Executes on slider movement.
function sliderCoverage_Callback(hObject, eventdata, handles)
% hObject    handle to sliderCoverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


usePercentilesAsLimits(hObject, handles);
redrawImage(handles);



function usePercentilesAsLimits(hObject, handles)

if(exist('handles.vals') == 0)
    handles.vals = handles.img(:);
end

x = 100 * get(handles.sliderCoverage, 'Value');
handles.lowval = prctile(handles.vals, 100-x);
handles.highval = prctile(handles.vals, x);


% Update scale limits
set(handles.sliderLow, 'Min', handles.lowval);
set(handles.sliderLow, 'Max', handles.highval);
set(handles.sliderHigh, 'Min', handles.lowval);
set(handles.sliderHigh, 'Max', handles.highval);

% Ensure that the value is inside the limits.
val = get(handles.sliderLow, 'Value');
if(val < handles.lowval || handles.highval < val)
    set(handles.sliderLow, 'Value', handles.lowval);
end
val = get(handles.sliderHigh, 'Value');
if(val < handles.lowval || handles.highval < val)
    set(handles.sliderHigh, 'Value', handles.highval);
end

% Update handles structure
guidata(hObject, handles);

   

% --- Executes during object creation, after setting all properties.
function sliderCoverage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderCoverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbuttonInvert.
function pushbuttonInvert_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonInvert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.img = -handles.img;

valNewHigh = -get(handles.sliderLow, 'Value');
valNewLow = -get(handles.sliderHigh, 'Value');

set(handles.sliderLow, 'Value', valNewLow);
set(handles.sliderHigh, 'Value', valNewHigh);

usePercentilesAsLimits(hObject, handles);

redrawImage(handles);

guidata(hObject, handles);
