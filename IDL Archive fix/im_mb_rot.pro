
Pro im_mb_rot,xpin,ypin,revers,x2s,y2s,angles,thetas

;Take source, crystal, detector positions from image_mb and rotate
;to configuration required for xicsrt.

getcolors,colors,white,black,red,gray,blue,green,magenta,ltblue
dum=' '
plot_setup

conv=!pi/180.0d0

lrevers=(strupcase(revers) eq 'Y')
;xp[where(abs(xp) lt 1.0d-4)]=0.0d0
;yp[where(abs(yp) lt 1.0d-4)]=0.0d0

;revers='Y'

xp=xpin[0:3]
yp=ypin[0:3]
xC3=xpin[4]
yC3=ypin[4]


print,' '
print,'xp, yp'
print,xp
print,yp
print,' '

!xtitle='z'
!ytitle='y'


np=n_elements(xp)

If strupcase(revers) eq 'Y' then begin  

  ;=============================
  ;Shift origin to lower point
  
  xp1a=[xp,0.0d0,xC3]-xp[3]
  yp1a=[yp,0.0d0,yC3]-yp[3]
  yr=[min(yp1a),max(yp1a)]
  print,' '
  print,'xp1a, yp1a'
  print,xp1a
  print,yp1a
  print,' '

  xp1=xp1a[0:4]
  yp1=yp1a[0:4]

  plot,xp1[0:np-1],yp1[0:np-1],yr=yr	;/isotropic,yr=yr
  xx=xp1a[np]
  yy=yp1a[np]
  oplot,[xx,xx],[yy,yy],psym=4,symsize=2  
  read,dum
 
  ;===============================================================
  ;Determine angle to rotate from MB coordinates to NP coordinates
  ro=-atan((yp1[2]-yp1[3])/(xp1[2]-xp1[3]))
  rotang=ro/conv
  print,' '
  print,'rotation angle =', rotang
  print,' '
  xp2a=xp1a*cos(ro)-yp1a*sin(ro)
  yp2a=xp1a*sin(ro)+yp1a*cos(ro)
  
  xp2=xp2a[0:4]
  yp2=yp2a[0:4]
  
  print,' '
  print,'xp2,yp2'
  print,xp2
  print,yp2
  print,' '
  
  ;yp2=yp2	;-yp2[3]
  
  mywindow,0
  plot,xp2[0:np-1],yp2[0:np-1],thick=3,/isotropic
  xx=xp2[np]
  yy=yp2[np]
  oplot,[xx,xx],[yy,yy],psym=4,symsize=2
  read,dum
  
  x2s=reverse(xp2)
  y2s=reverse(yp2)
  
  xc3s=[xp2[3],xp2a[5],xp2a[0]]
  yc3s=[yp2[3],yp2a[5],yp2a[0]]
  oplot,xc3s,yc3s,color=magenta,linestyle=2
  
  x3s=xc3s
  y3s=yc3s
  
  ac3_1=90.0d0-thetas[2]
  ac3_2=atan((y2s[3]-y3s[1])/(x2s[3]-x3s[1]))
  read,dum
  
Endif

;=====================================
;Forward, from top to bottom

If strupcase(revers) ne 'Y' then begin  

  xp1=[xp,0.0d0]
  yp1=yp[0]-[yp,0.0d0]

  plot,xp1,yp1,/isotropic
  read,dum
  ro1=atan(xp1[1]/yp1[1])
  rot1=ro1/conv
  xp2=xp1*cos(ro1)-yp1*sin(ro1)
  yp2=xp1*sin(ro1)+yp1*cos(ro1)
  x2s=yp2
  y2s=xp2
    
  mywindow,0
  plot,x2s,y2s,thick=3,/isotropic
  read,dum
Endif


;stop

;print,'reversed xp',xp2
;print,'reversed yp',yp2

;Exchange x and y

;xs=[yp2,0.0d0]		;Append center of spheres, which is [0,0]
;ys=[xp2,0.0d0]


;=============================================
;First shift to bottom point as origin for revers='Y'

;x1s=xs
;If strupcase(revers) eq 'Y' then x1s=-x1s
;y1s=ys
;ro1=-atan(y1s[1]/x1s[1])
;rot1=ro1/conv



;window,0,xpos=2620,xsize=1100,ysize=900
;window,0,xpos=2720,xsize=1000,ysize=1050

;plot,x1s,y1s,/isotropic,yr=[-100,1200],thick=3
;oplot,x1s,y1s,psym=4,symsize=3,color=red

;x2s=x1s*cos(ro1)-y1s*sin(ro1)
;y2s=x1s*sin(ro1)+y1s*cos(ro1)
;If strupcase(revers) eq 'Y' then y2s=-y2s

