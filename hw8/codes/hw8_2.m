%% hw8_2 :Implement Hough Line Transform

clc; close all; clear;

im = imread('highway.jpg'); 
im = rgb2gray(im);
[m,n] = size(im);
D = sqrt(m^2 + n^2); %% maximum distance in image

bw = edge(im,'canny'); %% edges of image
theta = (-90:89)/180 * pi;
rho = (-D:1:D) ; 

H = zeros(length(rho),length(theta));

for x = 1:n
    for y = 1:m
        
        if(bw(y,x))
            for iT=1:length(theta)
                t = theta(iT);
                rhonew = x*cos(t) + y*sin(t);
                [~,iR] = min(abs(rhonew-rho));
                H(iR,iT) =  H(iR,iT) +1;
            end
        end
    end
end

figure;
subplot(311);imshow(im);title('Original');
subplot(312);imshow(bw);title('Canny Edge');
subplot(313);pcolor(theta,rho,H);shading flat; colormap('gray'); title('Hough Transform ');xlabel('Theta(radiant)');ylabel('Rho');

%% less lines 
bw2 = edge(im,'canny' ,0.5,5); %% edges of image
H2 = zeros(length(rho),length(theta));

for x = 1:n
    for y = 1:m
        
        if(bw2(y,x))
            for iT=1:length(theta)
                t2 = theta(iT);
                rhonew2 = x*cos(t2) + y*sin(t2);
                [~,iR2] = min(abs(rhonew2-rho));
                H2(iR2,iT) =  H2(iR2,iT) +1;
            end
        end
    end
end

figure;
subplot(311);imshow(im);title('Original');
subplot(312);imshow(bw2);title('Canny Edge new');
subplot(313);pcolor(theta,rho,H2);shading flat; colormap('gray');title('Hough Transform new ');xlabel('Theta(radiant)');ylabel('Rho');
