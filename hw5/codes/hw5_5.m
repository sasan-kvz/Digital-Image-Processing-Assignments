%hw5_5
clc; clear; close all;

%% a : segmentation friends in HSI format
godfather =im2double( imread('godfather.png'));
r = godfather(:,:,1);
g = godfather(:,:,2);
b = godfather(:,:,3);

window = godfather(100:360,200:400,:);
figure; imshow(window); title ('window for finding color');
redw = window(:,:,1);
greenw = window(:,:,2);
bluew = window(:,:,3);

mr = mean(redw(:));
mg = mean(greenw(:));
mb = mean(bluew(:));

%%sphere
index = sqrt((r-mr).^2 +  (g-mg).^2  + (b-mb).^2)< 0.4;
sphere_segmented = zeros(size(godfather));
sphere_segmented(index) = godfather(index);
figure; subplot(3,1,1); imshow(sphere_segmented); title('sphere segmentation window'); 

%%cube 

sumr= abs(r(:)-mr);
sumg= abs(g(:)-mg);
sumb= abs(b(:)-mb);

index2 = sumr +sumb + sumg <0.4;
cube_segmented = zeros(size(godfather));
cube_segmented(index2) = godfather(index2);
subplot(3,1,2); imshow(cube_segmented); title('cube segmentation window'); 

%%elliptical
index3 = sqrt(0.75*((r-mr).^2) +  1.15*((g-mg).^2)  + 1.15*((b-mb).^2))< 0.4;
elliptic_segmented = zeros(size(godfather));
elliptic_segmented(index3) = godfather(index3);
subplot(3,1,3); imshow(elliptic_segmented); title('elliptic segmentation window'); 


