%% hw7_2

clc; close all; clear;
im = imread('char.tif');

%% a : extracting the characters that contain long vertical strokes

line = strel('line',50,90);
Marker = imerode(im,line);
Long_Vert = imreconstruct(Marker,im);
subplot(121), imshow(im,[]), title('original');
subplot(122), imshow(Long_Vert,[]), title('extracted characters with long strokes');

%% b : Clean the border of the image

BorderMarker = im2bw(zeros(size(im)));
BorderMarker(:,end) = im(:,end);
BorderMarker(end,:) = im(end,:);
Border = imreconstruct(BorderMarker,im);
cleared_border = im2bw(im - Border);

figure;
subplot(131);imshow(BorderMarker,[]);title('BorderMarker');
subplot(132);imshow(Border,[]);title('Only Borders');
subplot(133);imshow(cleared_border,[]);title('Image Without Borders');

%% c : fill the holes
disk = strel('disk',1);
B = strel('square',3);
complemant_im = 1-im;
Marker = zeros(size(im));
Marker(:,end) =   1-im(:,end);
Marker(end,:) =   1-im(end,:);
Marker(1,:)   =   1-im(1,:);
Marker(:,1)   =   1-im(:,1);

holes = imreconstruct(Marker,complemant_im);
Filled_Image = 1-holes;

figure;
subplot(221);imshow(im,[]);title('Original Image');
subplot(222);imshow(complemant_im,[]);title('Complement Image');
subplot(223);imshow(Marker,[]);title('Marker Image');
subplot(224);imshow(Filled_Image,[]);title('Filled Image');
