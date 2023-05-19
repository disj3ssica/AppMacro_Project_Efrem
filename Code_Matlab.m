% clear environment
clc, clearvars

% HELP COMMAND
    %help("min")    % opens in software documentation
    %doc min        % opens online documentation


%       MATRICES AND VECTORS

x = 1:10;       %gen horizontal array
                % use x' to have vertical array

x = linspace(20,50);        % gen 100 evenly spaced values
x = linspace(20,50, 300);   % third argument to choose how many values to gen

y = [12, 50, -8, -100]; % to gen array manually

A = [1, 3 ; 2, -10 ; 88, 99];   % gen 3x2 matrix
B = ones(3);                    % gen a 3x3 matrix of 1s
C = zeros(3);                   % gen 3x3 matrix of 0s
D = eye(3);                     % gen a 3x3 diagonal matrix 

E = 1:2:10; % gen a vector of values from 1, jump every 2 values, stop at 10

clearvars, clc
% use indexes to retrieve values from matrices
A = [5 3 4.2; 8 9 0];
A(1,3);     % is value of position 1,3 in A
A(end);     %gives last value in A
A(end-2);   %gives last-2 value in A
A(1,1)=100; %change specific value in A
A(2,:);     %gives entire 2nd row

% SOLVING FUNCTION
clearvars, clc
% exercise: maximise function y=-(x-3)^2+10 in range 0<x<5
x = linspace(0,5);
% y = -(x-3)^2 % gives ERROR because x is an ARRAY, so think in matrix
y = -(x-3).^2 +10;
%plot
%plot(x,y, '*'); % gives plot 

max(y); %finds max of function y
min(y); %finds min of function y

[MaxVal, I] = max(y);   % I is index, gives that the n-th value of y is the maximum we get
x(60);                  % gives MaxVal

% moving away from linspace
% CUSTOM FUNCTION
clearvars, clc

x = linspace(0,5);          % keep in mind x is an array, so x(position) gives the component of matrix
y = @(x) (-(x-3).^2 +10);   % @(x) defines the anonymous function
y(20.7)                     % gives the specific value of y(x) 


% Example problem
clc, clearvars, close all

% plot these functions
x = linspace(-10,10);
y1 = (-(x-3).^2 +10);
y2 = (-(x-3).^2 +15);
y3 = (-(x-5).^2 +10);
% matlab sees these as figures 
    figure(1)   % name it for the program
    plot(x, y3, 'ms', 'MarkerFaceColor','m', 'MarkerSize', 10) % plots just 1 line, magenta and squares for the line
    hold on     % keeps the previous line in the next plot
    plot(x,y1, 'bv') 
    plot(x,y2, 'g+')
    %settings:
    xlabel('x'), ylabel('y'), title('Y v. X from problem exercise')
    grid on
    
    legend ('Y3', 'Y1', 'Y2')   % adds legend, order sensitive wrt to order creation of plot lines above
    % xlim([0,2]) % sets x axis from 0 to 2

% to generate 3 side by side graphs
figure(1)   % name the overall figure
subplot(1,3,1)   % subplot in a 1x3 form, position 1
plot(x, y3, 'ms', 'MarkerFaceColor','m', 'MarkerSize', 10)
xlabel('x'), ylabel('y'), title('Y v. X from problem exercise')
grid on

subplot(1,3,2)
plot(x,y1, 'bv')
xlabel('x'), ylabel('y'), title('Y v. X from problem exercise')
grid on

subplot(1,3,3)
plot(x,y2, 'g+')
xlabel('x'), ylabel('y'), title('Y v. X from problem exercise')
grid on
