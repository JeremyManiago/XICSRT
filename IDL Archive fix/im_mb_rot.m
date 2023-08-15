function [angles] = im_mb_rot(xpin,ypin,revers,thetas)
format long

% Take source, crystal, detector positions from image_mb and rotate 
% to configuration required for xicsrt.

conv = pi()/180.0d0;

lrevers = strcmpi(revers, 'Y');


xp = xpin(1,1:4);
yp = ypin(1,1:4);
xC3 = xpin(1,5);
yC3 = ypin(1,5);

disp(" ")
disp("xp, yp")
disp(xp)
disp(yp)
disp(" ")

np = numel(xp);

if strcmpi(revers, 'Y')

    % =============================
    % Shift origin to lower point
    xp1a = [xp,0.0d0,xC3] - xp(1,4);
    yp1a = [yp,0.0d0,yC3] - yp(1,4);
    yr = [min(yp1a), max(yp1a)];

    disp(" ")
    disp("xp1a, yp1a")
    disp(xp1a)
    disp(yp1a)
    disp(" ")

    xp1 = xp1a(1,1:5);
    yp1 = yp1a(1,1:5);

    set(0,'DefaultFigureWindowStyle','normal')
    figure;
    grid on
    hold on
    % title('Case 1', 'FontSize', 14);
    % xlabel('Time(s)', 'FontSize', 14);
    % ylabel('Position (mm)', 'FontSize', 14);
    
    plot(xp1(1,1:np),yp1(1,1:np))
    axis equal
    xx = xp1a(1,np+1);
    yy = yp1a(1,np+1);
    plot([xx,xx],[yy,yy],Marker="diamond")

    % ===============================================================
    % Determine angle to rotate from MB coordinates to NP coordinates
    ro = -atan( (yp1(1,3) - yp1(1,4)) / (xp1(1,3) - xp1(1,4)) );
    rotang = ro/conv;
    disp(" ")
    disp("rotation angle =" + rotang)
    disp(" ")
    xp2a = xp1a*cos(ro) - yp1a*sin(ro);
    yp2a = xp1a*sin(ro) + yp1a*cos(ro);

    xp2 = xp2a(1,1:5);
    yp2 = yp2a(1,1:5);

    disp(" ")
    disp("xp2, yp2")
    disp(xp2)
    disp(yp2)
    disp(" ")

    figure;
    grid on
    hold on
    plot(xp2(1:np),yp2(1:np),LineWidth=2)
    xx = xp2(1,np+1);
    yy = yp2(1,np+1);
    plot([xx,xx],[yy,yy],Marker="diamond")
    axis equal

    x2s = flip(xp2);
    y2s = flip(yp2);

    xc3s = [xp2(1,4),xp2a(1,6),xp2a(1,1)];
    yc3s = [yp2(1,4),yp2a(1,6),yp2a(1,1)];
    plot(xc3s,yc3s,'magenta',LineStyle='--')

    x3s = xc3s;
    y3s = yc3s;

    ac3_1 = 90.0d0 - thetas(1,3);
    ac3_2 = atan( (y2s(1,4) - y3s(1,2)) / (x2s(1,4) - x2s(1,2)) );

end

% =====================================
% Forward, from top to bottom

if strcmpi(revers, 'Y')

  xp1 = [xp,0.0d0];
  yp1 = yp(1,1) - [yp,0.0d0];

  figure;
  grid on
  hold on
  plot(xp1,yp1)

  ro1 = atan(xp1(1,2)/yp1(1,2));
  rot1 = ro1/conv;
  xp2 = xp1*cos(ro1) - yp1*sin(ro1);
  yp2 = xp1*sin(ro1) + yp1*cos(ro1);
  x2s = yp2;
  y2s = xp2;
    
  figure;
  grid on
  hold on
  plot(x2s,y2s,LineWidth=2)

end

% disp("reversed xp = " + xp2)
% disp("reversed yp = " + yp2)

% Exchange x and y

% xs = [yp2,0.0d0]  % Append center of spheres, which is [0,0]
% ys = [xp2,0.0d0]

% =============================================
% First shift to bottom point as origin for revers = 'Y'

% x1s = xs

% if strcmpi(revers, 'Y') 
%   x1s = -x1s
% end

% y1s = ys
% ro1 = -atan(y1s(1,2)/x1s(1,2))
% rot1 = ro1/conv

center = [x2s(1,5),y2s(1,5)];

