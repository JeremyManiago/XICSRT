;image1_run.pro
;Runs image1_sub

;"image1_v2.pro" evaluates two versions of our 'Two-Crystal Imaging System' - see ref. [1]. Each of
;these two versions consists of a low-resolution HOPG crystal and a high-resolution Si crystal.

;from /u/bitter/image1.pro  3-22-2023

;The parameters for these two versions are given in the MsWord-file, entitled: 
;"Cu-Ka1-line for test of imaging system_LG-3" and are copied below:

;Parameters
;==========
;E-CuKalpha1 = 8.04778 keV, wl =1.54060 A 

;Version_1:
;========== 
;Concave Si-533 crystal_2, 2d=1.65635 Å, R2=823 mm, size: 25 mm x 75mm
;Bragg angle theta2 = 68.4531 deg, R2cos(theta2)=302.2572 mm

;Convex HOPG crystal_1, 2d=6.7080 Å, R1=310.5586 mm, 
;Bragg angle theta1 = 13.2774 deg, R1cos(theta1)=302.2572 mm

;Version_2:
;========== 
;Concave HOPG crystal, 2d=6.7080 Å, R2 = 910.1991 mm
;Bragg angle theta2  = 66.7317 deg. R2cos(theta2)=359.5626 mm

;Convex Si-422, 2d=2.21707, R1=500 mm, size: 15 mm x 45mm 
;Bragg angle theta1 = 44.0177 deg, R1cos(theta1)=359.5626mm

;ref[1]: 'A new scheme for stigmatic x-ray imaging with large magnification'
;M. Bitter, K. W. Hill, et al., Rev. Sci. Instrum. 83, 10E527 (2012),
;===========================================================================

;Plotting Commands
;Device,Decompos=0
;!p.background=255
;getcolors,colors,white,black,red,gray,blue,green,magenta,yellow,ltblue

set_plot,'X'
Device,Decompos=0
getcolors,colors,white,black,red,gray,blue,green,magenta,ltblue
!p.background=255
!p.color=0
dum=' '
;======================================================================

conv1=12.398419737d0    ;NIST
conv2=!pi/180.0d0


;PROGRAM STARTS HERE:
;====================
;Calculations for Version_1:
;===========================
E=8.04778d0			;Energy (keV) of Cu_k_alpha line

order=4

twods=double([2.7496365,1.6564458])	;QZ203, Si533,  M~2

;twods=double([2.2172048,6.7080/order])	;Si 422, 4th order graphite, M=20

;twods=double([6.7080,1.65635])		;C002, Si533

R2=823.0d0
alpha=0.0d0
revers='Y'


image1_sub,E,R2,twods,alpha,revers,R1,xp,yp,xC3,yC3,thetas


;====================================
;Rotate new config to xicsrt geometry

;xp=[xi,xc1,xc2,xs2]
;yp=[yi,yc1,yc2,ys2]
;revers='Y'

im_mb_rot,xp,yp,revers,x2s,y2s,angles,thetas

print,' '
print,' '
print,'angles',angles
print,' '
print,'radii',R1/1000.0,R2/1000.0
print,' '
print,'ds',twods/2.0d0
print,' '




lbl17:

end
