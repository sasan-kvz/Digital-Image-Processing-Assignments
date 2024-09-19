%%hw 9_3
clear ;clc; close all;


im = imread('shape.png');
im  = im2double(im);
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
[m,n] = size(r);

gr_im = rgb2gray(im);
imbw = im2bw(gr_im , 0.05);

imgCell = cell(1,6);
index   = cell(1,6);

Conn = bwconncomp(imbw);
for i=1:Conn.NumObjects
    im = zeros(m,n);
    index{i} = Conn.PixelIdxList{i};
    im(index{i}) = gr_im(index{i});
    im = cast(im,'logical');
    imgCell{i} = im;
    rr = zeros(m,n);
    gg = zeros(m,n);
    bb = zeros(m,n);
    rr(index{i}) = r(index{i}); 
    gg(index{i}) = g(index{i});
    bb(index{i}) = b(index{i});
    imgTemp = cat(3,rr,gg,bb);
    subplot(2,3,i);imshow(imgTemp,[]);title(['Shape ',num2str(i)]);
end


s  = regionprops(imbw,'centroid');
m  = struct2array(s);
m = reshape(m,2,6)';


imgName = {'Rectangle','Star','Pentagon','Triangle','Circle','Hexagon'};

figure; 
for i=1:6
   
    B = bwboundaries(imgCell{i},8);
    y = B{1}(:,1); y(end)= [];
    x = B{1}(:,2); x(end)= [];
    dist = sqrt( (x-m(i,1)).^2 +  (y-m(i,2)).^2 );
    
    subplot(2,3,i);
    plot(dist(1:end-50));
    title(imgName{i});
    grid on;
end
