%%hw 10_1_a : minimum distance classifier
clear ;clc; close all;


%%class1 
X11 =  normrnd(1,0.4,[1 50]);
X21 =  normrnd(1,0.4,[1 50]);

%%class(2)
X12 =  normrnd(0,0.2,[1 50]);
X22 =  normrnd(0,0.2,[1 50]);

%% Minimum Distance Classifier
M1 = [mean(X11);mean(X21)];
M2 = [mean(X12);mean(X22)];
syms x1 x2;
x = [x1;x2];

%%Decision Boundary By:
d1 = x' * M1 - 0.5 * (M1' * M1);
d2 = x' * M2 - 0.5 * (M2' * M2);
dBoundary = d1- d2;

figure;
scatter(X11,X21,'b','filled');hold on
scatter(X12,X22,'r','filled');hold on
ezplot(dBoundary,[-2,2]); grid on 

