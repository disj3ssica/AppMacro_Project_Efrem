clearvars, clc
% add toolbox path
addpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))
% directory already set by MatLab

%% 1. LOAD & STORE DATA
[numData, textData, ~] = xlsread('database_mpshocks_infoshocks.xlsx');

% STORE VAR NAMES AND DATES IN 1 TABLE

dateStrings = textData(2:end, 1);   % Extract the dates from the first column of the text data
dates = datetime(dateStrings, 'InputFormat', 'yyyy''m''M');

variableNames = textData(1, 2:end); % Retrieve the variable names from the first row of the text data

dataTable = array2table(numData, 'VariableNames', variableNames);   % Combine variable names and corresponding data into a table

dataTable.Date = dates;             % Add dates as a new column to the table

% *************************************************************************
% transform CPI in 100*log(CPI)
% Extract the "CPI core" column from the dataTable
CPIcore = dataTable.('CPI core (less food and energy) index (US city average)');
logCPI  = 100 * log(CPIcore);
dataTable.LogCPI = logCPI;  % Add the new variable to the dataTable

%% 2. ESTIMATE VAR
% Perform vector autogressive (VAR) estimation with OLS 
%========================================================================
% [VAR, VARopt] = VARmodel(ENDO,nlag,const,EXOG,nlag_ex)
% -----------------------------------------------------------------------
% INPUT
%	- ENDO: an (nobs x nvar) matrix of y-vectors
%	- nlag: lag length
% -----------------------------------------------------------------------
% OPTIONAL INPUT
%	- const: 0 no constant; 1 constant; 2 constant and trend; 3 constant 
%       and trend^2 [dflt = 0]
%	- EXOG: optional matrix of variables (nobs x nvar_ex)
%	- nlag_ex: number of lags for exogeonus variables [dflt = 0]
% -----------------------------------------------------------------------
% OUTPUT
%   - VAR: structure including VAR estimation results
%   - VARopt: structure including VAR options (see VARoption)
% -----------------------------------------------------------------------
nvar = length(variableNames)
data   = Num2NaN(numData)






%% 3. ESTIMATE IRF




% remove toolbox (ADVISED ON GITHUB https://github.com/ambropo/VAR-Toolbox
% )
rmpath(genpath('C:\Users\cremj\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))