clear; clear session; close all; clc
% directory already set by MatLab
% add toolbox path:
addpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))

%% 1.   LOAD & STORE DATA

[xlsdata, xlstext] = xlsread('database_mpshocks_infoshocks.xlsx');
dateStrings = xlstext(2:end, 1);
dates = datetime(dateStrings, "InputFormat",'yyyy''m''M','Format','dd/MM/uuuu');
datesnum = Date2Num(dateStrings);
%dateCellArray = cellstr(dates);     % store dates as a 'cell' type and not a 'datetime' type, to count them later
vnames = xlstext(1, 2:end);    % Retrieve the variable names

nvar    = length(vnames);       % num of vars
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
    H(ii) = plot(DATA.(vnames{ii}),'m-', 'LineWidth',1.5);
    title(vnames(ii)); 
    DatesPlot(datesnum(1),nobs,6,'m') % Set the x-axis label dates
    grid on; 
end
% save figure manually as VECTOR IMAGE (max possible quality)
%clf('reset')




%% 3.   VAR ESTIMATION  [   USING 4. IDENTIFICATION WITH ZERO CONTEMPORANEOUS RESTRICTIONS  ]

% 3.1   VAR ESTIMATION
%************************************************************************** 
% VAR estimations is achieved in two steps: 
%       (1) define the endogenous variables, the desired number of lags, and deterministic variables; 
%       (2) run the VARmodel function.
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

% Select ENDO variables [ TO CHECK ]
Xvnames  = {'INFO_FF4','Unempl_Rate','logCPI100','interest_rate_3month','spread_10yr3month','GFC'};
Xvnames_long = {'Information shock proxy','Unemployment Rate', 'LogPrices','Policy Rate', 'Spread', 'Global Financial Cycle'};
Xnvar = length(Xvnames);

% Matrices [ TO CHECK ]
X = nan(nobs, Xnvar)
for ii = 1 : Xnvar
    X(: , ii) = DATA.(Xvnames{ii});
end

% VAR parameters
det = 1;
nlags = 3;

% Estimate VAR
[VAR, VARopt] = VARmodel(X, nlags, det);

% Update the VARopt structure (edit VARoptions to see meaning)
VARopt.vnames = Xvnames_long;   % endogenous variables names
VARopt.nsteps = 24;             % number of steps for computation of IRFs and FEVDs
VARopt.quality = 1;             % quality of exported figures: 1=high (ghostscript required), 0=low
VARopt.FigSize = [26,12];       % size of window for plots
VARopt.firstdate = datesnum(1); % initial date of the sample in format 1999.75 => 1999Q4 (both for annual and quarterly data)
VARopt.frequency = 'm';         % frequency of the data: 'm' monthly, 'q' quarterly, 'y' yearly
VARopt.figname= 'graphics/SW_'; % string for name of exported figure

VARopt.pctg      = 68;          % confidence level for bootstrap

% 3.2   IMPULSE RESPONSES
%-------------------------------------------------------------------------- 
% To get zero contemporaneous restrictions set
VARopt.ident = 'short'; % identification method for IRFs ('short' zero short-run restr [CHOLESKY], 'long' zero long-run restr, 'sign' sign restr, 'iv' external instrument)
VARopt.snames = {'\epsilon^{1}','\epsilon^{2}','\epsilon^{InfShock}'};    % shocks names
% Compute IR
[IR, VAR] = VARir(VAR,VARopt);
% Compute IR error bands
[IRinf,IRsup,IRmed,IRbar] = VARirband(VAR,VARopt);
% Plot IR
VARirplot(IRbar,VARopt,IRinf,IRsup);




%% 9. CLEAN UP

% Export tex file
% m2tex('VARToolbox_Primer.m')
% Remove VAR Toolbox from Matlab path
% rmpath(genpath('C:\Users\Jessica\Desktop\AppMacro_Project_Efrem\VAR
% toolbox CesaBianchi\VAR-Toolbox-main\v3dot0'))