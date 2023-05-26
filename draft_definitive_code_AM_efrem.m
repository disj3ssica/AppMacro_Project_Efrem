clear; clear session; close all; clc
% directory already set by MatLab
% add toolbox path:
addpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))

%% 1. LOAD & STORE DATA

[xlsdata, xlstext] = xlsread('database_mpshocks_infoshocks.xlsx');
dateStrings = xlstext(2:end, 1);
dates = datetime(dateStrings, "InputFormat",'yyyy''m''M','Format','dd/MM/uuuu');
datesnum = Date2Num(dateStrings);
%dateCellArray = cellstr(dates);     % store dates as a 'cell' type and not a 'datetime' type, to count them later
vnames = xlstext(1, 2:end);    % Retrieve the variable names

nvar    = length(vnames);  % num of vars
nobs    = size(dates,1);        % num of observ

data   = Num2NaN(xlsdata);

% Store variables in the structure DATA
for ii = 1:length(vnames)
    DATA.(vnames{ii}) = data(:, ii);
end % structure a bit weird don't know if it works



%% 2. PLOT ALL VARIABLES IN DATA [works]

FigSize(50,10)   % FigSize(xdim,ydim)

for ii=1:nvar
    subplot(4,2,ii) % SUBPLOT(m,n,p) divides the current figure into an m-by-n grid
    H(ii) = plot(DATA.(vnames{ii}),'LineWidth',3,'Color',cmap(1));
    title(vnames(ii)); 
    DatesPlot(datesnum(1),nobs,6,'m') % Set the x-axis label dates
    grid on; 
end
%SaveFigure('graphics/SW_DATA',1)
%clf('reset')

%% 3. VAR ESTIMATION
%************************************************************************** 
% VAR estimations is achieved in two steps: 
%       (1) define the endogenous variables, the desired number of lags, and deterministic variables; 
%       (2) run the VARmodel function.




%% 9. CLEAN UP

% Export tex file
% m2tex('VARToolbox_Primer.m')
% Remove VAR Toolbox from Matlab path
% rmpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR
% toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))