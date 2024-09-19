function imgOut = my_fdescriptor ( bound,nd )


%%%% Fourier Transform Of Coordinates
sb = length(bound);

if(~mod(sb,2))
    bound(end+1,:) = bound(end,:);
    sb = sb+1;
end

x = 0:sb-1;
   
m = (-1).^ x ; m = m' ;

bound(:,1) = m.*bound(:,1);
bound(:,2) = m.*bound(:,2);

bound = bound(:,1) + 1j*bound(:,2);

z = fft(bound);

%%%%%%%%%%%%%%%%%%%%%%%%%%
sz = length(z);

x = 0:sz-1;
m = (-1).^x; m = m' ;

%%%Shifting The Frequrncies
d = (sz-nd)/2;
z(1:d)=0;
z(sz-d+1:sz)=0;

zz = ifft(z);

s(:,1) = real(zz);
s(:,2) = imag(zz);

s(:,1) = m.*s(:,1);
s(:,2) = m.*s(:,2);


x=round(s(:,1)); 
y=round(s(:,2));

x=x-min(x)+1;
y=y-min(y)+1;

%%%Initializing Logical 0 Matrix
imgOut=false(max(x), max(y));

%%%Final Modified Boundary Using Fourier Descriptor
imgOut(sub2ind(size(imgOut),x,y)) = true;
end






















