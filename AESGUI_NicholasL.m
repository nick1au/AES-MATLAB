%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 21, 2016
%AN AES INSPIRED CRYPTOGRAPHICAL ENCRYPTION AND DECRYPTION PROGRAM. USER INPUTS THE DATA,
%USER PASSWORD AND NUMBER OF TIMES TO REPEAT ENCRYPTION/DECRYPTION. IS
%PARTIALLY BASED OFF AES FROM WIKIPEDIA:

%NOTE: BEFORE DATA IS ENCRYPTED, DATA IS PUT INTO SQUARE MATRIX

% KeyExpansions—round keys are derived from the cipher key using Rijndael's key schedule. AES requires a separate 128-bit round key block for each round plus one more.
% InitialRound
% AddRoundKey—each byte of the state is combined with a block of the round key using bitwise xor.
% ---Rounds---
% SubBytes—a non-linear substitution step where each byte is replaced with another according to a lookup table.
% ShiftRows—a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
% MixColumns—a mixing operation which operates on the columns of the state, combining the four bytes in each column.
% AddRoundKey
% ----Final Round (no MixColumns)----
% SubBytes
% ShiftRows
% AddRoundKey.

% SOURCE: https://en.wikipedia.org/wiki/Advanced_Encryption_Standard

function varargout = AESGUI_NicholasL(varargin)
% AESGUI_NICHOLASL MATLAB code for AESGUI_NicholasL.fig
%      AESGUI_NICHOLASL, by itself, creates a new AESGUI_NICHOLASL or raises the existing
%      singleton*.
%
%      H = AESGUI_NICHOLASL returns the handle to a new AESGUI_NICHOLASL or the handle to
%      the existing singleton*.
%
%      AESGUI_NICHOLASL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AESGUI_NICHOLASL.M with the given input arguments.
%
%      AESGUI_NICHOLASL('Property','Value',...) creates a new AESGUI_NICHOLASL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AESGUI_NicholasL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AESGUI_NicholasL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AESGUI_NicholasL

% Last Modified by GUIDE v2.5 21-Aug-2016 14:23:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AESGUI_NicholasL_OpeningFcn, ...
                   'gui_OutputFcn',  @AESGUI_NicholasL_OutputFcn, ...
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


% --- Executes just before AESGUI_NicholasL is made visible.
function AESGUI_NicholasL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AESGUI_NicholasL (see VARARGIN)

% Choose default command line output for AESGUI_NicholasL
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AESGUI_NicholasL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AESGUI_NicholasL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in encrypt_button.
function encrypt_button_Callback(hObject, eventdata, handles)
% hObject    handle to encrypt_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idata = get(handles.input, 'string');
ukey = get(handles.upass, 'string');
urep = str2double(get(handles.num_reps, 'string'));
odata = encrypt(idata,urep,ukey)

set(handles.output_d, 'string', num2str(odata));
cd('%UserProfile%\Desktop');
fid = fopen('output.txt','wt');
fprintf(fid,'%s',odata);
fclose(fid);


% --- Executes on button press in decrypt_button.
function decrypt_button_Callback(hObject, eventdata, handles)
% hObject    handle to decrypt_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
idata = get(handles.input, 'string');
idata = str2num(idata);
ukey = get(handles.upass, 'string');
urep = str2double(get(handles.num_reps, 'string'));
odata = decrypt(idata,urep,ukey)

set(handles.output_d, 'string', num2str(odata));


function num_reps_Callback(hObject, eventdata, handles)
% hObject    handle to num_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_reps as text
%        str2double(get(hObject,'String')) returns contents of num_reps as a double


% --- Executes during object creation, after setting all properties.
function num_reps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_reps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function upass_Callback(hObject, eventdata, handles)
% hObject    handle to upass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of upass as text
%        str2double(get(hObject,'String')) returns contents of upass as a double


