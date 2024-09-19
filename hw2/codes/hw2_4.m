%%hw2_4
clc; clear; close all;

%% a
bone = imread('bone-scan.tif');
bone = im2double(bone);
%%size image
[m,n] = size(bone);
bone_padded= padarray(bone,[4 4],'symmetric');
for i = 1+4:m 
    for j =1+4:n
        bone3(i,j) = sum(sum(bone_padded(i-1:i+1,j-1:j+1)))/9; 
    end
end

for i = 1+4:m
    for j =1+4:n
        bone5(i,j) = sum(sum(bone_padded(i-2:i+2,j-2:j+2)))/25; 
    end
end

for i = 1+4:m 
    for j =1+4:n
        bone9(i,j) = sum(sum(bone_padded(i-4:i+4,j-4:j+4)))/81; 
    end
end
figure;
subplot(1,3,1), imshow(bone3 ),title('blured by 3*3 mask');
subplot(1,3,2), imshow(bone5 ),title('blured by 5*5 mask');
subplot(1,3,3), imshow(bone9 ),title('blured by 9*9 mask');

%% b : unsharp masking
unsharp_bone = bone + (bone - bone9);
unsharp_bone2 = bone + 1.5*(bone - bone9);
unsharp_bone3 = bone + 2*(bone - bone9);
unsharp_bone4 = bone + 3*(bone - bone9);
unsharp_bone5 = bone + 5*(bone - bone9);
unsharp_bone6 = bone + 10*(bone - bone9);

figure;
subplot(2,3,1), imshow(unsharp_bone ),title('unsharped bone w=1');
subplot(2,3,2), imshow(unsharp_bone2 ),title('unsharped bone w=1.5');
subplot(2,3,3), imshow(unsharp_bone3 ),title('unsharped bone w=2');
subplot(2,3,4), imshow(unsharp_bone4 ),title('unsharped bone w=3');
subplot(2,3,5), imshow(unsharp_bone5 ),title('unsharped bone w=5');
subplot(2,3,6), imshow(unsharp_bone6 ),title('unsharped bone w=10');