%hw2_1
clc; clear; close all;

%% a log transformation
spine = imread('spine.tif');
spined = im2double(spine);
logspined1 = log(spined+1);
logspined2 = 2*log(spined+1);
logspined5 = 5*log(spined+1);
%%plot
figure;
subplot(2,4,1),imshow(spined)         ,title('Original'); 
subplot(2,4,2),imshow(logspined1)  ,title('c = 1');
subplot(2,4,3),imshow(logspined2)    ,title('c = 2');
subplot(2,4,4),imshow(logspined5)    ,title('c = 5');                     
subplot(2,4,5),imhist(spine)         ,title('hist original');
subplot(2,4,6),imhist(logspined1)  ,title('hist 1*log');
subplot(2,4,7),imhist(logspined2)    ,title('hist 2*log');
subplot(2,4,8),imhist(logspined5)    ,title('hist 5*log');
 
%% b implementing the given tranformation

pout = imread('pout.tif'); 
poutnew = uint8(zeros(256,256));
for i=1:256
    for j=1:256 
        if (pout(i,j)<= 80)
            poutnew(i,j)= pout(i,j)*0.5;
        end
        if (80<pout(i,j)<= 160)
            poutnew(i,j)= pout(i,j)*2.13 - 130;
        end
        if (160<pout(i,j))
            poutnew(i,j)= pout(i,j)*0.47 + 134.21;
        end
    end
end

figure; 
subplot(1,2 ,1),imshow(pout, []) ,title('pout'); 
subplot(1,2 ,2),imshow(poutnew,[]) ,title('pout new'); 
%% c image seprating plates and reconstructing
dollar = imread('dollar.tif');
dollar1 =  bitget (dollar, 1); %% because the output of bitget is 1 or 0 and both of them are black IIt's better to enhance 
dollar2 =  bitget (dollar, 2);
dollar3 =  bitget (dollar, 3);
dollar4 =  bitget (dollar, 4);
dollar5 =  bitget (dollar, 5);
dollar6 =  bitget (dollar, 6);
dollar7 =  bitget (dollar, 7);
dollar8 =  bitget (dollar, 8);
figure; 
subplot(3 , 3 ,1) , imshow(dollar, []) , title ('original dollar');
subplot(3 , 3 ,2) , imshow(dollar1, []) , title ('LSB bit');
subplot(3 , 3 ,3) , imshow(dollar2, []) , title ('2nd bit');
subplot(3 , 3 ,4) , imshow(dollar3, []) , title ('3rd bit');
subplot(3 , 3 ,5) , imshow(dollar4, []) , title ('4th bit');
subplot(3 , 3 ,6) , imshow(dollar5, []) , title ('5th bit');
subplot(3 , 3 ,7) , imshow(dollar6, []) , title ('6th bit');
subplot(3 , 3 ,8) , imshow(dollar7, []) , title ('7th bit');
subplot(3 , 3 ,9) , imshow(dollar8, []) , title ('MSB bit');
%%reconstructing the image by 4 of the most sigificant bits 
newdollar =uint8 (240);
newdollar = bitset(newdollar,8,dollar8);
newdollar = bitset(newdollar,7,dollar7);
newdollar = bitset(newdollar,6,dollar6);
newdollar = bitset(newdollar,5,dollar5);
difdollar = dollar - newdollar;

figure;
subplot(1,3,1); imshow(newdollar); title ('reconstructed dollar');
subplot(1,3,2); imshow(dollar); title ('original dollar');
subplot(1,3,3); imshow(difdollar, []); title ('difference');