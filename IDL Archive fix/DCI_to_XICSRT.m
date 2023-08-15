clear
clc
close all
format long

%% Info from image1_run
% =======================================================================
%{
image1_run.pro
Runs image1_sub 

"image1_v2.pro" evaluates two versions of our 'Two-Crystal Imaging System' - see ref. [1]. Each of
these two versions consists of a low-resolution HOPG crystal and a high-resolution Si crystal.

from /u/bitter/image1.pro  3-22-2023

The parameters for these two versions are given in the MsWord-file, entitled: 
"Cu-Ka1-line for test of imaging system_LG-3" and are copied below:

Parameters
==========
E-CuKalpha1 = 8.04778 keV, wl =1.54060 A 

Version_1:
========== 
Concave Si-533 crystal_2, 2d=1.65635 Å, R2=823 mm, size: 25 mm x 75mm
Bragg angle theta2 = 68.4531 deg, R2cos(theta2)=302.2572 mm

Convex HOPG crystal_1, 2d=6.7080 Å, R1=310.5586 mm, 
Bragg angle theta1 = 13.2774 deg, R1cos(theta1)=302.2572 mm

Version_2:
========== 
Concave HOPG crystal, 2d=6.7080 Å, R2 = 910.1991 mm
Bragg angle theta2  = 66.7317 deg. R2cos(theta2)=359.5626 mm

Convex Si-422, 2d=2.21707, R1=500 mm, size: 15 mm x 45mm 
Bragg angle theta1 = 44.0177 deg, R1cos(theta1)=359.5626mm

ref[1]: 'A new scheme for stigmatic x-ray imaging with large magnification'
M. Bitter, K. W. Hill, et al., Rev. Sci. Instrum. 83, 10E527 (2012),
%}

%% Variables/Inputs
% =======================================================================
conv1 = 12.398419737e0;                       % NIST (National Institute of Standards and Technology)
conv2 = pi()/180.0e0;                         % radians to degrees

% E = 8.04778e0;                              % Energy in keV of Cu_k_alpha_1 line
E = 8.3976e0;                                  % Tungsten-Lalpha1; W_L_alpha_1
% lam = 1.5;
% E = conv1/lam;                              % For 1.5 angstrom wavelength

% thetas = ([30,60]);
% thets = thetas.*conv2;
% twods = lam./sin(thets);

order = 4;
% twods = double([2.7496365, 1.6564458]);     % Quartz-203, Silicon-533, M~2
% twods = double([2.2172048,6.7080/order]);	  % Si-422, 4th order graphite, M=20
% twods = double([6.7080, 1.65635]);		  % C002, Si-533
% twods = double([2.21707, 1.65635]);         % Si-422, Si-533, M~21
twods = double([2.21707, 1.65635]);         % Si-422, Si-533, M~2.53, alpha = -10deg (W_L_alpha_1)
% twods = double([6.7080, 1.65635]);          % HOPG, Si-533, M~4.5 for alpha = 68deg
% twods = double([2.21707, 6.7080/order]);    % Si-422, HOPG, M~20
% twods = double([2.749, 1.65635]);           % aslpha-Quartz-2023, Si-533, M~1.96

R2 = 823.0e0;                               % Silicon-533 (concave)
% R2 = 910.1991e0;                            % HOPG (concave)
% R2 = 450.0e0;                               % Silicon-533 (concave, with quartz as convex)

alpha = -10e0;                                % angle of a rotation of the ray pattern about an axis through the common center, M
% alpha = 30e0;


%% Program starts here
% =======================================================================
d2s = twods;                % 2d (crystal spacing)
lam = conv1/E;              % lambda (wavelength)
thets = asin(lam./d2s);     % Bragg angles in radians
thetas = thets./conv2;      % Bragg angles in degrees


Mag = -cos( 2.0*thets(1,2) - (alpha*conv2) ) / cos( 2.0*thets(1,1) + (alpha*conv2));   % Magnification : distance from source to detector divided by distance from source to crystal

disp(" ")
disp(" ")
disp(" ")
disp("thetas = " + thetas)
disp(" ")
disp("Magnification factor for concave-convex = " + Mag)
disp(" ")
disp(" ")
disp("________________________")

ralph = [cosd(alpha) -sind(alpha); sind(alpha) cosd(alpha)];

