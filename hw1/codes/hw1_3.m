clc; clear;
skull = imread('skull.tif');
subplot(1,5,1),imshow(skull)  ,title('Original'); 

%% 64 Intensity levels
skull64 = uint8(floor(double(skull)/4)*4); 	
subplot(1,5,2),imshow(skull64),title('64 Intensity levels');  

%% 16 Intensity levels
skull16 = uint8(floor(double(skull)/16)*16); 	
subplot(1,5,3),imshow(skull16),title('16 Intensity levels');  

%% 4 Intensity levels
skull4 = uint8(floor(double(skull)/64)*64); 
subplot(1,5,4),imshow(skull4),title('4 Intensity levels');  

%% 2 Intensity levels
skull2 = uint8(floor(double(skull)/128)*128); 
subplot(1,5,5),imshow(skull2),title('2 Intensity levels');  