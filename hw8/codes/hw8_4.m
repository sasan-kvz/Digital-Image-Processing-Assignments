%% hw8_3_b : otsu vs. n local thresholding using moving averages

clc; close all; clear;

%% a: background subtraction

vid = VideoReader('road.AVI');

Nframe = get(vid,'NumberOfFrames');
m = vid.Height;
n  = vid.Width;

Frame = zeros(m,n,Nframe);
backG = zeros(m,n);

for i=1:Nframe
    Frame(:,:,i) = rgb2gray(im2double(read(vid,i)));
    backG = backG + Frame(:,:,i)/Nframe;
end


imshow(backG,[]);title('BackGround Image');

%% b : Detect moving objects 

random_frame = [ 30 60 90 120 150 170]; %%Different random Frames for Detect Moving Objects

thresh = 0.1;
ctr = 1;
figure;
for j=1:length(random_frame)
    
    i = random_frame(j);
    movement = Frame(:,:,i) - backG;
    movement(abs(movement)<thresh) = 0;
    
    subplot(2,3,j);imshow(movement,[]);
    title(['Moving Objects in Frame ',num2str(i)]);
    
end