%% Concave Si-533 Crystal_C2
% =======================================================================
theta2 = thetas(1,2);
thet2 = theta2*conv2;
RT = R2*cos(thet2);		% RT=radius of tangency circle
xC2 = R2*sin(thet2);	% x-coordinate for center of concave crystal_C2
yC2 = RT;				% y-coordinate for center of concave crystal_C2


findgen75 = vpa( int64(0):int64(74) );      % makes a 75 element array from 1 to 75
findgen401 = vpa( int64(0):int64(400) );    % makes a 201 element array from 1 to 401

ph20 = (90.0e0 - theta2)*conv2;		              % polar angle for central point on crystal_C2
ph2 = (-37.0e0/R2) + (findgen75/R2) + ph20;       % polar angles for 75 points in 1mm-steps along crystal_C2 surface
ph22 = (-200.0e0/R2) + (findgen401/R2) + ph20;    % polar angles for 200 points in 1mm-steps of crystal_C2 sphere

%{
Cartesian coordinates (x22,y22) for 200 points of the crystal_C2 sphere
and (x2,y2) for 75 points along the Si-533 crystal_C2 surface.
The origin of the Cartesian system is at the center of tangency circle!
%}
x22 = R2*cos(ph22);
y22 = R2*sin(ph22);

x2 = R2*cos(ph2);			
y2 = R2*sin(ph2);


%% Convex Si-422 Crystal_C1
% =======================================================================
theta1 = thetas(1,1);
thet1 = theta1*conv2;
R1 = RT/cos(thet1);
xC1 = R1*sin(thet1);	% Cartesian coordinates for center of crystal_C1
yC1 = RT;

ph10 = atan(yC1/xC1);		                    % polar angle for center of crystal_C1
ph1 = (-37.0/R1) + (findgen75/R1) + ph10;       % polar angles for 75 points in 1mm-steps along crystal_C1 surface
ph11 = (-200.0/R1) + (findgen401/R1) + ph10;    % polar angles for 200 points in 1mm-steps of crystal_C1 sphere

% Cartesian coordinates (x11,y11) for 200 points of the crystal_C1 sphere
% and (x1,y1) for 75 points along the HOPG crystal_C1 surface.
% ======================================================================
x11 = R1*cos(ph11);
y11 = R1*sin(ph11);

x1 = R1*cos(ph1);			
y1 = R1*sin(ph1);

%%
% Cartesian coordinates for points on tangency circle
% ===================================================
findgen2001 = vpa( int64(0):int64(2000) );
xt = -RT + findgen2001*RT/1000;
yt = sqrt(RT.^2-xt.^2);

% Cartesian coordinates for the Point-Source S
% ============================================
xS = 0.0;
yS = RT - R2*sin(thet2)*tan(2*ph20);

RS = yS;

phS = atan(yS/xS);		                       % polar angle for center of crystal_C1
phSS = (-37.0/RS) + (findgen75/RS) + phS;      % polar angles for 75 points in 1mm-steps along crystal_C1 surface
phSSS = (-200.0/RS) + (findgen401/RS) + phS;   % polar angles for 200 points in 1mm-steps of crystal_C1 sphere

% Cartesian coordinates (xSSS,ySSS) for 200 points of source
% and (xSS,ySS) for 75 points along the source surface.
% ======================================================================
xSSS = RS*cos(phSSS);
ySSS = -RS*sin(phSSS);

xSS = RS*cos(phSS);			
ySS = -RS*sin(phSS);


% Cartesian coordinates for the image point I of the Point-Source S
% =================================================================

xI = 0.0;
yI = RT + R1*sin(thet1)*tan(2*thet1);

RI = yI; % radius of image


findgenMag = vpa( int64(0):int64(74*round(Mag)) );                      % makes element array based on magnification
findgenMagBig = vpa( int64(0):int64(200*round(Mag)) );                  % makes element array based on magnification

phIm = atan(yI/xI);		                                                % polar angle for center of image (detector)
phImm = (-(size(findgenMag,2)/2)/RI) + (findgenMag/RI) + phIm;          % polar angles for 75 points in 1mm-steps along crystal_C1 surface
phImmm = (-(size(findgenMagBig,2)/2)/RI) + (findgenMagBig/RI) + phIm;   % polar angles for 200 points in 1mm-steps of crystal_C1 sphere