% --- Executes during object creation, after setting all properties.
function upass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function final_data = encrypt(input_data,reps,user_key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%FULL PROGRAM "INSPIRED" BY THE AES CRYPTOGRAPHY METHOD. NOT AN EXACT
%RECREATION
%USING THE FOLLOWING FORMAT (WIKIPEDIA):

% KeyExpansions—round keys are derived from the cipher key using Rijndael's key schedule.
% InitialRound
% AddRoundKey—each byte of the state is combined with a block of the round key using bitwise xor.
% --Rounds--
% SubBytes (NOT IMPLEMENTED)—a non-linear substitution step where each byte is replaced with another according to a lookup table.
% ShiftRows—a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
% MixColumns—a mixing operation which operates on the columns of the state, combining the four bytes in each column.
% AddRoundKey
% --------
% Final Round (no MixColumns)
% SubBytes (NOT IMPLEMENTED)
% ShiftRows
% AddRoundKey.

% SOURCE: https://en.wikipedia.org/wiki/Advanced_Encryption_Standard
input_data = int64(input_data);
if(length(user_key) < 4)
    fprintf('The length of the user key is insufficient. Minimum = 4 char. Current = %s',user_key);
    return
end
if (isempty(input_data))
    fprintf('No data inputted');
    return
end
if (reps < 1)
    fprintf('The number of repetitions is insufficient. Minimum >= 1 reps. Current = %d',reps);
    return
end

crypt_key = gen_key(user_key);
final_data = convert_sq(input_data);
final_data = add_key_to_data(final_data,crypt_key);

for (ii = 1:reps)
    final_data = shift_row(final_data);
    final_data = mix_col(final_data,crypt_key);
    final_data = add_key_to_data(final_data,crypt_key);
end

final_data = shift_row(final_data);
final_data = add_key_to_data(final_data,crypt_key);


function final_data = decrypt(input_data,reps,user_key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 21, 2016
%FULL PROGRAM DECRYPTION "INSPIRED" BY THE AES CRYPTOGRAPHY METHOD. NOT AN EXACT
%RECREATION
%USING THE FOLLOWING FORMAT (WIKIPEDIA):

% KeyExpansions—round keys are derived from the cipher key using Rijndael's key schedule.
% InitialRound
% AddRoundKey—each byte of the state is combined with a block of the round key using bitwise xor.
% --Rounds--
% SubBytes (NOT IMPLEMENTED)—a non-linear substitution step where each byte is replaced with another according to a lookup table.
% ShiftRows—a transposition step where the last three rows of the state are shifted cyclically a certain number of steps.
% MixColumns—a mixing operation which operates on the columns of the state, combining the four bytes in each column.
% AddRoundKey
% --------
% Final Round (no MixColumns)
% SubBytes (NOT IMPLEMENTED)
% ShiftRows
% AddRoundKey.

% SOURCE: https://en.wikipedia.org/wiki/Advanced_Encryption_Standard
if(length(user_key) < 4)
    fprintf('The length of the user key is insufficient. Minimum = 4 char. Current = %s',user_key);
    return
end
if (isempty(input_data))
    fprintf('No data inputted');
    return
end
if (reps < 1)
    fprintf('The number of repetitions is insufficient. Minimum >= 1 reps. Current = %d',reps);
    return
end

crypt_key = gen_key(user_key);
final_data = remove_key_from_data(input_data,crypt_key);
final_data = rev_shift_row(final_data);

for (ii = 1:reps)
    final_data = remove_key_from_data(final_data,crypt_key);
    final_data = rev_mix_col(final_data,crypt_key);
    final_data = rev_shift_row(final_data);
end

final_data = remove_key_from_data(final_data,crypt_key);
final_data = convert_line(final_data);
final_data = char(final_data);

function crypt_key = gen_key(user_key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%GENERATES A CRYPTO KEY BASED ON A USER KEY BY ADDING THE ASCII VALUES OF
%THE USER PASSWORD TOGETHER, THEN ADDING 27 AND DIVIDING BY 3. THE VALUE IS
%ROUNDED DOWN IF IT IS A DECIMAL NUMBER
crypt_key = [];
crypt_key = int16(user_key); %CHAR -> ASCII NUMBER
for(ii=1:size(user_key))
    crypt_key = sum(user_key');
end
crypt_key = (crypt_key + 27)/3;
crypt_key = fix(crypt_key);

function output_data = convert_sq(input_data)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%CONVERTS THE INPUT DATA INTO A SQUARE MATRIX. FORMATTING WILL BE LOST IN
%THE PROCESS
sz = size(input_data);




if (sz(1) == sz(2))
    output_data = input_data
else
%     if (sz(2)>sz(1)
        output_data = reshape(input_data,[1 sz(1)*sz(2)])
        mm = 2;
        sz = size(output_data);
        rem = sz(2);
        while(rem/mm > mm) %DETERMINES BEST N-SIZE MATRIX
            mm = mm+1
        end
        
%         while (mod(sz(2),mm) ~= 0)
%             input_data(1:output
        for (ii=1:inf) %DETERMINES M-SIZE FROM N-SIZE
            if((mm*ii) < sz(2)) 
                ii= ii+1;
            else
                break
            end
        end
        output_data
        output_data(1,rem+1:(mm*mm)) = 124; %FILLER DATA = |
            
        output_data = reshape(output_data,[mm,mm]); %RESHAPES INTO SQ MATRIX
end

function output_data = add_key_to_data(input_data,key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%ADDS THE CRYPT KEY GENERATED FROM THE USER PASSWORD TO ALL VALUES
size_d = size(input_data);
size_length = size_d(1)*size_d(2);
output_data = zeros(size_d(1),size_d(2));
% input_data = int64(input_data)

for (jj=1:size_d(1))
    for(ii = 1:size_d(2))
        output_data(jj,ii) = input_data(jj,ii) + key;
    end
end

function output_data = shift_row(input_data)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%SHIFTS THE ROWS OF THE DATA TO THE LEFT BY M-1, WHERE M IS THE CURRENT
%M-POSITION IN THE MATRIX
input_data
sz = size(input_data);
%Where input_data is a square matrix
jump = 0;
new_jump = 0;
output_data = input_data;

for(ii=1:sz(1))
    for(jj=1:sz(2))
        if (jj-jump < 1)
            new_jump = sz(2)-jump+(jj);
%             tmp = (ii,new_jump);
            output_data(ii,new_jump) = input_data(ii,jj);
        else
            output_data(ii,jj-jump) = input_data(ii,jj);
%         tmp = input_data(ii,jj-jump);
        end
    end
    jump = jump + 1;
end

function output_data = mix_col(input_data,key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%MIXES THE COLUMNS BY GENERATING A POLYNOMIAL KEY BY USING THE DIGITS OF
%THE CRYPTO KEY FROM RIGHT TO LEFT AS THE COLUMN ENTRIES OF THE POLY KEY
%THE POLY KEY IS THEN MULTIPLIED INTO THE COLUMNS OF THE DATA
%KEY MUST BE >= 4 char

data_size = size(input_data);
tmp = key;
% str_key = num2str(key)
% len_str = length(str_key)
poly_key = [];


while (length(poly_key) < data_size(2))
    while(tmp >1)
        poly_key(1,length(poly_key)+1) = mod(tmp,10);
        tmp = tmp / 10;
    end
    if (length(poly_key) < data_size(2))
        tmp = key;
    end
end
        
poly_key = fix(poly_key); %Rounds down decimals to nearest whole digit
poly_key = poly_key(1,1:data_size)';
input_data;
for(ii = 1:data_size(2))
    output_data(:,ii) = input_data(:,ii).*poly_key;
end

function output_data = convert_line(input_data)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%CONVERTS THE SQUARE MATRIX DATA INTO A 1XN LINE MATRIX. FORMATTING WILL BE LOST IN
%THE PROCESS
sz = size(input_data);

output_data = reshape(input_data,[1 sz(1)*sz(2)]);
for (ii=1:length(output_data))
    if(output_data(ii) == 124)
        output_data = output_data(1:ii-1);
        break
    end
end

function output_data = rev_shift_row(input_data)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 21, 2016
%SHIFTS THE ROWS OF THE DATA TO THE RIGHT BY M-1, WHERE M IS THE CURRENT
%M-POSITION IN THE MATRIX
input_data
sz = size(input_data);
%Where input_data is a square matrix
jump = 0;
new_jump = 0;
output_data = input_data;

for(ii=1:sz(1))
    for(jj=1:sz(2))
        if (jj+jump > sz(2))
            new_jump = jj+jump-sz(2);
%             tmp = (ii,new_jump);
            output_data(ii,new_jump) = input_data(ii,jj);
        else
            output_data(ii,jj+jump) = input_data(ii,jj);
%         tmp = input_data(ii,jj-jump);
        end
    end
    jump = jump + 1;
end

function output_data = rev_mix_col(input_data,key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%MIXES THE COLUMNS BY GENERATING A POLYNOMIAL KEY BY USING THE DIGITS OF
%THE CRYPTO KEY FROM RIGHT TO LEFT AS THE COLUMN ENTRIES OF THE POLY KEY
%THE POLY KEY IS THEN MULTIPLIED INTO THE COLUMNS OF THE DATA
%KEY MUST BE >= 4 char

data_size = size(input_data);
tmp = key;
% str_key = num2str(key)
% len_str = length(str_key)
poly_key = [];


while (length(poly_key) < data_size(2))
    while(tmp >1)
        poly_key(1,length(poly_key)+1) = mod(tmp,10);
        tmp = tmp / 10;
    end
    if (length(poly_key) < data_size(2))
        tmp = key;
    end
end
        
poly_key = fix(poly_key) %Rounds down decimals to nearest whole digit
poly_key = poly_key(1,1:data_size)';
input_data;
for(ii = 1:data_size(2))
    output_data(:,ii) = input_data(:,ii)./poly_key;
end

function output_data = remove_key_from_data(input_data,key)
%NICHOLAS LAU
%000377939
%LAST EDITED: AUG. 20, 2016
%REMOVE THE CRYPT KEY GENERATED FROM THE USER PASSWORD TO ALL VALUES
size_d = size(input_data);
size_length = size_d(1)*size_d(2);
output_data = zeros(size_d(1),size_d(2));
% input_data = int64(input_data)

for (jj=1:size_d(1))
    for(ii = 1:size_d(2))
        output_data(jj,ii) = input_data(jj,ii) - key;
    end
end



function output_d_Callback(hObject, eventdata, handles)
% hObject    handle to output_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of output_d as text
%        str2double(get(hObject,'String')) returns contents of output_d as a double


% --- Executes during object creation, after setting all properties.
function output_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
