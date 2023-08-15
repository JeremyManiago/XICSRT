clear
clc
close all

%% Info from image1_run
% ;image1_run.pro
% ;Runs image1_sub 
% 
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


conv1 = 12.398419737;   % NIST (National Instituate of Standards and Technology)
conv2 = pi()/180;

%% Program

E = 8.04778;     % Energy in keV of Cu_k_alpha line

% order = 4;
twods = double([2.7496365, 1.6564458]);      % Quartz-203, Silicon-533, M~2
% twods = double([2.2172048,6.7080/order])	% Si-422, 4th order graphite, M=20
% twods = double([6.7080, 1.65635])		    % C002, Si-533
R2 = 823.0;
alpha = 0.0;

[xp,yp,thetas,R1] = image1_sub(E,R2,twods,alpha)

% ====================================
% Rotate new config to xicsrt geometry

% xp=[xi,xc1,xc2,xs2]
% yp=[yi,yc1,yc2,ys2]
% revers='Y'
revers = 'Y';

[angles] = im_mb_rot(xp,yp,revers,thetas)

disp(" ")
disp(" ")
disp("angles = " + angles)
disp(" ")
disp("radii = " + R1/1000.0 + ", " + R2/1000.0)
disp(" ")
disp("ds = " + twods/2.0d0)
disp(" ")
disp(" ")


