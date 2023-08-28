# -*- coding: utf-8 -*-

# my_functions.py


def my_fwhm(x,y,thr,nf):
    import numpy as np
    import scipy
    from scipy.interpolate import UnivariateSpline

    #Gaussian fit
    coefs=gaussfit(x,y)
    fwhmg=2.3548*coefs[2]
    print('fwhmg=',fwhmg)
    gfit=gaus(x,coefs[0],coefs[1],coefs[2])

    xmn=np.min(x)
    xmx=np.max(x)
    #nf=10000
    xf=np.linspace(xmn,xmx,nf)
    dx=xmx-xmn
    xf1=xf*dx/nf

    spl=UnivariateSpline(x,y)
    yf=spl(xf)

    ymx=np.max(yf)
    diff=yf-ymx*thr

    roots=np.where(np.diff(np.sign(np.array(diff))))[0]
    #help(roots)
    print('roots=',roots)
    aroots=np.average(roots)
    print('average of roots=',aroots)
    rmin=np.min(roots)
    rmax=np.max(roots)
    print(rmin,rmax)
    dr=rmax-rmin

    imax=np.argmax(y)
    lroots=[np.where(x<x[imax])]
    rroots=[np.where(x>x[imax])]
    xl=np.average(lroots)
    xr=np.average(rroots)
    dr=xr-xl

    #nr=np.ndarray.size(roots)
    #nr=np.len(roots)
    #print('no. of roots=',nr)
    fwhm=dr*dx/nf
    #print(fwhm)
    return(fwhm,fwhmg,gfit,rmin,rmax,ymx)


def fwhm_spl(x,y,thr,nf):
    import numpy as np
    import scipy
    from scipy.interpolate import UnivariateSpline

    #Gaussian fit
    #coefs=gaussfit(x,y)
    #fwhmg=2.3548*coefs[2]
    #print('fwhmg=',fwhmg)
    #gfit=gaus(x,coefs[0],coefs[1],coefs[2])

    xmn=np.min(x)
    xmx=np.max(x)
    #nf=10000
    xf=np.linspace(xmn,xmx,nf)
    dx=xmx-xmn
    xf1=xf*dx/nf

    spl=UnivariateSpline(x,y)
    yf=spl(xf)

    ymx=np.max(yf)
    diff=yf-ymx*thr

    iroots=np.where(np.diff(np.sign(np.array(diff))))[0]
    #help(roots)
    roots=xf[iroots]
    print(' ')
    print('roots=',roots)
    aroots=np.average(roots)
    #print('average of roots=',aroots)

    nr=len(roots)
    print('num of roots=',nr)
   
    rmin=np.min(roots)
    rmax=np.max(roots)
    print('rmin, rmax = ')
    print(rmin,rmax)
    dr=rmax-rmin
    
    imax=np.argmax(y)
    lroots=[np.where(x<x[imax])]
    rroots=[np.where(x>x[imax])]
    xl=np.average(lroots)
    xr=np.average(rroots)

    
    #dr=xr-xl

    fwhm=dr
    return(fwhm)

def fwhm_spl_2(x,y,thr,nf):
    import numpy as np
    import scipy
    from scipy.interpolate import UnivariateSpline

    #Gaussian fit
    #coefs=gaussfit(x,y)
    #fwhmg=2.3548*coefs[2]
    #print('fwhmg=',fwhmg)
    #gfit=gaus(x,coefs[0],coefs[1],coefs[2])

    xmn=np.min(x)
    xmx=np.max(x)
    #nf=10000
    xf=np.linspace(xmn,xmx,nf)
    dx=xmx-xmn
    xf1=xf*dx/nf

    spl=UnivariateSpline(x,y)
    yf=spl(xf)

    ymx=np.max(yf)
    diff=yf-ymx*thr

    iroots=np.where(np.diff(np.sign(np.array(diff))))[0]
    #help(roots)
    roots=xf[iroots]
    print(' ')
    print('roots=',roots)
    aroots=np.average(roots)
    #print('average of roots=',aroots)

    nr=len(roots)
    print('num of roots=',nr)
   
    rmin=np.min(roots)
    rmax=np.max(roots)
    print('rmin, rmax = ')
    print(rmin,rmax)
    dr=rmax-rmin
    
    imax=np.argmax(y)
    lroots=[np.where(x<x[imax])]
    rroots=[np.where(x>x[imax])]
    xl=np.average(lroots)
    xr=np.average(rroots)

    
    #dr=xr-xl

    fwhm=dr
    return(fwhm,rmin,rmax,ymx)


def gaussfit(x,y):
    import pylab as plb
    import matplotlib.pyplot as plt
    from scipy.optimize import curve_fit
    from scipy import asarray as ar,exp
    import numpy as np
    a0=np.max(y)
    n = len(x)                          #the number of data
    mean = sum(x*y)/sum(y)                   #note this correction
    #sigma = sum(y*(x-mean)**2)/sum(y)        #note this correction
    fw=fwhm_spl(x,y,0.5,200)
    sigma=fw/2.35
    if sigma <= 0: sigma=0.5
       
    print('Initial n,a0,mean,sigma=',n,a0,mean,sigma)
    popt,pcov = curve_fit(gaus,x,y,p0=[a0,mean,sigma], maxfev = 2000)
    print('popt=',popt)
    print('pcov=',pcov)
    return(popt)

def gaus(x,a,x0,sigma):
    import numpy as np
    return a*np.exp(-(x-x0)**2/(2*sigma**2))

def fitter_gauss(x2,y2):
    #From https://learn.astropy.org/tutorials/Models-Quick-Fit.html

    import numpy as np
    import matplotlib.pyplot as plt
    from astropy.modeling import models, fitting
    from astroquery.vizier import Vizier
    import scipy.optimize
    # Make plots display in notebooks
    #%matplotlib inline 

    y2_err=np.sqrt(y2)
    model_gauss = models.Gaussian1D()
    fitter_gauss = fitting.LevMarLSQFitter()
    best_fit_gauss = fitter_gauss(model_gauss, x2, y2, weights=1/y2_err**2)
    return(best_fit_gaus)



def gfit(x,y):
    import numpy as np
    from scipy.optimize import curve_fit
    import matplotlib.pyplot as plt

    parameters, covariance = curve_fit(fit_func, xdata, ydata)
    fitdata = fit_func(xdata, *parameters)
    return(fitdata)


def fit_func(x, a0, a1, a2, a3, a4, a5):
    z = (x - a1) / a2
    y = a0 * np.exp(-z**2 / a2) + a3 + a4 * x + a5 * x**2
    return y





#from example_01 import plotdet


