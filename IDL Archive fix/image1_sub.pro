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
;Concave Si-533 crystal_2, 2d=1.65635 �, R2=823 mm, size: 25 mm x 75mm
;Bragg angle theta2 = 68.4531 deg, R2cos(theta2)=302.2572 mm

;Convex HOPG crystal_1, 2d=6.7080 �, R1=310.5586 mm, 
;Bragg angle theta1 = 13.2774 deg, R1cos(theta1)=302.2572 mm

;Version_2:
;========== 
;Concave HOPG crystal, 2d=6.7080 �, R2 = 910.1991 mm
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


Pro image1_sub,E,R2,twods,alpha,revers,R1,xp,yp,xC3,yC3,thetas


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
;E=8.04778d0			;Energy (keV) of Cu_k_alpha line

d2s=twods
;d2s=double([6.7080,1.65635])
lam=conv1/E
;lam=1.540601d0
thets=asin(lam/d2s)
thetas=thets/conv2

Mag=cos(2.0d0*thets[1])/cos(2.0d0*thets[0])

print,' '
print,'thetas=',thetas
print,' '
Print,'Magnification factor for concave-convex =',Mag

;Concave Si-533 Crystal_C2
;=========================
;R2=823.0d0
theta2=thetas[1]
;theta2=68.4531d0		;for 1st order Bragg reflection
thet2=theta2*conv2
RT=R2*cos(thet2)		;RT=radius of tangency circle
xC2=R2*sin(thet2)		;x-coordinate for center of concave crystal_C2
yC2=RT				;y-coordinate for center of concave crystal_C2

ph20=(90.0d0-theta2)*conv2		;polar angle for central point on crystal_C2
ph2=-37.0d0/R2+findgen(75)/R2+ph20	;polar angles for 75 points in 1mm-steps along crystal_C2 surface
ph22=-100.0d0/R2+findgen(201)/R2+ph20 ;polar angles for 200 points in 1mm-steps of crystal_C2 ssphere

;Cartesian coordinates (x22,y22) for 200 points of the crystal_C2 sphere
;and (x2,y2) for 75 points along the Si-533 crystal_C2 surface.
;The origin of the Cartesian system is at the center of tangency circle!
;=======================================================================
x22=R2*cos(ph22)
y22=R2*sin(ph22)

x2=R2*cos(ph2)			
y2=R2*sin(ph2)

;Convex Hopg Crystal_C1
;======================
theta1=thetas[0]
;theta1=13.2774d0		;for 1st order Bragg reflection
thet1=theta1*conv2
R1=RT/cos(thet1)
xC1=R1*sin(thet1)		;Cartesian coordinates for center of crystal_C1
yC1=RT

ph10=atan(yC1/xC1)		   ;polar angle for center of crystal_C1
ph1=-37.0d0/R1+findgen(75)/R1+ph10	   ;polar angles for 75 points in 1mm-steps along crystal_C1 surface
ph11=-100.0d0/R1+findgen(201)/R1+ph10 ;polar angles for 200 points in 1mm-steps of crystal_C1 sphere

;Cartesian coordinates (x11,y11) for 200 points of the crystal_C1 sphere
;and (x1,y1) for 75 points along the HOPG crystal_C2 surface.
;======================================================================
x11=R1*cos(ph11)
y11=R1*sin(ph11)

x1=R1*cos(ph1)			
y1=R1*sin(ph1)

;Cartesian coordinates for points on tangency circle
;===================================================
xt=-RT+findgen(2001)*RT/1000.
yt=sqrt(RT^2-xt^2)

;Cartesian coordinates for the Point-Source S
;============================================
xS=0.0d0
yS=RT-R2*sin(thet2)*tan(2*ph20)

;Cartesian coordinates for the image point I of the Point-Source S
;=================================================================
xI=0.0d0
yI=RT+R1*sin(thet1)*tan(2*thet1)

print,' '
print,'PARAMETERS:'
print,'========================'
print,'Cu_k_alpha line'
print,'E(keV) = ',E
print,' '
print,'Concave Si-533 Crystal_2'
print,'R2 = ',R2
print,' '
print,'Convex HOPG Crystal_1'
print,'R1 = ',R1
print,' '
print,'Radius of Tangency Circle'
print,'RT = ',RT


;PLOTTING
;========
!grid=0
!Psym=0
mywindow,0

;plot tangecy circle
;===================
plot,xT,yT,xr=[-800,900],yr=[-500,800],/isotropic,xstyle=1,ystyle=1
oplot,xT,yT,color=blue
oplot,xT,-yT,color=blue

;oplot, 200 points of crystal_C2 sphere and 75 points along crystal_C2 surface
;=============================================================================
oplot,x22,y22
!Psym=3
oplot,x2,y2,color=green
oplot,[xC2,xC2],[yC2,yC2],color=red

;oplot central point on Crystal_C2 and its real image of on tangency circle
;==========================================================================
!psym=2
oplot,[xC2,xC2],[yC2,yC2],color=red 	;center of crystal_C2
oplot,[0,0],[RT,RT],color=red		;image of center of crystal_C2