% Cartesian coordinates (xSSS,ySSS) for 200 points of image
% and (xSS,ySS) for 75 points along the image surface.
% ======================================================================
xImmm = RI*cos(phImmm);
yImmm = RI*sin(phImmm);

xImm = RI*cos(phImm);			
yImm = RI*sin(phImm);


% Output

disp(" ")
disp(" ")
disp(" ")
disp("Parameters: ")
disp("========================")
disp("Cu_k_alpha line")
disp("E(keV) = " + E)
disp(" ")
disp("Concave Si-533 Crystal_2")
disp("R2 = " + R2)
disp(" ")
disp("Convex Si-422 Crystal_1")
disp("R1 = " + R1)
disp(" ")
disp("Radius of Tangency Circle")
disp("RT = " + RT)
disp(" ")
disp(" ")
disp("________________________")

%% Plotting
% =======================================================================
set(0,'DefaultFigureWindowStyle','normal')
figure;
grid on
hold on
title("Magnification = " + Mag, 'FontSize', 14);
xlabel('x (mm)', 'FontSize', 14);
ylabel('y (mm)', 'FontSize', 14);

% plot tangency circle
plot(xt,yt,'b')
plot(xt,-yt,'b')
axis equal
% axis([-2000 2000 -inf inf])

% plot 200 points of crystal_C2 sphere and 75 points along crystal_C2 surface
% p(1) = plot(x22,y22,Color='#006400',Marker='.');
p(2) = plot(x2,y2,'g',Marker='.');
p(3) = plot([xC2,xC2],[yC2,yC2],'r',Marker='.');

% plot central point on Crystal_C2 and its real image of on tangency circle
% p(4) = plot([xC2,xC2],[yC2,yC2],'r',Marker='*');    % center of crystal_C2
% p(5) = plot([0,0],[RT,RT],'r',Marker='*');          % image of center of crystal_C2

% plot center point of crystal_C1, point source S and its image I
% p(6) = plot([xC1,xC1],[yC1,yC1],'r',Marker='*');
% p(7) = plot([xS,xS],[yS,yS],'r',Marker='*');
% p(8) = plot([xI,xI],[yI,yI],'r',Marker='*');

% plot(xSSS,ySSS)
p(9) = plot(xSS,ySS,'r',Marker='.');

% plot(xImmm,yImmm)
p(10) = plot(xImm,yImm,'blue',Marker='.');

% plot, 200 points of crystal_C1 sphere and 75 points along crystal_C surface
% p(11) = plot(x11,y11,Color='#006400',Marker='.');
p(12) = plot(x1,y1,'g',Marker='.');
% p(13) = plot([xC1,xC1],[yC1,yC1],'r',Marker='.');

% plot reflected ray from center of Crystal_C2 to its real image on tangency circle
% p(14) = plot([0,xC2],[RT,RT],'r',LineStyle="--");

% plot incident ray on center of Crystal_C2
p(15) = plot([xS,xC2],[yS,yC2],'r',LineStyle="-");
% animate(xS,xC2, yS,yC2)

% plot reflected ray from crystal_C2 to crystal_C1
p(16) = plot([xC2,xC1],[yC2,yC1],'r',LineStyle="-");
% animate(xC2,xC1, yC2,yC1)

% plot reflected ray from crystal_C1 to image point I
p(17) = plot([xC1,xI],[yC1,yI],'r',LineStyle="-");
% animate(xC1,xI, yC1,yI)

plot([xI, xS],[yI, yS], 'k', LineStyle='--')
p(18) = plot([0 xS],[0 yS],'k', LineStyle='--');
% rotate(p,[0 0 1], alpha, [0 0 0])

% length of incident ray from source S to crystal_C2 in presentstandard configuration
p2 = -R2*sin(thet2)/cos(2*thet2);

% length of reflected ray from crystal_C2 to image IC2 in present standard configuration	
q2 = R2*sin(thet2);		



%% PART II: Choosing a new Arrangement by Rotaion of the Axis of Symmetry 
% ======================================================================
%{
disp("Choose new Arrangement by rotating the Axis of Symmetry: lun=1 for yes, lun=0 for no")
lun=1
lun = input("Enter lun = ")
if (lun eq 0) then goto,lbl17

disp("Rotate the axis of symmetry by an angle alpha")
disp("(alpha > 0, for clockwise rotation)")
alpha = 45.0
disp("Enter alpha (deg) = " + alpha)
alpha = input("Enter alpha (deg) = ")
%}

