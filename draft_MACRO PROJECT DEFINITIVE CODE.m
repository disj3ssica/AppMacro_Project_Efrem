clear all; clear session; close all; clc
% directory already set by MatLab
% add toolbox path:
addpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))

%% 1. LOAD & STORE DATA

[xlsdata, xlstext] = xlsread('database_mpshocks_infoshocks.xlsx');
dateStrings = textData(2:end, 1);   % Extract the dates from the first column 
dates       = datetime(dateStrings, 'InputFormat', 'yyyy''m''M');
vnames_long = textData(1, 2:end);   % Retrieve the variable names
vnames      = xlstext(2,2:end);
nvar        = length(vnames);       % num of vars
% data        = Num2NaN(xlsdata);     % (?) fills empty cells with num or NaN




%% 2. PLOT DATA


%% 3. VAR ESTIMATION


%% 4. IDENTIFICATION WITH ZERO CONTEMPORANEOUS RESTRICTIONS 


%% 5. IDENTIFICATION WITH ZERO LONG-RUN RESTRICTIONS 


%% 6. IDENTIFICATION WITH SIGN RESTRICTIONS


%% 7. IDENTIFICATION WITH EXTERNAL INSTRUMENTS


%% 8. IDENTIFICATION WITH A MIX OF EXTERNAL INSTRUMENTS AND SIGN RESTRICTIONS


%% 9. CLEAN UP

% Export tex file
% m2tex('VARToolbox_Primer.m')
% Remove VAR Toolbox from Matlab path
% rmpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR
% toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))