yr=[-100,1200]
dy=50
;yr=[min(y2s)-dy,max(y2s)+dy]

;plot,x2s[0:3],y2s[0:3],yr=yr,ystyle=1,/isotropic,thick=3

center=[x2s[4],y2s[4]]
If strupcase(revers) eq 'Y' then center=[x2s[0],y2s[0]]

;==============================================
;Plot normals to crystals

xx=[center[0],x2s[2]]
yy=[center[1],y2s[2]]
oplot,xx,yy,color=blue,linestyle=2,thick=2

ic1=1
If lrevers then ic1=3

xx1=[center[0],x2s[ic1]]
yy1=[center[1],y2s[ic1]]
oplot,xx1,yy1,color=blue,linestyle=2,thick=2

read,dum

fmt='(a6,5f13.6)'

;print,' '
;Print,'Rot x',x2s,format=fmt
;print,'Rot y',y2s,format=fmt
;print,' '

;oplot,x2s[0:3],y2s[0:3],color=blue,thick=3
;read,dum


;Normals to crystals and detector

If strupcase(revers) eq 'Y' then begin
  a1=atan((y2s[0]-y2s[2])/(x2s[2]-x2s[0]))
  a2=atan((y2s[3]-y2s[0])/(x2s[3]-x2s[0]))
  a3=atan((y2s[4]-y2s[3])/(x2s[3]-x2s[4]))
  angs=[a1,a2,a3,aC3_1*conv,aC3_2]
Endif

If strupcase(revers) ne 'Y' then begin
  a1=atan((y2s[4]-y2s[1])/(x2s[1]-x2s[4]))
  a2=atan((y2s[2]-y2s[4])/(x2s[2]-x2s[4]))
  
  a3=atan((y2s[2]-y2s[3])/(x2s[2]-x2s[3]))
  angs=[a1,a2,a3]
  angs=abs(angs)
Endif



angles=angs/conv

print,'angles',angles


cosa=cos(angs)
sina=sin(angs)

norms=dblarr(2,np+2)

If lrevers then begin
norms[*,0]=[0.0d0,1.0d0]
norms[*,1]=[sina[0],-cosa[0]]
norms[*,2]=[sina[1],cosa[1]]
norms[*,3]=[-sina[2],cosa[2]]

norms[*,4]=[sina[3],-cosa[3]]
norms[*,5]=[-sina[4],-cosa[4]]
Endif

If not lrevers then begin
norms[*,0]=[0.0d0,1.0d0]
norms[*,1]=[sina[0],-cosa[0]]
norms[*,2]=[-sina[1],-cosa[1]]
norms[*,3]=[sina[2],cosa[2]]
Endif




pos=dblarr(2,np+2)

If lrevers then begin
pos[*,0]=[0.0d0,0.0d0]
pos[*,1]=[y2s[2],x2s[2]]
pos[*,2]=[y2s[3],x2s[3]]
pos[*,3]=[y2s[4],x2s[4]]

pos[*,4]=[y3s[1],x3s[1]]
pos[*,5]=[y3s[2],x3s[2]]
Endif

If not lrevers then begin
pos[*,0]=[0.0d0,0.0d0]
pos[*,1]=[y2s[1],x2s[1]]
pos[*,2]=[y2s[2],x2s[2]]
pos[*,3]=[y2s[3],x2s[3]]
Endif





pos=pos/1.0d3




print,' '
print,'       pos[y,z]/norm[y,z]'
print,' '

For i=0,np-1 do begin
  print,' '
  print,pos[0,i],',',pos[1,i]
  print,norms[0,i],',',norms[1,i]
  print,' '
  ;print,' '  
Endfor

print,' '
print,'Coords & norms for C3'
print,' '
For i=4,5 do begin
  print,' '
  print,pos[0,i],',',pos[1,i]
  print,norms[0,i],',',norms[1,i]
  print,' '
  ;print,' '  
Endfor



;stop
;Check lengths & angles

For i=0,np-2 do begin
  ip=i+1
  line_angle,[x2s[i],y2s[i]],[x2s[ip],y2s[ip]],ang2,len2
  line_angle,[xp[i],yp[i]],[xp[ip],yp[ip]],ang1,len1
  print,'ang1,len1',ang1,len1,ang2,len2
Endfor

;stop
return

;stop

print,' '
print,'x positions'
print,' '
print,x2s/1000.0d0
print,' '
print,'y positions'
print,y2s/1000.0d0
print,' '
print,'angles',angles
print,' '

print,'cosines',cosa
print,' '
print,'sines',sina
print,' '




;stop
return
end
