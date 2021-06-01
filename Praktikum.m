clear all
close all
clc

obstacles(1,:)=[4,5];
obstacles(2,:)=[4,1];
obstacles(3,:)=[4,2];
obstacles(4,:)=[4,3];
obstacles(5,:)=[4,4];

startingPosition=[0,5];
goal=[5,5];
 
obstacleColor=[1,0,0]; %red
nodeColor=[0,1,0]; %green
expandColor=[0,0,0]; %black
goalColor=[0,0,1]; %blue
pathColor=[0,1,1]; %cyan

scatter(obstacles(:,1),obstacles(:,2),100,obstacleColor,'filled');
grid;
axis([0 5 0 5]);
hold on;

scatter(goal(1,1),goal(1,2),100,goalColor,'filled');
fringeCount=1;
tempCount=1;

fringe(fringeCount,:)=[startingPosition,fringeCount];
while (~((fringe(fringeCount,1)==goal(1,1)) && (fringe(fringeCount,2)==goal(1,2))))
scatter(fringe(fringeCount,1),fringe(fringeCount,2),100,nodeColor,'filled');
    for x=-1:1
        for y=-1:1
            if (x*y==0)
                failsTest=0;
tempNode=[fringe(fringeCount,1)+x,fringe(fringeCount,2)+y, fringeCount];
            if( (tempNode(1,1)<0) || (tempNode(1,2)<0) || (tempNode(1,1)>5) || (tempNode(1,2)>5))
                failsTest=failsTest+1;
            end

            if(failsTest<1)
                for i=1:size(fringe,1)
                    if(tempNode(1,1)==fringe(i,1)) && (tempNode(1,2)==fringe(i,2)) 
                        failsTest=failsTest+1;
                    end
                end
            end
            
            if(failsTest<1)
                for i=1:size(obstacles,1)
                    if(tempNode(1,1)==obstacles(i,1))&&(tempNode(1,2)==obstacles(i,2))
                        failsTest=failsTest+1;
                    end
                end
            end
            
            if(failsTest<1) 
                fringe(fringeCount+tempCount,:)=tempNode;
                scatter(tempNode(1,1),tempNode(1,2),100,expandColor,'filled');
                tempCount=tempCount+1;
            end
            end
        end
    end
   
 fringeCount = fringeCount + 1;tempCount=tempCount-1;pause(.1);
end
i=1;

while~(fringeCount==1) 
    path(i,:)=[fringe(fringeCount,1),fringe(fringeCount,2)];
    fringeCount=fringe(fringeCount,3);i=i+1;
end

path(i,:)=startingPosition;

plot(path(:,1),path(:,2));scatter(path(:,1),path(:,2),100,pathColor,'filled')