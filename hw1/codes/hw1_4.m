clc; clear;

%% hw1_4a
angio_live = imread('angiography_live.tif');
angio_mask = imread('angiography_mask.tif');
blood_vessel_structure = angio_live - angio_mask;
figure;
imshow(blood_vessel_structure , []);
max_range = max (max (blood_vessel_structure));
blood_vessel_structure_inhanced = blood_vessel_structure * 10; title('blood vessel structure');
figure;
imshow(blood_vessel_structure_inhanced , []); title('blood vessel structure inhanced');

%% hw1_4b
filament_shaded = im2double (imread('filament_shaded.tif'));
sensor_shading = im2double ( imread('sensor_shading.tif'));
filament_corrected = filament_shaded ./ sensor_shading;
figure;
subplot(1,2,1),imshow(filament_shaded),title('shaded filament');
subplot(1,2,2),imshow(filament_corrected),title('corrected filament');