alph = alpha*conv2;
qIC2 = RT*tan(alph) + R2*sin(thet2);    % distance of new image, IC2, from crystal_C2
f2 = R2/(2*sin(thet2));
u = 1/f2 - 1/qIC2;
pS2 = 1/u;				                % distance of new source position from crystal_C2

%%
% Cartesian Coordinates for C2, C1, IC2, S2, I
% ============================================
% Cartesian coordinates for C2
% ============================
xC2 = R2*sin(thet2);
yC2 = RT;

% Cartesian coordinates for C1
% ============================
xC1 = R1*sin(thet1);
yC1 = RT;

% Cartesian coordinates for IC2
% =============================
xIC2 = -RT*tan(alph);
yIC2 = RT;

% Cartesian coordinates for S2
% ============================
pS = -R2*sin(thet2)/cos(2*thet2);   % distance of old source position S from crytal_C2	
v = pS - pS2;                       % distance between old & new source positions
xS2 = -v*cos(2*thet2);              % Angle between x-axis and incident ray is 180°-2*theta2
yS2 = yS + v*sin(2*thet2);

% Cartesian coordinates for I
% ===========================
f1 = R1/(2*sin(thet1));
pIC2 = -xIC2 + R1*sin(thet1);
w = 1/f1 - 1/pIC2;
qIC2 = abs(1/w);
xI = xC1 - qIC2*cos(2*thet1);
yI = yC1 + qIC2*sin(2*thet1);

% =======================================
% Single crystal C3 to replace C1-C2 pair

thet3 = thet2 - thet1;
theta3 = thet3/conv2;
R3 = RT/cos(thet3);
phC3 = 90.0 - (theta2 + theta1);
xC3 = R3*cos(conv2*phC3);
yC3 = R3*sin(conv2*phC3);

thetas = [thetas,theta3];

twodC3 = lam/sin(thet3);

disp(" ")
disp(" ")
disp(" ")
disp("Crystal C3 2d = " + twodC3)
disp(" ")
disp("wavelength = " + lam)
disp(" ")
disp("thetas = " + thetas)
disp(" ")
disp("radius R3 = " + R3)
disp(" ")
disp(" ")
disp("________________________")

%% Plotting
% =======================================================================
% set(0,'DefaultFigureWindowStyle','docked')
% figure;
grid on
hold on
% title('Case 1', 'FontSize', 14);
% xlabel('Time(s)', 'FontSize', 14);
% ylabel('Position (mm)', 'FontSize', 14);

% plot new Image IC2
plot([xIC2,xIC2],[yIC2,yIC2],'g',Marker='*')

% plot new Source position
plot([xS2,xS2],[yS2,yS2],'g',Marker='*')

% plot new Image I
plot([xI,xI],[yI,yI],'g',Marker='*')

% plot new axis of symmetry
plot([xS2,xI],[yS2,yI],'g')

% plot reflected new ray from crystal_C1
plot([xC1,xI],[yC1,yI])


plot(xC3,yC3,'magenta',Marker='diamond')


%% Printing
% =======================================================================
disp(" ")
disp(" ")
disp(" ")
disp("Results for new axis of symmetry")
disp("alpha = " + alpha)
disp(" ")
disp("Coordinates of new source position S2: ")
disp("[xI,yI] = " + [xI,yI])
disp(" ")
disp("Coordinates of IC2, the new image of crystal_C2")
disp("[xIC2,yIC2] = " + [xIC2,yIC2])
disp(" ")
disp(" ")
disp("________________________")


%% Rotate new config to xicsrt geometry
% =======================================================================
xpin = [xI,xC1,xC2,xS2,xC3];
ypin = [yI,yC1,yC2,yS2,yC3];

%{
revers='Y'
im_mb_rot,xp,yp,revers,x2s,y2s,angles

disp(" ")
disp(" ")
disp("angles = " + angles)
disp(" ")
disp("radii = " + R1/1000.0 + " and " + R2/1000.0)
disp(" ")
disp("ds = " + twods/2)
disp(" ")
%}

revers = 'Y';

%{
Take source, crystal, detector positions from image_mb and rotate 
to configuration required for xicsrt.
%}

conv = pi()/180.0e0;

lrevers = strcmpi(revers, 'Y');


