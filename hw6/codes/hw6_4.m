%hw6_3
clc; clear; close all;

%% a 
im = imread('mountain.tif');
symbols = [0:255];
[m , n] = size (im);
f = zeros(1,256);
for i=0:255
        f(i+1) = length(find(im==i));
end
prob = f./(m*n);
bar(symbols, prob); xlabel('Gray Level'); ylabel('Probability');

%% b Huffman code Dictionary

[dict, avglen] = huffmandict(symbols,prob);
disp(['Average Length is : ' num2str(avglen)])

%% c : entropy 

prob=prob(prob>0);
entropy = - sum (prob .* log2(prob));
disp(['Entropy of original image : ' num2str(entropy)]);


