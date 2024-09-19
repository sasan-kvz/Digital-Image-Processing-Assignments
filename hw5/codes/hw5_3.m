%hw5_3
clc; clear; close all;

%% a : converting RGB to HSI & CMY
friends =im2double( imread('friends.jpg'));
r = friends(: , : ,1);
g = friends(: , : ,2);
b = friends(: , : ,3);

%%converting to hsi 

I = (r+g+b)/3;
sum = (r+g+b);
sum(sum==0) = eps;
s = 1 - (3.*(min(min(r,g),b))./sum);
%hue
at = 0.5 * ((r-g)+(r-b));
bt = sqrt((r-g).^2+(r-b).*(g-b));
theta = acos (at./(bt + eps));
h =  theta; 
h(b>g)=2*pi -h(b>g);
h = h/(2*pi);
h(s==0)=0;

hsif = zeros(360, 618,3); 
hsif(:,:,1) = h;
hsif(:,:,2) = s;
hsif(:,:,3) = I;
hsif = cat(3,h,s,I);

%%converting to cmy
c = 1-r;
m = 1-g;
y = 1-b;

cmyf = zeros(360, 618,3); 
cmyf(:,:,1) = c;
cmyf(:,:,2) = m;
cmyf(:,:,3) = y;

figure();
subplot(2,3,1),imshow(friends)         ,title('rgb'); 
subplot(2,3,2),imshow(hsif)  ,title('hsi');
subplot(2,3,3),imshow(cmyf)    ,title('cmy');
subplot(2,3,4),imshow(h)  ,title('hue');
subplot(2,3,5),imshow(s)  ,title('saturation');
subplot(2,3,6),imshow(I)  ,title('intensity');



%% b : converting RGB to HSI & CMY with built-in function

hsi = rgb2hsv(friends);
cmy = rgbtocmy(friends);
h2 = hsi(: , : ,1);
s2 = hsi(: , : ,2);
I2 = hsi(: , : ,3);

figure();
subplot(2,3,1),imshow(friends)         ,title('rgb'); 
subplot(2,3,2),imshow(hsi)  ,title('hsi2');
subplot(2,3,3),imshow(cmy)    ,title('cmy2');
subplot(2,3,4),imshow(h2)  ,title('hue2');
subplot(2,3,5),imshow(s2)  ,title('saturation2');
subplot(2,3,6),imshow(I2)  ,title('intensity2');

%%differences 
dhsi = hsif - hsi;
dcmy = cmyf - cmy;
dh = h - h2;
ds = s - s2;
dI = I - I2;

figure();
subplot(2,3,1),imshow(friends)         ,title('rgb'); 
subplot(2,3,2),imshow(dhsi,[])  ,title('hsi difference');
subplot(2,3,3),imshow(dcmy,[])    ,title('cmy difference');
subplot(2,3,4),imshow(dh,[])  ,title('hue difference');
subplot(2,3,5),imshow(ds,[])  ,title('saturation difference');
subplot(2,3,6),imshow(dI,[])  ,title('intensity difference');