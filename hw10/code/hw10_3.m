%%hw 10_3 
clear ;clc; close all;

%% Q3
clc
clear
close all
fruit = [1 0 -0.5;0.85 0 0.4;1 1 0.1;1 1 1];
findex = [-1 -1 1;-1 1 1]; %% [-1,-1] for apple [-1,1] for banana [1,1] for kiwi

%% first layer
k1 = ones(4,1);
param = 1;
while param==1
    b = 0;
    for i=1:3
        if findex(1,i)==1 && k1'*fruit(:,i) <= 0
                k1 = k1 + fruit(:,i);
                b = b+1;
        elseif findex(1,i)==-1 && k1'*fruit(:,i) >= 0
                k1 = k1 - fruit(:,i);
                b = b+1;
        end
    end
    if b==0
        param = 0;
        break
    end
end

%% second layer
k2 = ones(4,1);
param = 1;
while param
    b = 0;
    for i=1:3
        if findex(2,i)==1 && k2'*fruit(:,i) <= 0
                k2 = k2 + fruit(:,i);
                b = b+1;
                
        elseif findex(2,i)==-1 && k2'*fruit(:,i) >= 0
                k2 = k2 - fruit(:,i);
                b = b+1;
        end
    end
    if b==0
        param = 0;
        break
    end
end
k = [k1';k2'];

%% test and result
friut_test = [-0.3 0.5 0.2 1; 0.15 0.1 0.9 1]';
a1 = hardlims(k*friut_test(:,1));
a2 = hardlims(k*friut_test(:,2));

if a1 == [-1;-1]
    disp('First fruit is apple')
elseif a1 == [-1;1]
    disp('First fruit is banana')
elseif a1 == [1;1]
    disp('First fruit is Kiwi')
end

if a2 == [-1;-1]
    disp('Second fruit is apple')
elseif a2 == [-1;1]
    disp('Second fruit is banana')
else a1 == [1;1]
    disp('Second fruit is Kiwi')
end