%%hw 10_1_b :  Bayes classifier
clear ;clc; close all;

%%class1 
X11 =  normrnd(1,0.4,[1 50]);
X21 =  normrnd(1,0.4,[1 50]);
x1 = [X11;X21];
%%class(2)
X12 =  normrnd(0,0.2,[1 50]);
X22 =  normrnd(0,0.2,[1 50]);
x2 = [X12;X22];
x = [x1,x2];
%% mean and Covariance Matrix of The Classes
M1 = [mean(X11);mean(X21)];
M2 = [mean(X12);mean(X22)];
x10 = [(X11-mean(X11)) ; (X21-mean(X21))];
x20 = [(X12-mean(X12)) ; (X22-mean(X22))];
Cx1 = (1/49) * x10 * x10';
Cx2 = (1/49) * x20 * x20';

%% Classifying Using Bayes Classifier
Tbayes = zeros(1,100);

for i=1:100
    temp = x(:,i);
 
    k1 = 1/(2*pi*sqrt(det(Cx1)));
    z1 = k1*exp(-0.5*(temp-M1)'*(Cx1\(temp-M1)));
    k2 = 1/(2*pi*sqrt(det(Cx2)));
    z2 = k2*exp(-0.5*(temp-M2)'*(Cx2\(temp-M2)));

    if (z1>z2)
        Tbayes(i)=1;
    else
        Tbayes(i)=0;
    end
end

%% classes result
bIndex1 = find(Tbayes);
bIndex0 = find(~Tbayes);

bClass1 = x(:,bIndex1);
bClass0 = x(:,bIndex0);

%%Decision Boundary
syms y1 y2;
y = [y1;y2];
det1 = det(Cx1);
det0 = det(Cx2);
f1 =  -0.5*log(det1) - 0.5 * transpose(y-M1) * (Cx1\(y-M1));
f0 =  -0.5*log(det0) - 0.5 * transpose(y-M2) * (Cx2\(y-M2));
bBoundary = f1 - f0;
figure;
scatter(X11,X21,'b','filled');hold on
scatter(X12,X22,'r','filled');hold on
ezplot(bBoundary,[-2,2]); grid on 
