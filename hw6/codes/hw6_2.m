%hw6_2
clc; clear; close all;

p = im2double(imread('parrots_noisy.tif'));

%% a : de-noising image by Haar-based DWT

[approximation,dcH,dcV,dcD] = dwt2(p,'haar');

%%horizontal threshold = 0.123  , vertical threshold = 0.118 and, diagonal threshold = 0.107
dcH(abs(dcH)<0.131) = 0;
dcV(abs(dcV)<0.142) = 0;
dcD(abs(dcD)<0.108) = 0;

denoised_haar_p = idwt2(approximation ,dcH,dcV,dcD, 'haar');

figure;
subplot(131); imshow(p); title('Original Image');
subplot(132); imshow(denoised_haar_p); title('Denoised Using Haar Wavelet');
subplot(133); imshow( p - denoised_haar_p); title('removed noise');

%% b : de-noising image by db5 & sym20 DWT

%%db5
[approximation2,dcH2,dcV2,dcD2] = dwt2(p,'db5');

dcH2(abs(dcH2)<0.131) = 0;
dcV2(abs(dcV2)<0.142) = 0;
dcD2(abs(dcD2)<0.108) = 0;
denoised_db5_p = idwt2(approximation2 ,dcH2,dcV2,dcD2, 'db5');

figure;
subplot(131); imshow(p); title('Original Image');
subplot(132); imshow(denoised_db5_p); title('Denoised Using db5 Wavelet');
subplot(133); imshow( p - denoised_db5_p ); title('removed noise');

%%sym20
[approximation3,dcH3,dcV3,dcD3] = dwt2(p,'sym20');

dcH3(abs(dcH3)<0.131) = 0;
dcV3(abs(dcV3)<0.142) = 0;
dcD3(abs(dcD3)<0.108) = 0;

denoised_sym20_p = idwt2(approximation3 ,dcH3,dcV3,dcD3, 'sym20');

figure;
subplot(131); imshow(p); title('Original Image');
subplot(132); imshow(denoised_sym20_p); title('Denoised Using sym20 Wavelet');
subplot(133); imshow( p - denoised_sym20_p ); title('removed noise');
% 
%% c : denoising with DFT

pFFT = fft2(p);
H = (1/16)*[1 2 1;2 4 2;1 2 1];
filterFFT = fft2(H,512,768);
inFFT_filtered = pFFT.*filterFFT;
denoised_dft_p = ifft2(inFFT_filtered);
figure;
subplot(131); imshow(p); title('Original Image');
subplot(132),imshow(denoised_dft_p),title('Denoised using DFT');
subplot(133),imshow(p-denoised_dft_p),title('removed noise');

%% d : waveletAnalyzer
waveletAnalyzer



