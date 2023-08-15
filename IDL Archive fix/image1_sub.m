function [xp,yp,thetas,R1] = image1_sub(E,R2,twods,alpha)
format long

%% Info from image1_sub
% ;"image1_v2.pro" evaluates two versions of our 'Two-Crystal Imaging System' - see ref. [1]. Each of
% ;these two versions consists of a low-resolution HOPG crystal and a high-resolution Si crystal.
% 
% ;from /u/bitter/image1.pro  3-22-2023
% 
% ;The parameters for these two versions are given in the MsWord-file, entitled: 
% ;"Cu-Ka1-line for test of imaging system_LG-3" and are copied below:
% 
% ;Parameters
% ;==========
% ;E-CuKalpha1 = 8.04778 keV, wl =1.54060 A 
% 
% ;Version_1:
% ;========== 
% ;Concave Si-533 crystal_2, 2d=1.65635 Å, R2=823 mm, size: 25 mm x 75mm
% ;Bragg angle theta2 = 68.4531 deg, R2cos(theta2)=302.2572 mm
% 
% ;Convex HOPG crystal_1, 2d=6.7080 Å, R1=310.5586 mm, 
% ;Bragg angle theta1 = 13.2774 deg, R1cos(theta1)=302.2572 mm
% 
% ;Version_2:
% ;========== 
% ;Concave HOPG crystal, 2d=6.7080 Å, R2 = 910.1991 mm
% ;Bragg angle theta2  = 66.7317 deg. R2cos(theta2)=359.5626 mm
% 
% ;Convex Si-422, 2d=2.21707, R1=500 mm, size: 15 mm x 45mm 
% ;Bragg angle theta1 = 44.0177 deg, R1cos(theta1)=359.5626mm
% 
% ;ref[1]: 'A new scheme for stigmatic x-ray imaging with large magnification'
% ;M. Bitter, K. W. Hill, et al., Rev. Sci. Instrum. 83, 10E527 (2012),
% ;===========================================================================

% figure;
% plot(1,1);



conv1 = 12.398419737d0;    % NIST (National Instituate of Standards and Technology)
conv2 = pi()/180;

