hw6_3
clc; clear; close all;

p = im2double(imread('parrots_noisy.tif'));

%% invisible 
[m,n,k] = size(p); 
image2 = zeros(m,n,k,class(p)); 
image2(:,:) = reshape(idct(dct(p(:,:))),m,n);
subplot(131), imshow(p, []) , title('Original Image')
subplot(132) ,imshow(image2, []), title('Image2')
subplot(133),imshow(image2 - p, []), title('difference')

%% visible

watermark = imread('w.jpg');
modified = im2double(imresize(watermark,[512,768],'bilinear'));
modified = modified(:,:,1);
alpha = 0.8;
watermarked_image =  p  + (1-alpha)*modified;

figure
subplot(131), imshow(p, []) , title('Original Image')
subplot(132) ,imshow(watermarked_image, []), title('watermarked image')
subplot(133),imshow(watermarked_image - p, []), title('difference')
