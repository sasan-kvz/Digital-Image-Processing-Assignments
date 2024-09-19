%hw5_1
clc; clear; close all;

%% a : R channel = 0

G = zeros(250 , 250);
g = linspace (0,1,250);
for i = 1:250
    G(i , :) = g;
end

B = zeros(250 , 250);
b = linspace (1,0,250);
for i = 1:250
    B(:,i) = b;
end

R = zeros(250,250);

color = zeros(250,250,3);
color(:,:,1) = R;
color(:,:,2) = G;
color(:,:,3) = B;

subplot(1,4,1),imshow(R)         ,title('red '); 
subplot(1,4,2),imshow(G)  ,title('green');
subplot(1,4,3),imshow(B)    ,title('blue');
subplot(1,4,4),imshow(color)    ,title('color'); 


%% b : R channel = 0.5 & 1

R1 = 0.5 * ones(250,250);
color1 = zeros(250,250,3);
color1(:,:,1) = R1;
color1(:,:,2) = G;
color1(:,:,3) = B;

R2 = ones(250,250);
color2 = zeros(250,250,3);
color2(:,:,1) = R2;
color2(:,:,2) = G;
color2(:,:,3) = B;

figure();
subplot(2,3,1),imshow(R1)         ,title('red= 0.5 '); 
subplot(2,3,2),imshow(R2)         ,title('red= 1 '); 
subplot(2,3,3),imshow(G)  ,title('green');
subplot(2,3,6),imshow(B)    ,title('blue');
subplot(2,3,4),imshow(color1)    ,title('color r=0.5'); 
subplot(2,3,5),imshow(color2)    ,title('color r=1'); 


