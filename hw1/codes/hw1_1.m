clc; clear;
%% a
dip = imread ('DIP.jpg');
%% b
figure;
imshow(dip , [])
%% c
gdip = rgb2gray(dip);
figure;
imshow(gdip , []); title('gray');
%% d
dgdip = im2double(gdip);
%% e
imwrite(dgdip,'dgdip','tif');
%% f
gdip2 = imresize(gdip ,2);
figure;
imshow(gdip2, []);title('double');
gdip_half = imresize(gdip ,1/2);
figure;
imshow(gdip_half, []);title('half');
gdip_quarter = imresize(gdip ,1/4);
figure;
imshow(gdip_quarter, []);title('quarter');


