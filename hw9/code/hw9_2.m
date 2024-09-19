%%hw 9_2
clear ;clc; close all;


im = imread('river.tif');
im = im2bw(255-im);

[iter,skeleton] = my_bwskel(im);

imshow(skeleton,[]);title('Skeleton');

