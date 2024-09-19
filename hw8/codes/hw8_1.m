%% hw8_1 : canny edge

clc; close all; clear;

im = imread('highway.jpg'); 
im = rgb2gray(im);
im = im2double(im);
[h, w] = size(im);
filter = [0.0174 0.348 0.04348 0.0348 0.0174; 0.0348 0.0782 0.1043 0.0782 0.0348; 0.0435 0.1043 0.1304 0.1043 0.0435;0.0348 0.0782 0.1043 0.0782 0.0348; 0.0174 0.348 0.04348 0.0348 0.0174];
Mx = [-1 0 1; -2 0 2; -1 0 1];
My = [-1 -2 -1; 0 0 0; 1 2 1];
% filtering
for v = 2 : 860
    for u = 2 : 480
        sum = 0;
        for i = -2 : 2
            for j = -2 : 2
                sum = sum + (im(u, v) * filter(i+3, j+3));
            end
        end
        Imx(u,v) = sum;
    end
end

%sobel mask x
for v = 2:859
         for u = 2:479  
             sum1 = 0;
              for i=-1:1
                for j=-1:1
                    sum1 = sum1 + Imx(u + i, v + j)* Mx(i + 2,j + 2);
                end
            end
            Imsobelx(u,v) = sum1;
         end;
end
%sobel mask y
for v = 2:859
         for u = 2:479
             sum2 = 0;
              for i=-1:1
                for j=-1:1
                 sum2 = sum2 + Imx(u + i, v + j)* My(i + 2,j + 2);
                end
            end
            Imsobely(u,v) = sum2;
         end;
end

for v = 2:859
   for u = 2:479
        mod(u,v) = abs(Imsobelx(u,v)) + abs(Imsobely(u,v));
   end
end
% non maxima supression
nmsim(u,v) = 0;
for v = 2 : 858
    for u = 2 : 478
        theta(u,v) = abs(atand(Imsobely(u,v)/Imsobelx(u,v))); 
        
        if ((theta(u,v) >= 0) && (theta(u,v) <= 22.5) || (theta(u,v) >= 157.5) && (theta(u,v) <= 180))
            ntheta(u,v) = 0;
        end;
        
        if ((theta(u,v) >= 22.5) && (theta(u,v) <= 67.5))
            ntheta(u,v) = 45;
        end;
        
        if ((theta(u,v) >= 67.5) && (theta(u,v) <= 112.5))
            ntheta(u,v) = 90;
        end;
        
        if ((theta(u,v) >= 112.5) && (theta(u,v) <= 180))
            ntheta(u,v) = 135;
        end;
                       
        if (ntheta(u,v) == 0)
                if (mod(u, v) < mod(u-1, v) || mod(u, v) < mod(u+1, v))
                    nmsim(u,v) = 0;
                else nmsim(u,v)= mod(u,v);
                end; 
            end;
                
            
            if (ntheta(u,v) == 45)
                if (mod(u, v) < mod(u+1, v-1) || mod(u, v) < mod(u-1, v+1))
                    nmsim(u,v) = 0;
                else nmsim(u,v)= mod(u,v);
                end;
            end;
                
            
            if (ntheta(u,v) == 90)
                if (mod(u, v) < mod(u, v-1) || mod(u, v) < mod(u, v+1))
                    nmsim(u,v) = 0;
                else nmsim(u,v)= mod(u,v);
                end;
            end;
               
            if (ntheta(u,v) == 135)
                if (mod(u, v) < mod(u-1, v-1) || mod(u, v) < mod(u+1, v+1))
                    nmsim(u,v) = 0;
                else nmsim(u,v) = mod(u,v);
                end ;
            end;
    end
end
%thresholding
th = 6;   %high threshhold
tl = 0.6; %low hreshhold
alpha(u,v) = 0;
beta(u,v) = 0;
for v = 2 : 858
    for u = 2 : 478
        if(nmsim(u,v) >= th)
            alpha(u,v) = nmsim(u,v);
        end
        if(nmsim(u,v) >= tl)
            beta(u,v) = nmsim(u,v);
        end
     
    end
    
end

edgeimg = beta - alpha; 

subplot (121),imshow(im);axis image; title('Original Image');
subplot (122),imshow(edgeimg);axis image; title('Canny Edge');
figure;
subplot (221),imshow(Imx);axis image; title('Filtered Image');
subplot (222),imshow(Imsobelx);axis image; title('X- Direction sobel');
subplot (223),imshow(Imsobely);axis image; title('Y- Direction sobel');
subplot (224),imshow(nmsim);axis image; title('NonMaxima Suppression');
