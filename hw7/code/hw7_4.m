%% hw7_4

clc; close all; clear;

%% a : extracting the characters that contain long vertical strokes

im = imread('rice.tif'); 
disk1 = strel('disk',40);
corrected_im = imtophat(im,disk1);

gray_level = graythresh(corrected_im);
bw_im = im2bw(corrected_im,gray_level);

subplot(131) , imshow(im,[]) ,title('Original');
subplot(132), imshow(corrected_im,[]) ,title('Shadig effect Corrected');
subplot(133), imshow(bw_im,[]), title('Binary');

%%histogram of the areas
CC = bwconncomp(bw_im,4);
num = CC.NumObjects
s  = regionprops(bw_im, 'area');
for i=1:82
    areas(i,1) = s(i).Area;
end
areas = sort(areas);

figure; histogram(areas,50) ,title('Histogtram Of Areas');

%% b: dominant particles

im1 = imread('wood_dowels.tif');
%img1 = im2double(img1);
disk2 = strel('disk',3);
opened_im = imopen(im1,disk2);
filtered_im = imclose(opened_im,disk2);

figure , subplot(121) , imshow(im1,[]) ,title('Original');
subplot(122), imshow(filtered_im,[]), title('Filtered Image');

area = zeros(1,50);
for i=1:50
    diskx = strel('disk',i);
    img_opened = imopen(filtered_im,diskx);
    area(1,i) = sum(img_opened(:));
end

figure ,plot(diff(area)), title('Granulometry Plot');

%% c:  boundary between these two regions


im2 = imread('blobs.tif');
im2 = im2double(im2);
disk4 = strel('disk',30);
closed_im2 = imclose(im2,disk4);
disk5 = strel('disk',60);
opened_im2 = imopen(closed_im2,disk5);
square = strel('square',5);
dilated_im2 = imdilate(opened_im2,square);
erosed_im2 = imerode(opened_im2,square);
boundary_line = dilated_im2 - erosed_im2;
boundry = im2 + boundary_line;

figure;
subplot(221) ,imshow(im2) ,title('Original')
subplot(222) ,imshow(closed_im2) , title('Bigger Circles')
subplot(223) , imshow(opened_im2) , title('boundary shape')
subplot(224) , imshow(boundary_line) , title('Boundary line')
figure , imshow(boundry) ,title('segmented image')