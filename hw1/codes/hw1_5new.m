clc; clear;

char = imread('char.tif');
char_padded= padarray(char,[20 20],'replicate');
figure;
imshow(char_padded , []);title ('padded char');

%% 3*3 window
for i = 21:688   %% 20+1=21 , 668+20=688
    for j = 21:688
        char3(i,j) = sum(sum(char_padded(i-1:i+1,j-1:j+1)))/9; 
    end
end
figure;
imshow(char3 , []); title ('3*3 window local averaging');

%% 9*9 window
for i = 21:688   
    for j =21:688
        char9(i,j) = sum(sum(char_padded(i-4:i+4,j-4:j+4)))/81; 
    end
end
figure;
imshow(char9 , []); title ('9*9 window local averaging');

%% 17*17 window
for i = 21:688   
    for j =21:688
        char17(i,j) = sum(sum(char_padded(i-8:i+8,j-8:j+8)))/289; 
    end
end
figure;
imshow(char17 , []); title ('17*17 window local averaging');

%% 21*21 window
for i = 21:688   
    for j =21:688
        char41(i,j) = sum(sum(char_padded(i-20:i+20,j-20:j+20)))/441; 
    end
end
figure;
imshow(char41 , []); title ('41*41 window local averaging');