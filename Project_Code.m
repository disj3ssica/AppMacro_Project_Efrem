clearvars, clc
% load toolbox
addpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))
% directory already set by MatLab

%% 1. LOAD & STORE DATA
[numData, textData, ~] = xlsread('database_mpshocks_infoshocks.xlsx');

% STORE VAR NAMES AND DATES IN 1 TABLE
% Extract the dates from the first column of the text data
dateStrings = textData(2:end, 1);
dates = datetime(dateStrings, 'InputFormat', 'yyyy''m''M');
% Retrieve the variable names from the first row of the text data
variableNames = textData(1, 2:end);
% Combine variable names and corresponding data into a table
dataTable = array2table(numData, 'VariableNames', variableNames);
% Add dates as a new column to the table
dataTable.Date = dates;

% *************************************************************************
% transform CPI in 100*log(CPI)
% Extract the "CPI core" column from the dataTable
CPIcore = dataTable.('CPI core (less food and energy) index (US city average)');
logCPI = 100 * log(CPIcore);
dataTable.LogCPI = logCPI;  % Add the new variable to the dataTable

% 




% remove toolbox (ADVISED ON GITHUB https://github.com/ambropo/VAR-Toolbox
% )
rmpath(genpath('C:\Users\cremj\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))