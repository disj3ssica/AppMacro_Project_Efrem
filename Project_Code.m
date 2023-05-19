clearvars, clc
% load toolbox
addpath(genpath('C:\Program Files\MATLAB\R2023a\VAR-Toolbox-main\v3dot0'))
% set directory
cd 'C:\Users\Jessica\Desktop\Applied Macro Project'

% load data

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







% remove toolbox (ADVISED ON GITHUB https://github.com/ambropo/VAR-Toolbox
% )
rmpath(genpath('C:\Program Files\MATLAB\R2023a\VAR-Toolbox-main\v3dot0'))