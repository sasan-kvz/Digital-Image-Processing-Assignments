clc; clear;
T = imread('T.tif');

%% scaling
S = maketform('affine',[2 0 0; 0 2 0; 0 0 1]);
scaledT = imtransform (T , S );
figure;
imshow(scaledT , []); title('scaled T');
%% rotating
R = maketform('affine',[(sqrt(2))/2 (sqrt(2))/2 0; -(sqrt(2))/2 (sqrt(2))/2 0; 0 0 1]);
rotatedT = imtransform (T , R );
figure;
imshow(rotatedT, []);title('rotated T');
%% translation
TR = maketform('affine',[1 0 0; 0 1 0; 100 100 1]);
translatedT = imtransform (T , TR );
figure;
imshow(translatedT, []);title('translated T');
%% vertical shearing
shearvert = maketform('affine',[1 0 0; 0.7 1 0; 0 0 1]);
shearedvertT = imtransform (T , shearvert );
figure;
imshow(shearedvertT , []);title('vertical sheared T');
%% horizontal shearing
shearhoriz = maketform('affine',[1 1.5 0; 0 1 0; 0 0 1]);
shearedhorzT = imtransform (T , shearhoriz );
figure;
imshow(shearedhorzT , []);title('horizantal sheared T');
