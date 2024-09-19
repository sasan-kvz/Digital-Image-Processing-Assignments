% hw7_1

clc; close all; clear;
im = imread('star.tif');

%% a : dilation
%%3*3
dilated3= zeros(52,52);
for i=2:50;
    for j=2:50;
        if (im(i,j) == 1)   
            dilated3(i-1:i+1,j-1:j+1) =1;
        end
    end
end
%%5*5
dilated5= zeros(54,54);
for i=3:50;
    for j=3:50;   
        if (im(i,j) == 1)   
            dilated5(i-2:i+2,j-2:j+2) =1;
        end
    end
end

subplot(131) , imshow(im), title('original');
subplot(132) , imshow(dilated3), title('dilated by 3*3');
subplot(133) , imshow(dilated5), title('dilated by 5*5');

%% b erosion 
%%3*3
m3 = ones(3,3);
erosed3 = zeros(50,50);
for i=2:49;
    for j=2:49;   
        if (m3 == im(i-1:i+1,j-1:j+1))   
            erosed3(i,j) =1;
        end
    end
end

%%5*5
m5=ones(5,5);
erosed5 = zeros(50,50);
for i=3:48;
    for j=3:48;   
        if (m5 == im(i-2:i+2,j-2:j+2) )   
            erosed5(i,j) =1;
        end
    end
end

figure;
subplot(131) , imshow(im), title('original');
subplot(132) , imshow(erosed3), title('erosed by 3*3');
subplot(133) , imshow(erosed5), title('erosed by 5*5');

%% c : opening
%%3*3
opened3 = zeros(52,52);
for i=2:50;
    for j=2:50;
        if (erosed3(i,j) == 1)   
            opened3(i-1:i+1,j-1:j+1) =1;
        end
    end
end

%%5*5
opened5 = zeros(54,54);
for i=3:50;
    for j=3:50;
        if (erosed5(i,j) == 1)   
            opened5(i-2:i+2,j-2:j+2) =1;
        end
    end
end

figure;
subplot(131) , imshow(im), title('original');
subplot(132) , imshow(opened3), title('opened by 3*3');
subplot(133) , imshow(opened5), title('opened by 5*5');

%% d : closing
%%3*3
closed3 = zeros(52,52);
for i=2:49;
    for j=2:49;   
        if (m3 == dilated3(i-1:i+1,j-1:j+1))   
            closed3(i,j) =1;
        end
    end
end


%%5*5
closed5 = zeros(54,54);
for i=3:49;
    for j=3:49;   
        if (m5 == dilated5(i-2:i+2,j-2:j+2))   
            closed5(i,j) =1;
        end
    end
end

figure;
subplot(131) , imshow(im), title('original');
subplot(132) , imshow(closed3), title('closed by 3*3');
subplot(133) , imshow(closed5), title('closed by 5*5');










