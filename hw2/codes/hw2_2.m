%hw2_2
clc; clear; close all;

%% a histogram

squares = imread('squares.tif');
bands = imread('bands.png'); 
bands = bands(:,:,1);
sf = imread('sf.gif');
%histogram of images
sf_hist =  zeros(1,256);   
for i=0:255
        sf_hist(i+1) = length(find(sf==i));
end
bands_hist =  zeros(1,256);   
for i=0:255
        bands_hist(i+1) = length(find(bands==i));
end
squares_hist =  zeros(1,256);   
for i=0:255
        squares_hist(i+1) = length(find(squares==i));
end
%show original images and their histograms
figure;
subplot(2,3,1); imshow(sf, []); title('sf');
subplot(2,3,2); imshow(bands, []); title('bands');
subplot(2,3,3); imshow(squares, []); title('squares');
subplot(2,3,4); bar(sf_hist); title('sf hist');
subplot(2,3,5); bar(bands_hist); title('bands hist');
subplot(2,3,6); bar(squares_hist); title('squares hist');

%% b histogram equlization

%sf equlization
sf_transform = zeros(256,1);
sf_transform(1) = sf_hist(1);
for i=1:255
    sf_transform(i+1) = sf_transform(i)+ sf_hist(i+1);
end
[asf,bsf] = size(sf); %% size of sf
sf_transform=floor((255/(asf*bsf))*sf_transform);

equalized_sf =zeros(256,256); %%building final eqaulized histogram image
for i=1:256
      for  j=1:256
        equalized_sf(i,j) =  sf_transform(sf(i,j)+1);
      end
end
equalized_sf = uint8(equalized_sf);        

%bands equlization
bands_transform = zeros(256,1);
bands_transform(1) = bands_hist(1);
for i=1:255
    bands_transform(i+1) = bands_transform(i)+ bands_hist(i+1);
end

[abands,bbands] = size(bands); %% size of bands
bands_transform=floor((255/(abands*bbands))*bands_transform);

equalbands =zeros(500,500); %%building final eqaulized histogram image
for i=1:500
      for  j=1:500
        equalbands(i,j) =  bands_transform(bands(i,j)+1);
      end
end
equalbands = uint8(equalbands);        

%squares equlization
squares_transform = zeros(256,1);
squares_transform(1) = squares_hist(1);
for i=1:255
    squares_transform(i+1) = (squares_transform(i)+ squares_hist(i+1));
end
[asquares,bsquares] = size(squares); %% size of squares
squares_transform=floor((255/(asquares*bsquares))*squares_transform);
equalsquares =zeros(512,512); %%building final eqaulized histogram image
for i=1:512
      for  j=1:512
        equalsquares(i,j) =  squares_transform(squares(i,j)+1);
      end
end
equalsquares = uint8(equalsquares);

%new histograms
sf_hist_new =  zeros(1,256);   
for i=0:255
        sf_hist_new(i+1) = length(find(equalized_sf==i));
end

squares_hist_new =  zeros(1,256);   
for i=0:255
        squares_hist_new(i+1) = length(find(equalsquares==i));
end

bands_hist_new =  zeros(1,256);   
for i=0:255
        bands_hist_new(i+1) = length(find(equalbands==i));
end

figure;
subplot(2,3,1); imshow(equalized_sf); title('equal sf');
subplot(2,3,2); imshow(equalbands); title('equal bands');
subplot(2,3,3); imshow(equalsquares); title('equal squares');
subplot(2,3,4); bar(sf_hist_new); title('equal sf hist');
subplot(2,3,5); bar(bands_hist_new); title('equal bands hist');
subplot(2,3,6); bar(squares_hist_new); title('equal squares hist');

%% c local adaptive histogram equalization 

squares = imread('squares.tif');
squares_padded= padarray(squares,[3 3],'replicate');

% 3*3 window, cause when I tried to wrtie my histogram as function it
% didn't work, I used imhist in this section. 

%%3*3 mask adaptive equalization
adaptive3_equalized_squares = zeros(516,516);
for i = 4:3:517   
    for j = 4:3:517
                squares_window = squares_padded(i-1:i+1 , j-1:j+1);
                sq_window_hist = imhist(squares_window);
                sq_window_transform = zeros(256,1);
                sq_window_transform(1) = sq_window_hist(1);
                for k=1:255
                   sq_window_transform(k+1) = sq_window_transform(k)+ sq_window_hist(k+1);
                end
                sq_window_transform=round((255/9)*sq_window_transform );
                equalized_sq_window =zeros(3,3);
                for a=1:3
                    for  b=1:3
                        equalized_sq_window(a,b) =  sq_window_transform(squares_window(a,b)+1);
                    end
                end
                equalized_sq_window= uint8(equalized_sq_window);        
                adaptive3_equalized_squares(i-3:i-1, j-3:j-1) = equalized_sq_window;

    end
end

%%5*5 mask adaptive equalization
adaptive5_equalized_squares = zeros(515,515);
for i = 4:5:514 
    for j = 4:5:514
                squares_window = squares_padded(i-2:i+2 , j-2:j+2);
                sq_window_hist = imhist(squares_window);
                sq_window_transform = zeros(256,1);
                sq_window_transform(1) = sq_window_hist(1);
                for k=1:255
                   sq_window_transform(k+1) = sq_window_transform(k)+ sq_window_hist(k+1);
                end
                sq_window_transform=round((255/25)*sq_window_transform);
                equalized_sq_window =zeros(5,5);
                for a=1:5
                    for  b=1:5
                        equalized_sq_window(a,b) =  sq_window_transform(squares_window(a,b)+1);
                    end
                end
                equalized_sq_window= uint8(equalized_sq_window);        
                adaptive5_equalized_squares(i-3:i+1, j-3:j+1) = equalized_sq_window;

    end
end

%%7*7 mask adaptive equalization

adaptive7_equalized_squares = zeros(518,518);
for i = 4:7:515
    for j = 4:7:515
                squares_window = squares_padded(i-3:i+3 , j-3:j+3);
                sq_window_hist = imhist(squares_window);
                sq_window_transform = zeros(256,1);
                sq_window_transform(1) = sq_window_hist(1);
                for k=1:255
                   sq_window_transform(k+1) = sq_window_transform(k)+ sq_window_hist(k+1);
                end
                sq_window_transform=round((255/49)*sq_window_transform);
                equalized_sq_window =zeros(7,7);
                for a=1:7
                    for  b=1:7
                        equalized_sq_window(a,b) =  sq_window_transform(squares_window(a,b)+1);
                    end
                end
                equalized_sq_window= uint8(equalized_sq_window);        
                adaptive7_equalized_squares(i-3:i+3, j-3:j+3) = equalized_sq_window;

    end
end

figure;
 subplot(2,2,1); imshow(equalsquares); title('equalized squares');
 subplot(2,2,2); imshow(adaptive3_equalized_squares, []); title('3*3 adaptive equalized squares');
 subplot(2,2,3); imshow(adaptive5_equalized_squares, []); title('5*5 adaptive equalized squares');
 subplot(2,2,4); imshow(adaptive7_equalized_squares, []); title('7*7 adaptive equalized squares');
 