%% Program
% Calculations for Version_1:
% E = 8.04778   (Energy in keV of Cu_k_alpha line

d2s = twods;
% d2s = double([6.7080,1.65635])
lam = conv1/E;           % lambda
% lam = 1.540601d0
thets = asin(lam./d2s);
thetas = thets/conv2;

Mag = cos( 2.0*thets(1,2) ) / cos( 2.0*thets(1,1) );

disp(" ")
disp(" ")
disp(" ")
disp("thetas = " + thetas)
disp(" ")
disp("Magnification factor for concave-convex = " + Mag)
disp(" ")
disp(" ")
disp(" ")


%% Concave Si-533 Crystal_C2
% R2 = 823.0
theta2 = thetas(1,2);
% theta2 = 68.4531      % for 1st order Bragg reflection
thet2=theta2*conv2;
RT = R2*cos(thet2);		% RT=radius of tangency circle
xC2 = R2*sin(thet2);	% x-coordinate for center of concave crystal_C2
yC2 = RT;				% y-coordinate for center of concave crystal_C2

findgen75 = vpa( int64(0):int64(74) );
findgen201 = vpa( int64(0):int64(200) );

ph20 = (90.0 - theta2)*conv2;		            % polar angle for central point on crystal_C2
ph2 = (-37.0/R2) + (findgen75/R2) + ph20;       % polar angles for 75 points in 1mm-steps along crystal_C2 surface
ph22 = (-100.0/R2) + (findgen201/R2) + ph20;    % polar angles for 200 points in 1mm-steps of crystal_C2 sphere

% Cartesian coordinates (x22,y22) for 200 points of the crystal_C2 sphere
% and (x2,y2) for 75 points along the Si-533 crystal_C2 surface.
% The origin of the Cartesian system is at the center of tangency circle!
% =======================================================================
x22 = R2*cos(ph22);
y22 = R2*sin(ph22);

x2 = R2*cos(ph2);			
y2 = R2*sin(ph2);

%% Convex Hopg Crystal_C1
% ======================
theta1 = thetas(1,1);
% theta1=13.2774		% for 1st order Bragg reflection
thet1 = theta1*conv2;
R1 = RT/cos(thet1);
xC1 = R1*sin(thet1);	% Cartesian coordinates for center of crystal_C1
yC1 = RT;

ph10 = atan(yC1/xC1);		                    % polar angle for center of crystal_C1
ph1 = (-37.0/R1) + (findgen75/R1) + ph10;       % polar angles for 75 points in 1mm-steps along crystal_C1 surface
ph11 = (-100.0/R1) + (findgen201/R1) + ph10;    % polar angles for 200 points in 1mm-steps of crystal_C1 sphere

%%
% Cartesian coordinates (x11,y11) for 200 points of the crystal_C1 sphere
% and (x1,y1) for 75 points along the HOPG crystal_C2 surface.
% ======================================================================
x11 = R1*cos(ph11);
y11 = R1*sin(ph11);

x1 = R1*cos(ph1);			
y1 = R1*sin(ph1);

% Cartesian coordinates for points on tangency circle
% ===================================================
findgen2001 = vpa( int64(0):int64(2000) );
xt = -RT + findgen2001*RT/1000;
yt = sqrt(RT.^2-xt.^2);

% Cartesian coordinates for the Point-Source S
% ============================================
xS = 0.0;
yS = RT - R2*sin(thet2)*tan(2*ph20);

% Cartesian coordinates for the image point I of the Point-Source S
% =================================================================

xI = 0.0;
yI = RT + R1*sin(thet1)*tan(2*thet1);

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
disp("Convex HOPG Crystal_1")
disp("R1 = " + R1)
disp(" ")
disp("Radius of Tangency Circle")
disp("RT = " + RT)
disp(" ")
disp(" ")
disp(" ")

%% Plotting
set(0,'DefaultFigureWindowStyle','normal')
figure;
grid on
hold on
% title('Case 1', 'FontSize', 14);
% xlabel('Time(s)', 'FontSize', 14);
% ylabel('Position (mm)', 'FontSize', 14);

% plot tangency circle
plot(xt,yt,'b')
plot(xt,-yt,'b')
axis equal

% plot 200 points of crystal_C2 sphere and 75 points along crystal_C2 surface
plot(x22,y22)
plot(x2,y2,'g',Marker='.')
plot([xC2,xC2],[yC2,yC2],'r',Marker='.')

% plot central point on Crystal_C2 and its real image of on tangency circle
plot([xC2,xC2],[yC2,yC2],'r',Marker='*')    % center of crystal_C2
plot([0,0],[RT,RT],'r',Marker='*')          % image of center of crystal_C2

% plot center point of crystal_C1, point source S and its image I
plot([xC1,xC1],[yC1,yC1],'r',Marker='*')
plot([xS,xS],[yS,yS],'r',Marker='*')
plot([xI,xI],[yI,yI],'r',Marker='*')

% plot, 200 points of crystal_C1 sphere and 75 points along crystal_C surface
plot(x11,y11)
plot(x1,y1,'g',Marker='.')
plot([xC1,xC1],[yC1,yC1],'r',Marker='.')

% plot reflected ray from center of Crystal_C2 
% to its real image on tangency circle
plot([0,xC2],[RT,RT],'r',LineStyle="--")

% plot incident ray on center of Crystal_C2
plot([xS,xC2],[yS,yC2],'r',LineStyle="--")

% plot reflected ray from crystal_C1 to image point I
plot([xC1,xI],[yC1,yI],'r',LineStyle="--")

% length of incident ray from source S to crystal_C2 in presentstandard configuration
p2 = -R2*sin(thet2)/cos(2*thet2);

% length of reflected ray from crystal_C2 to image IC2 in present standard configuration	
q2 = R2*sin(thet2);		


% read,dum


%% PART II: Choosing a new Arrangement by Rotaion of the Axis of Symmetry 
% ======================================================================
% disp("Choose new Arrangement by rotating the Axis of Symmetry: lun=1 for yes, lun=0 for no")
% lun=1
% lun = input("Enter lun = ")
% if (lun eq 0) then goto,lbl17

% disp("Rotate the axis of symmetry by an angle alpha")
% disp("(alpha > 0, for clockwise rotation)")
% alpha = 45.0
% disp("Enter alpha (deg) = " + alpha)
% alpha = input("Enter alpha (deg) = ")

alph = alpha*conv2;
qIC2 = RT*tan(alph) + R2*sin(thet2);     % distance of new image, IC2, from crystal_C2
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
v = pS-pS2;                         % distance between old & new source positions
xS2 = -v*cos(2*thet2);              % Angle between x-axis and incident ray is 180°-2*theta2
yS2=yS+v*sin(2*thet2);

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
disp(" ")

%% Plotting
set(0,'DefaultFigureWindowStyle','normal')
figure;
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
disp(" ")

% ====================================
% Rotate new config to xicsrt geometry

xp = [xI,xC1,xC2,xS2,xC3];
yp = [yI,yC1,yC2,yS2,yC3];

% revers='Y'
% im_mb_rot,xp,yp,revers,x2s,y2s,angles


% disp(" ")
% disp(" ")
% disp("angles = " + angles)
% disp(" ")
% disp("radii = " + R1/1000.0 + " and " + R2/1000.0)
% disp(" ")
% disp("ds = " + twods/2)
% disp(" ")


end