xp = xpin(1,1:4);
yp = ypin(1,1:4);
xC3 = xpin(1,5);
yC3 = ypin(1,5);

disp(" ")
disp("xp, yp")
disp(xp)
disp(yp)
disp("________________________")

np = numel(xp);

if strcmpi(revers, 'Y')

    % =============================
    % Shift origin to lower point
    xp1a = [xp,0.0e0,xC3] - xp(1,4);
    yp1a = [yp,0.0e0,yC3] - yp(1,4);
    yr = [min(yp1a), max(yp1a)];

    disp(" ")
    disp("xp1a, yp1a")
    disp(xp1a)
    disp(yp1a)
    disp("________________________")

    xp1 = xp1a(1,1:5);
    yp1 = yp1a(1,1:5);

    set(0,'DefaultFigureWindowStyle','docked')
    figure;
    grid on
    hold on
    % title('Case 1', 'FontSize', 14);
    % xlabel('Time(s)', 'FontSize', 14);
    % ylabel('Position (mm)', 'FontSize', 14);
    


    plot(xp1(1,1:np),yp1(1,1:np),'r')
    axis equal
    xx = xp1a(1,np+1);
    yy = yp1a(1,np+1);
    plot([xx,xx],[yy,yy],Marker="diamond")
    
    % plot tangency circle
    xt = -RT + findgen2001*RT/1000;
    yt = sqrt(RT.^2-xt.^2);
    plot(xt+xx,yt+yy,'b')
    plot(xt+xx,-yt+yy,'b')
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
    disp("________________________")

    % yp2 = yp2;   % -yp2(1,4)

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

    ac3_1 = 90.0e0 - thetas(1,3);
    ac3_2 = atan( (y2s(1,4) - y3s(1,2)) / (x2s(1,4) - x3s(1,2)) );

end


%% Forward, from top to bottom
% =======================================================================

if ~strcmpi(revers, 'Y')

  xp1 = [xp,0.0e0];
  yp1 = yp(1,1) - [yp,0.0e0];

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

%{
disp(" ")
disp("reversed xp = " + xp2)
disp("reversed yp = " + yp2)
disp("________________________")

% Exchange x and y

xs = [yp2,0.0e0];    % Append center of spheres, which is [0,0]
ys = [xp2,0.0e0];

% =============================================
% First shift to bottom point as origin for revers = 'Y'

x1s = xs;

if strcmpi(revers, 'Y') 
  x1s = -x1s;
end

y1s = ys;
ro1 = -atan(y1s(1,2)/x1s(1,2));
rot1 = ro1/conv;
%}

center = [x2s(1,5),y2s(1,5)];

if strcmpi(revers, 'Y')
    center = [x2s(1,1),y2s(1,1)];
end


%% Plot normals to crystals
% =======================================================================
xx = [center(1,1),x2s(1,3)];
yy = [center(1,2),y2s(1,3)];
plot(xx,yy,'b',LineStyle='--',LineWidth=2)

ic1 = 2;
if lrevers
    ic1 = 4;
end

xx1 = [center(1,1),x2s(ic1)];
yy1 = [center(1,2),y2s(ic1)];
plot(xx1,yy1,'b',LineStyle='--',LineWidth=2)


%% Normals to crystals and detector
% =======================================================================
if strcmpi(revers, 'Y')

  a1 = atan((y2s(1,1)-y2s(1,3))/(x2s(1,3)-x2s(1,1)));
  a2 = atan((y2s(1,4)-y2s(1,1))/(x2s(1,4)-x2s(1,1)));
  a3 = atan((y2s(1,5)-y2s(1,4))/(x2s(1,5)-x2s(1,4)));
  angs = [a1,a2,a3,ac3_1*conv,ac3_2];

else

  a1 = atan((y2s(1,5)-y2s(1,2))/(x2s(1,2)-x2s(1,5)));
  a2 = atan((y2s(1,3)-y2s(1,5))/(x2s(1,3)-x2s(1,5)));
  a3 = atan((y2s(1,3)-y2s(1,4))/(x2s(1,3)-x2s(1,4)));
  angs = [a1,a2,a3];
  angs = abs(angs);

end

angles = angs./conv;

disp(" ")
disp("Angles = " + angles)
disp("________________________")

cosa = cos(angs);
sina = sin(angs);

