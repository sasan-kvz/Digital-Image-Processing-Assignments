%hw5_2
clc; clear; close all;

fruits = im2double(imread('D:\master\4\0digital image processing\hw\HW5\images/fruits.png'));
r = fruits(: , : ,1);
g = fruits(: , : ,2);
b = fruits(: , : ,3);
subplot(1,4,1),imshow(fruits)         ,title('fruits'); 
subplot(1,4,2),imshow(r)  ,title('red');
subplot(1,4,3),imshow(g)    ,title('green');
subplot(1,4,4),imshow(b)    ,title('blue'); 

%% component Blue
b_artifact = (b>0.8);
k = find(b_artifact);
b(k) = b(k+1);
b_artifact =b_artifact';
k = find(b_artifact);
c = b';
c(k) = c(k+1);
b_denoised = cat(3,r,g,c');

%% component Green
[k,l] = size(g);
N = 510/5;       
[x,y] = meshgrid(1:l,1:k);
T =  0.05 + 0.35* cos(2*pi/N* y);
imgg = g.*T;
gg = g-imgg;
G_denoised = cat(3,r,gg,b);

%% component red

r_fft = fft2(r);
[m,n]= size(r);
filter = ones(m,n);
for ii = 1:m
    for jj = 1:n
        if m - ii == 4*jj  || m - ii == 4*jj+1  || m - ii == 4*jj-1 ||m - ii == 4*jj+2  ||m - ii == 4*jj-2  
            filter(ii,jj)=0;
        end
        if  ii == 4*(n-jj) || ii == 4*(n-jj)-1 || ii == 4*(n-jj)+1 || ii == 4*(n-jj)+2 || ii == 4*(n-jj)-2 
            filter(ii,jj)=0;
        end
    end
end

r_denois=real(ifft2(r_fft.*filter));
r_denoised = cat(3,r_denois,g,b);

fnew = cat(3,r_denois,gg,c');
figure;
subplot(221),imshow(b_denoised) ,title('Without Blue Line');
subplot(222), imshow(r_denoised) , title('red denoised');
subplot(223), imshow(G_denoised) , title('Decreasing Green Wave');
subplot(224), imshow(fnew) , title('new image');



