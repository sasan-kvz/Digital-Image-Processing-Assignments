%hw5_4
clc; clear; close all;

%% a : segmentation friends in HSI format
friends =im2double( imread('friends.jpg'));
hsi = rgb2hsv(friends);
h = hsi(: , : ,1);
s = hsi(: , : ,2);
I = hsi(: , : ,3);

figure , imshow(h) , title('hue');
figure ,imshow(s)  , title('saturation');
figure ,imshow(I)  , title('intensity');

%25 is treshold(in uint8 class)  based on hue histogram. so 25/256 =~ 0.1in double class

mask = zeros(360,618);
mask(h<=0.1)= 1;
final_mask = cat (3,mask,mask,mask);
faces = final_mask .* friends;

figure;
subplot(2,1,1); imshow(final_mask); title('mask');
subplot(2,1,2); imshow(faces); title('faces');

%% b : segmentation godfather in HSI format

godfather =im2double( imread('godfather.png'));
hsi2 = rgb2hsv(godfather);
h2 = hsi2(: , : ,1);
s2 = hsi2(: , : ,2);
I2 = hsi2(: , : ,3);

figure , imshow(h2) , title('hue');
figure ,imshow(s2)  , title('saturation');
figure ,imshow(I2)  , title('intensity');

mask2 = zeros(600,600);
mask2(s2>0.6)= 1;
final_mask2 = cat (3,mask2,mask2,mask2);
face = final_mask2 .* godfather;

figure;
subplot(2,1,1); imshow(final_mask2); title('mask');
subplot(2,1,2); imshow(face); title('face');