if strcmpi(revers, 'Y')
    center = [x2s(1,1),y2s(1,1)];
end

% ==============================================
% Plot normals to crystals

xx = [center(1,1),x2s(1,3)];
yy = [center(1,2),y2s(1,3)];
plot(xx,yy,'b',LineStyle='--',LineWidth=2)

ic1 = 1;
if lrevers
    ic1 = 3;
end

xx1 = [center(1,1),x2s(ic1+1)];
yy1 = [center(1,2),y2s(ic1+1)];
plot(xx1,yy1,'b',LineStyle='--',LineWidth=2)


% Normals to crystals and detector
if strcmpi(revers, 'Y')

  a1 = atan((y2s(1,1)-y2s(1,3)/(x2s(1,3)-x2s(1,1))));
  a2 = atan((y2s(1,4)-y2s(1,1))/(x2s(1,4)-x2s(1,1)));
  a3 = atan((y2s(1,5)-y2s(1,4))/(x2s(1,4)-x2s(1,5)));
  angs = [a1,a2,a3,ac3_1*conv,ac3_2];

else

  a1 = atan((y2s(1,5)-y2s(1,2)/(x2s(1,2)-x2s(1,5))));
  a2 = atan((y2s(1,3)-y2s(1,5))/(x2s(1,3)-x2s(1,5)));
  a3 = atan((y2s(1,3)-y2s(1,4))/(x2s(1,3)-x2s(1,4)));
  angs = [a1,a2,a3];
  angs = abs(angs);

end

angles = angs/conv;

disp("Angles = " + angles)

cosa = cos(angs);
sina = sin(angs);

% In IDL, array indexing is done by [column, row]. To convert to MATLAB
% indexing, just switch the numbers (and add 1 due to different indexing).
% e.g. norms[*,0] in IDL is equivalent to norms(0,:) in matlab

norms = zeros(np+2,2);

if lrevers

    norms(1,:) = [0.0d0,1.0d0];
    norms(2,:) = [sina(1,1),-cosa(1,1)];
    norms(3,:) = [sina(1,2),cosa(1,2)];
    norms(4,:) = [-sina(1,3),cosa(1,3)];
    norms(5,:) = [sina(1,4),-cosa(1,4)];
    norms(6,:) = [-sina(1,5),-cosa(1,5)];

else

    norms(1,:) = [0.0d0,1.0d0];
    norms(2,:) = [sina(1,1),-cosa(1,1)];
    norms(3,:) = [-sina(1,2),-cosa(1,2)];
    norms(4,:) = [sina(1,3),cosa(1,3)];

end



pos = zeros(np+2,2);

if lrevers

    pos(1,:) = [0.0d0,0.0d0];
    pos(2,:) = [y2s(1,3),x2s(1,3)];
    pos(3,:) = [y2s(1,4),x2s(1,4)];
    pos(4,:) = [y2s(1,5),x2s(1,5)];
    pos(5,:) = [y3s(1,2),x3s(1,2)];
    pos(6,:) = [y3s(1,3),x3s(1,3)];

else

    pos(1,:) = [0.0d0,0.0d0];
    pos(2,:) = [y2s(1,2),x2s(1,2)];
    pos(3,:) = [y2s(1,3),x2s(1,3)];
    pos(4,:) = [y2s(1,4),x2s(1,4)];

end


pos = pos/1.0d3;


disp(" ")
disp("pos[y,z]/norm,[y,z]")
disp(" ")

for i = 1 : np

    disp(" ")
    disp(pos(i,1) + ", " + pos(i,2))
    disp(norms(i,1) + ", " + norms(i,2))
    disp(" ")

end

disp(" ")
disp("Coordinate & norms for C3")
disp(" ")

for i = 5:6

    disp(" ")
    disp(pos(i,1) + ", " + pos(i,2))
    disp(norms(i,1) + ", " + norms(i,2))
    disp(" ")

end


% Check lengths & angles
% 
% for i = 1:np-1
% 
%     ip = i + 1
%     
% 
% end

disp(" ")
disp(" ")
disp("x positions")
disp(" ")
disp(x2s/1000.0d0)
disp(" ")
disp("y positions")
disp(y2s/1000.0d0)
disp(" ")
disp("angles = " + angles)
disp(" ")
disp("cosines = " + cosa)
disp(" ")
disp("sines = " + sina)
disp(" ")
disp(" ")



end