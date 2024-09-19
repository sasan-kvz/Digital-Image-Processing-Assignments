%%hw 9_1
clear ;clc; close all;

im = imread('mapleleaf.tif');

%% a  :  Finding Image Boundary
[m,n] = size(im);

%%%Initializing Boundary Image
Boundry = zeros(m,n);

%%% Index of rows and cols with 1s.
[row,~] = find(im);


%%%xb0 has the minimum height
%%%yb0 has the minimum witdth in minimum-height pixels
xb0 = min(row);
yb0 = find(im(xb0,:)==1,1);

%%%Set First Point in Boundary Image
Boundry(xb0,yb0) = 1;

%%%Offset Matrix - Clockwise Direction
offset = [0 -1;-1 -1 ;-1 0;-1 1;0 1;1 1;1 0;1 -1;0 -1];

%%%Saving The First Boundary Point
xsave = xb0;
ysave = yb0;

%%%Starting Point c0 which is West Point!
sx = xb0 + offset(1,1);
sy = yb0 + offset(1,2);  

%%%Loop Flag
flag = 1;
ctr = 1;

while(flag)
    
    %%%Checking If the Next Point is Boundary Point Or not
    for i=1:8
        if(sx==xb0+offset(i,1) && sy==yb0+offset(i,2))
            sx = xb0 + offset(i+1,1);
            sy = yb0 + offset(i+1,2);
            break;
        end
    end
    
    %%%if this below condition satisfy, we conclude that
    %%%[xb0,yb0] is actually the coordinate of the point exactly
    %%%before boundary point in clockwise direction!
    
    if (im(sx , sy) == 1)
        Boundry(sx , sy) = 1;
        
        indx(ctr)=sx;
        indy(ctr)=sy;
        
        %%%We should assign b = nk and c = nk-1 , So:
        %%%We have These Swaps:
        swap1 = xb0 ;
        xb0 = sx;
        sx = swap1 ;
        
        swap2 = yb0 ;
        yb0 = sy;
        sy = swap2;   

        %%%Termination Condition of Algorithm
        if (xb0 == xsave && yb0 == ysave)
            flag=0;
        end
        ctr = ctr+1;
    end
    
end
indx = indx';
indy = indy';


figure;
subplot(121);imshow(im,[]);title('Original');
subplot(122);imshow(Boundry,[]);title('Boundary Of Image');

%% b : chain code

cLength = length(indx); %%%Chain Length
chainDir =[0 1;-1 1;-1 0; -1 -1; 0 -1;1 -1; 1 0; 1 1]; %%%Chain Direction
code = zeros(cLength-1,1);


for i=1:cLength-1
    rx = indx(i+1)-indx(i);
    ry = indy(i+1)-indy(i);
    
    for j=1:length(chainDir)
        if( rx==chainDir(j,1)&& ry==chainDir(j,2) )
            code(i)=j-1;
        end
    end
    
end

%% c : Fourier Descriptor

indexBound = [indx,indy];
nPoint = [1000 100  50  10 ];
imgCell = cell(length(nPoint),1);

for i=1:length(nPoint)
   s = my_fdescriptor (indexBound,nPoint(i));
   imgCell{i}=s;
end

figure;
subplot(221);imshow(imgCell{1},[]);title(['Image with ',num2str(nPoint(1)),' Descriptors']);
subplot(222);imshow(imgCell{2},[]);title(['Image with ',num2str(nPoint(2)),' Descriptors']);
subplot(223);imshow(imgCell{3},[]);title(['Image with ',num2str(nPoint(3)),' Descriptors']);
subplot(224);imshow(imgCell{4},[]);title(['Image with ',num2str(nPoint(4)),' Descriptors']);

%% d :  minimum required descriptors

nPoint2 = [50 40  30  20 ];
imgCell2 = cell(length(nPoint2),1);

for i=1:length(nPoint2)
   s = my_fdescriptor (indexBound,nPoint2(i));
   imgCell2{i}=s;
end

figure;
subplot(221);imshow(imgCell2{1},[]);title(['Image with ',num2str(nPoint2(1)),' Descriptors']);
subplot(222);imshow(imgCell2{2},[]);title(['Image with ',num2str(nPoint2(2)),' Descriptors']);
subplot(223);imshow(imgCell2{3},[]);title(['Image with ',num2str(nPoint2(3)),' Descriptors']);
subplot(224);imshow(imgCell2{4},[]);title(['Image with ',num2str(nPoint2(4)),' Descriptors']);
