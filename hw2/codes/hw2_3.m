%hw2_3
clc; clear; close all;

%% a
sf = imread('sf.gif');
[m,n]= size(sf);
mean = (sum(sum(sf)))/(m*n);
sd = sqrt(sum(sum((sf-mean).^2))/(m*n));

meandiff =20; sdnew =11; %new supposed sd = 11 and new supposed mean = 75
sfnew = (sd/sdnew)*sf + (sdnew/sd)* meandiff;
sdnewcheck= sqrt(sum(sum((sfnew -mean).^2))/(m*n));
meannewcheck = (sum(sum(sfnew)))/(m*n);

figure;
subplot(1,2,1) ,  imshow(sf) , title('original');
subplot(1,2,2) ,  imshow(sfnew) , title('streched');

%% b
xray = imread('x-ray.png');
xray = xray(: , : ,1);
minxray = min(min(xray));
maxxray = max(max(xray));

%%min-max xray streched: xray1 
%When (r1, s1) = (rmin, 0) and (r2, s2) = (rmax, L-1), this is known as Min-Max Stretching.
xray1 = 1.19 * (xray - 41.06);
minxray1 = min(min(xray1));
maxxray1 = max(max(xray1));

%%min-max xray streched: xray2
%When (r1, s1) = (rmin + c, 0) and (r2, s2) = (rmax – c, L-1), this is known as Percentile Stretching.
%c=5
xray2=xray;
xray2(xray<46)=46;
xray2(xray>250)=250;
xray2 = 1.25 *( xray - 46);
minxray2 = min(min(xray2));
maxxray2 = max(max(xray2));

figure;
subplot(1,3,1) ,  imshow(xray) , title('original xray');
subplot(1,3,2) ,  imshow(xray1) , title('min max streched');
subplot(1,3,3) ,  imshow(xray2) , title('percentile streched');
