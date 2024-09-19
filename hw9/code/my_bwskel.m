%% First Function - Calculating Skeleton of a Binary Image
function [iter,skeleton]  = my_bwskel(img)
imgg=img;

flag=1;
iter = 0;

%According to Reference Book:
%This basic procedure is applied iteratively 
%until no further points are deleted,the time the algorithm terminates, 
%We have The Skeleton of The Image

%%%So first We initialize while loop 
%%%and continue until bool flag toggles to zero.
while (flag)
    
    check=imgg;
    bound=bwperim(imgg,8);
    [x,y]=find(bound); 
    
    %%% Checking Algorithm On Boundary Points Obtained by bwperim;
    for i=1:length(x)
        
        %Choosing Neighborhood according to perimeter points
        
        temp=imgg((x(i)-1):(x(i)+1),(y(i)-1):(y(i)+1));
        
        p=temp(:);
        
        %Because Center Point is always zero
        N=sum(p)-1;
        
        if(N>=2 && N<=6)  %Condition(1)
            T=my_Tcalc(temp);
            if(T)  %Condition(2)
                mulOne=cast(p(4)*p(6)*p(8),'logical');
                mulTwo=cast(p(2)*p(6)*p(8),'logical');
                if(~mulOne && ~mulTwo)  %Condition(3+4)
                    imgg(x(i),y(i))=0;
                end
            end
        end
    end
    
    %Checking if Loop deleted no points :
    loopBreak  = check==imgg;
    
    %if control image equals imgg after aplying algorithm
    %it means the procedure has ended successfully!
    if(sum(loopBreak(:))==numel(imgg))
        flag=0;
    end
    iter = iter+1;
end

skeleton = imgg;
end

%% Second Function - Checking 0->1 Transition
function T = my_Tcalc(temp)

%%%Coordinate Cell Array
c = {[1 1],[1 2],[1 3],[2 3],[3 3],[3 2],[3 1],[2 1],[1 1]};
counter = 0;

for i=1:8
    
    %%%Start 
    xind = c{i}(1);
    yind = c{i}(2);
    
    %%% Next to Start
    xxind = c{i+1}(1);
    yyind = c{i+1}(2);
    
    if(temp(xind,yind) - temp(xxind,yyind)==-1)
        counter = counter + 1;
    end
    
end

if (counter==1)
    T=1;
else
    T=0;
end
    
end