%{ 
In IDL, array indexing is done by [column, row]. To convert to MATLAB
indexing, just switch the numbers (and add 1 due to different indexing).
e.g. norms[*,0] in IDL is equivalent to norms(0,:) in matlab
%}

norms = zeros(np+2,2);

if lrevers

    norms(1,:) = [0.0e0,1.0e0];
    norms(2,:) = [sina(1,1),-cosa(1,1)];    % concave crystal
    norms(3,:) = [sina(1,2),cosa(1,2)];     % convex crystal
    norms(4,:) = [-sina(1,3),-cosa(1,3)];   % detector

    norms(5,:) = [sina(1,4),-cosa(1,4)];    % crystal C3
    norms(6,:) = [-sina(1,5),-cosa(1,5)];

else

    norms(1,:) = [0.0e0,1.0e0];
    norms(2,:) = [sina(1,1),-cosa(1,1)];
    norms(3,:) = [-sina(1,2),-cosa(1,2)];
    norms(4,:) = [sina(1,3),cosa(1,3)];

end



pos = zeros(np+2,2);

if lrevers

    pos(1,:) = [0.0e0,0.0e0];
    pos(2,:) = [y2s(1,3),x2s(1,3)];
    pos(3,:) = [y2s(1,4),x2s(1,4)];
    pos(4,:) = [y2s(1,5),x2s(1,5)];
    
    pos(5,:) = [y3s(1,2),x3s(1,2)];
    pos(6,:) = [y3s(1,3),x3s(1,3)];

else

    pos(1,:) = [0.0e0,0.0e0];
    pos(2,:) = [y2s(1,2),x2s(1,2)];
    pos(3,:) = [y2s(1,3),x2s(1,3)];
    pos(4,:) = [y2s(1,4),x2s(1,4)];

end


pos = pos/1.0e3;


disp(" ")
disp("pos[y,z]/norm,[y,z]")
disp("________________________")

for i = 1 : np

    disp(" ")
    disp(pos(i,1) + ", " + pos(i,2))            % Source, Concave Crystal, Convex Crystal, Detector
    disp(norms(i,1) + ", " + norms(i,2))
    disp(" ")

end

disp(" ")
disp("Coordinate & norms for C3")
disp("________________________")

for i = 5:6

    disp(" ")
    disp(pos(i,1) + ", " + pos(i,2))
    disp(norms(i,1) + ", " + norms(i,2))
    disp("________________________")

end


%% Check lengths & angles
% 
% for i = 1:np-1
% 
%     ip = i + 1
%     
% 
% end

disp(" ")
disp(" ")
disp(" ")
disp("x positions")
disp(" ")
disp(x2s/1000.0e0)
disp(" ")
disp("y positions")
disp(y2s/1000.0e0)
disp(" ")
disp("angles = " + angles)
disp(" ")
disp("cosines = " + cosa)
disp(" ")
disp("sines = " + sina)
disp(" ")
disp(" ")
disp("________________________")


disp(" ")
disp(" ")
disp(" ")
disp("angles = " + angles)
disp(" ")
disp("radii = " + R1/1000.0 + ", " + R2/1000.0)
disp(" ")
disp("ds = " + twods/2.0e0)
disp(" ")
disp(" ")
disp("________________________")


%% My plan here is was to organize the outputs

% disp("-----------------------------------------------------------------")
% disp("Important values for XICSRT: ")
% disp(" ")
% disp("Lambda = ")
% disp(" ")
% disp("crystal_1 origin = ")
% disp(" ")
% disp("crystal_1 norm (z-axis) = ")
% disp(" ")
% disp("crystal_1 d spacing = ")
% disp(" ")
% disp("crystal_2 origin = ")
% disp(" ")
% disp("crystal_2 norm (z-axis) = ")
% disp(" ")
% disp("crystal_2 d spacing = ")
% disp(" ")
% disp("detector origin = ")
% disp(" ")
% disp("detector norm (z-axis) = ")
% disp(" ")



function [] = animate(xpoint1,xpoint2, ypoint1,ypoint2)

format long

x = [xpoint1 xpoint2] ; 
y = [ypoint1 ypoint2] ; 
p = polyfit(x,y,1) ; 
xi = linspace(x(1),x(2)) ;
yi = polyval(p,xi) ;
comet(xi,yi)
plot(x,y,'*r',xi,yi,'r',LineStyle='--')

end