;oplot center point of crystal_C1, point source S and its image I
;================================================================
oplot,[xC1,xC1],[yC1,yC1],color=red
oplot,[xS,xS],[yS,yS],color=red
oplot,[xI,xI],[yI,yI],color=red

;oplot, 200 points of crystal_C1 sphere and 75 points along crystal_C surface
;=============================================================================
!psym=0
oplot,x11,y11
!Psym=3
oplot,x1,y1,color=green
oplot,[xC1,xC1],[yC1,yC1],color=red

;oplot reflected ray from center of Crystal_C2 
;to its real image on tangency circle
;=============================================
!psym=0
oplot,[0,xC2],[RT,RT]

;Oplot incident ray on center of Crystal_C2
;==========================================
oplot,[xS,xC2],[yS,yC2]

;oplot reflected ray from crystal_C1 to image point I
;====================================================
oplot,[xC1,xI],[yC1,yI]

;length of incident ray from source S to crystal_C2 in presentstandard configuration
p2=-R2*sin(thet2)/cos(2*thet2)

;length of reflected ray from crystal_C2 to image IC2 in present standard configuration	
q2=R2*sin(thet2)		


;read,dum

;PART II: Choosing a new Arrangement by Rotaion of the Axis of Symmetry 
;======================================================================
;print,'Choose new Arrangement by rotating the Axis of Symmetry: lun=1 for yes, lun=0 for no'
;lun=1
;read,'Enter lun = ',lun
;if (lun eq 0) then goto,lbl17

;print,'Rotate the axis of symmetry by an angle alpha'
;print,'(alpha > 0, for clockwise rotation)'
;alpha=45.0d0
;print,'Enter alpha (deg) = ',alpha
;read,'Enter alpha (deg) = ',alpha
alph=alpha*conv2
qIC2=RT*tan(alph)+R2*sin(thet2)	;distance of new image, IC2, from crystal_C2
f2=R2/(2*sin(thet2))
u=1/f2-1/qIC2
pS2=1/u				;distance of new source position from crystal_C2

;Cartesian Coordinates for C2, C1, IC2, S2, I
;============================================
;Cartesian coordinates for C2
;============================
xC2=R2*sin(thet2)
yC2=RT

;Cartesian coordinates for C1
;============================
xC1=R1*sin(thet1)
yC1=RT

;Cartesian coordinates for IC2
;=============================
xIC2=-RT*tan(alph)
yIC2=RT

;Cartesian coordinates for S2
;============================
pS=-R2*sin(thet2)/cos(2*thet2)	;distance of old src posn S from xtal_C2	
v=pS-pS2			;distance between old & new source posns
xS2=-v*cos(2*thet2)		;Angle between x-axis and incident ray is 180�-2*theta2
yS2=yS+v*sin(2*thet2)

;Cartesian coordinates for I
;===========================
f1=R1/(2*sin(thet1))
pIC2=-xIC2+R1*sin(thet1)
w=1/f1-1/pIC2
qIC2=abs(1/w)
xI=xC1-qIC2*cos(2*thet1)
yI=yC1+qIC2*sin(2*thet1)


;=======================================
;Single crystal C3 to replace C1-C2 pair

thet3=thet2-thet1
theta3=thet3/conv2
R3=RT/cos(thet3)
phC3=90.0d0-(theta2+theta1)
xC3=R3*cos(conv2*phC3)
yC3=R3*sin(conv2*phC3)

thetas=[thetas,theta3]

twodC3=lam/sin(thet3)

print,' '
print,'Crystal C3 2d=',twodC3
print,' '
print,'wavelength=',lam
print,' '
print,'thetas=',thetas
print,' '
print,'radius R3=',R3

;PLOTTING
;========
!psym=2
;oplot new Image IC2
;===================
oplot,[xIC2,xIC2],[yIC2,yIC2],color=green

;oplot new Source position
;=========================
oplot,[xS2,xS2],[yS2,yS2],color=green

;oplot new Image I
;=================
oplot,[xI,xI],[yI,yI],color=green

;oplot new axis of symmetry
;==========================
!psym=0
oplot,[xS2,xI],[yS2,yI],color=green

;oplot reflected new ray from crystal_C1
;=======================================
 oplot,[xc1,xI],[yC1,yI]



oplot,[xC3],[yC3],psym=4,color=magenta


read,dum

;Printing
;======== 
print,' '
Print,'Results for new axis of symmetry'
print,'alpha = ',alpha

print,' '
print,'Coordinates of new source position S2:'
print,'[xS2,yS2] = ',[xS2,yS2]

print,' '
print,'Coordinates for new Image I:'
print,'[xI,yI] = ',[xI,yI]

print,' '
print,'Coordinates of IC2, the new image of crystal_C2:'
print,'[xIC2,yIC2] = ',[xIC2,yIC2]


;====================================
;Rotate new config to xicsrt geometry

xp=[xi,xc1,xc2,xs2,xC3]
yp=[yi,yc1,yc2,ys2,yC3]


return

;revers='Y'
;im_mb_rot,xp,yp,revers,x2s,y2s,angles

print,' '
print,' '
print,'angles',angles
print,' '
print,'radii',R1/1000.0,R2/1000.0
print,' '
print,'ds',twods/2
print,' '




;lbl17:


Return
End
