# def DCI_to_XICSRT(energy, twods, R2, alpha):
#

''''''
import numpy as np
import matplotlib.pyplot as plt

E = 8.04779e0

'''Crystal 2D spacings of Convex Silicon 422 
and Concave Silicon 533, respectively'''
twods =  np.double(np.array([2.21707, 1.65635]))
R2 = 823.0e0



alpha = 0e0

conv1 = 12.398419737e0;                       # NIST (National Institute of Standards and Technology)
conv2 = np.pi/180.0e0;                        # radians to degrees



''''''
d2s = twods
lam = conv1/E
thets = np.arcsin(lam/d2s)
thetas = thets/conv2

Mag = -np.cos( 2.0*thets[1] - (alpha*conv2) ) / np.cos( 2.0*thets[0] + (alpha*conv2))   # Magnification : distance from source to detector divided by distance from source to crystal

print(" ")
print(" ")
print(" ")
print("thetas = " + str(thetas))
print(" ")
print("Magnification factor for concave-convex = " + str(Mag))
print(" ")
print(" ")
print("________________________")

alpha = alpha*conv2
ralph = [[np.cos(alpha), -np.sin(alpha)],
          [np.sin(alpha), np.cos(alpha)]]


''''''

def mkshp(pac,R):     # Make source, image, and crystal shapes
    fg75 = np.arange(1, 75+1, dtype=np.int64)
    fg401 = np.arange(1, 401+1, dtype=np.int64)

    pa75 = (-37.0e0/R) + (fg75/R) + pac        # polar angles for 75 points in 1mm-steps along surface
    pa401 = (-200.0e0/R) + (fg401/R) + pac     # polar angles for 401 points in 1mm-steps of sphere

    '''
    Cartesian coordinates (x401,y401) for 200 points of the sphere
    and (x75,y75) for 75 points along the surface.
    The origin of the Cartesian system is at the center of tangency circle!
    '''
    x401 = R*np.cos(pa401)
    y401 = R*np.sin(pa401)
    cart401 = ([x401, y401])

    x75 = R*np.cos(pa75)		
    y75 = R*np.sin(pa75)
    cart75 = ([x75, y75])    


    return cart401, cart75


# Concave Crystal
theta2 = thetas[1]
thet2 = theta2*conv2
RT = R2*np.cos(thet2)
xC2 = R2*np.sin(thet2)
yC2 = RT
pac2 = (90.0e0 - theta2)*conv2        # polar angle for central point on concave crystal

cav401, cav75 = mkshp(pac2,R2)

# Convex Crystal
theta1 = thetas[0]
thet1 = theta1*conv2
R1 = RT/np.cos(thet1)
xC1 = R1*np.sin(thet1)
yC1 = RT
pac1 = np.arctan(yC1/xC1)

vex401, vex75 = mkshp(pac1,R1)

# Tangency Circle
fg2001 = np.arange(1, 2001+1, dtype=np.int64)
xt = -RT + fg2001*RT/1000
yt = np.emath.sqrt(RT**2 - np.power(xt,2))
yt = yt.real

# Point-Source
xS = 0.0e0
yS = RT - R2*np.sin(thet2)*np.tan(2*pac2)
RS = yS
pacS = np.arctan(np.inf)

s401, s75 = mkshp(pacS,RS)

# Image
xI = 0.0e0
yI = RT + R1*np.sin(thet1)*np.tan(2*thet1)
RI = yI
pacI = np.arctan(np.inf)

i401, i75 = mkshp(pacI,RI)

'''Plotting'''
plt.figure()


plt.plot(cav401[0],cav401[1])
plt.plot(cav75[0],cav75[1], 'go')
plt.plot(xC2, yC2, 'rx', ms=10)

plt.plot(vex401[0],vex401[1])
plt.plot(vex75[0],vex75[1], 'go')
plt.plot(xC1, yC1, 'rx', ms=10)

plt.plot(xt,yt,'b')
plt.plot(xt,-yt,'b')
plt.plot(0,0,'rD', ms=10)

plt.plot(s401[0],s401[1])
plt.plot(s75[0],s75[1])
plt.plot(xS, yS, 'r*', ms=10)

plt.plot(i401[0],i401[1])
plt.plot(i75[0],i75[1])
plt.plot(xI, yI, 'r*', ms=10)

plt.axis('equal')
plt.show()