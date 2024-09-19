%% hw8_3_a : Implement Otsu
clc; close all; clear;


im = imread('cells.tif'); 
im1=im;

hist = imhist(im)';
bar(hist)
hist = hist/numel(im);
RT1 = [130 140];
RT2 = [190 199];
Range1 = RT1(1):RT1(2);
Range2 = RT2(1):RT2(2);
MaxSigmaB = 0;

C = cell(3,1);
for T1 = Range1
    for T2 = Range2
        
        C{1} = hist(1:T1);     L1 = length(C{1});
        C{2} = hist(T1+1:T2);  L2 = length(C{2});
        C{3} = hist(T2+1:end); L3 = length(C{3});

        p1 = L1/256; p2 = L2/256; p3 = L3/256;

        indG = 1:256;
        ind1 = 1:T1;
        ind2 = T1+1:T2;
        ind3 = T2+1:256;

        m1 = cumsum((ind1-1).*C{1}); m1 = m1(end)/p1;
        m2 = cumsum((ind2-1).*C{2}); m2 = m2(end)/p2;
        m3 = cumsum((ind3-1).*C{3}); m3 = m3(end)/p3;
        mG = cumsum((indG-1).*hist); mG = mG(end);

        sigmaB = p1*(m1-mG)^2 + p2*(m2-mG)^2 + p3*(m3-mG)^2 ;

        if(sigmaB>=MaxSigmaB)
            MaxSigmaB = sigmaB;
            Th1 = T1;
            Th2 = T2;
        end
        
    end
end


im(im<Th1) = 0;
im(im>Th2) = 0;
im = im2double(im); 
im = 1- im;
figure;
subplot(121);imshow(im1,[]);title('Original');
subplot(122);imshow(im,[]);title('Segmented Area');





