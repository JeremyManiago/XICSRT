clear 
clc
close all

pointxS = 0;
pointx2 = 1;

pointyS = 2;
pointy2 = 3;

set(0,'DefaultFigureWindowStyle','docked')
figure;
grid on
hold on

plot([pointxS,pointx2],[pointyS,pointy2],'r',LineStyle="--")
axis equal

x = [pointxS pointx2] ; 
y = [pointyS pointy2] ; 
p = polyfit(x,y,1) ; 
xi = linspace(x(1),x(2)) ;
yi = polyval(p,xi) ;
comet(xi,yi)
plot(x,y,'*r',xi,yi,'b')