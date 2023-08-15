
def run_analysis(file, args, Mag):
    import sys
    import numpy as np
    import xicsrt
    import matplotlib.pyplot as plt
    from matplotlib.ticker import (MultipleLocator, AutoMinorLocator)
    import scipy
    from scipy.interpolate import UnivariateSpline
    from scipy.optimize import curve_fit
    import pylab as pl
    from scipy.signal import chirp, find_peaks, peak_widths
    xicsrt.warn_version('0.8')
    import pathlib
    import os


    here = os.path.realpath(pathlib.Path().resolve())
    sys.stdout = sys.stdout

    results = xicsrt.xicsrt_io.load_results(filename = 'results_' + file + '.hdf5', path = here + "/DCI_plots/DCI_results")
    Mag = Mag



    intensity=results['config']['sources']['source']['intensity']

    plt.rcParams['text.usetex'] = False
    plt.rcParams["figure.figsize"] = [7.5, 3.5]
    plt.rcParams["figure.autolayout"] = True
    fig, ax = plt.subplots(2, 2, figsize = (8, 8), sharey = False)	# 2 rows, 2 columns, index [0,0] (row, column)
    fig1 = plt.gcf()

    cmaps = 'viridis'

    detImage = results['total']['image']['detector']
    pixsize = (1.0e6)*results['config']['optics']['detector']['pixel_size']
    print('Detector pixel size = ' + str(pixsize))

    # get size of detector
    ny, nx = np.shape(detImage)
    # make pixel arrays
    xs = np.arange(nx)*pixsize
    ys = np.arange(ny)*pixsize
    xM, yM = np.meshgrid(xs, ys)

    plt.figure(1)
    ax[0,0].contourf(xM, yM, detImage, 10, cmap = cmaps)
    ax[0,0].set_xlabel('Distance $(\mu m)$')
    ax[0,0].set_ylabel('Distance $(\mu m)$')


    xsum=np.sum(detImage, axis = 0)
    ysum=np.sum(detImage, axis = 1)
    phdet=np.sum(xsum)
    print('photons on detector = ', phdet)
    cphdet = str(phdet)
    iter = results['config']['general']['number_of_iter']
    intensity = intensity*iter
    efc = np.round(phdet/intensity * 100, 3)
    efc = str(efc)[0:6]
    sdiv=(180/np.pi)*results['config']['sources']['source']['spread']
    serr = sdiv/np.sqrt(phdet)
    csdiv=str(sdiv)[0:4]
    cserr=str(serr)[0:4]

    print('intensity=',intensity)
    print('Efficiency = ' + efc + '%')
    cint=str(intensity*1.0E-7)[0:5]
    print(cint)


    rangex = np.max(xsum) - np.min(xsum)
    rangey = np.max(ysum) - np.min(ysum)
    xsum = (xsum-np.min(xsum))/rangex
    ysum = (ysum-np.min(ysum))/rangey



    ax[1,0].plot(xs, xsum, color = 'b', lw = 0.25, alpha = 0.9, label = 'xsum', marker = '.', ms = 1)  
    ax[1,0].set_xlabel('Distance $(\mu m)$')
    ax[1,0].set_ylabel('Normalized Intensity')
    ax[1,0].sharex(ax[0,0])

    ax[0,1].plot(ysum, ys, color = 'b', lw = 0.25, alpha = 0.9, label = 'ysum', marker = '.', ms = 1)    
    ax[0,1].invert_xaxis()
    ax[0,1].set_ylabel('Distance $(\mu m)$')
    ax[0,1].set_xlabel('Normalized Intensity')
    ax[0,1].sharey(ax[0,0])


    def Gauss(x, a, x0, sigma):
        import numpy as np

        return a*np.exp(-(x-x0)**2/(2*sigma**2))

    def gaussfit(x,y):
        from scipy.optimize import curve_fit
        import numpy as np
        
        a0 = np.max(y)
        n = len(x)                          # the number of data
        mean = sum(x*y)/sum(y)              # note this correction
        #sigma = sum(y*(x-mean)**2)/sum(y)  # note this correction
        sigma = 0.5
        
        # print('Initial n, a0, mean, sigma = ', n, a0, mean, sigma)
        popt,pcov = curve_fit(Gauss, x, y, p0 = [a0, mean, sigma], maxfev=2000)
        # print('popt = ', popt)
        # print('pcov = ', pcov)

        coefs = popt
        gfit = Gauss(x, coefs[0], coefs[1], coefs[2])
        max = np.max(gfit)

        return(gfit, max)


    #Gaussian fit
    gfitx, xmax = gaussfit(xs, xsum)
    gfity, ymax = gaussfit(ys, ysum)

    ax[1,0].plot(xs, gfitx, lw = 1, color = 'm', label = 'xfit')
    ax[0,1].plot(gfity, ys, lw = 1, color = 'r', label = 'yfit')


    splinex = UnivariateSpline(xs, gfitx - xmax/2, s=0)
    rx1, rx2 = splinex.roots()
    fwhmx = rx2 - rx1

    spliney = UnivariateSpline(ys, gfity - ymax/2, s=0)
    ry1, ry2 = spliney.roots()
    fwhmy = ry2 - ry1


    ax[1,0].plot([rx1, rx2], [xmax/2, xmax/2], color = 'g', label = 'fwhm x = \n' + str(fwhmx)[0:5])
    ax[0,1].plot([ymax/2, ymax/2], [ry1, ry2], color = 'c', label = 'fwhm y = \n' + str(fwhmy)[0:5])



    ax[1,1].axis('off')

    ax[1,0].legend(loc='upper left')
    ax[1,0].xaxis.set_minor_locator(MultipleLocator(nx*pixsize/8))
    ax[1,0].tick_params(which = 'both', direction='in')
    ax[1,0].grid('visible', which = 'both', alpha = 0.25)
    ax[1,0].set_xlim(0,nx*pixsize)

    ax[0,1].legend(loc='upper left')
    ax[0,1].yaxis.tick_right()
    ax[0,1].yaxis.set_label_position('right')
    ax[0,1].yaxis.set_major_locator(MultipleLocator(ny*pixsize/4))
    ax[0,1].yaxis.set_minor_locator(MultipleLocator(ny*pixsize/8))
    ax[0,1].tick_params(which = 'minor', labelright = False)
    ax[0,1].tick_params(which = 'both', direction='in')
    ax[0,1].grid('visible', which = 'both', alpha = 0.25)
    ax[0,1].set_ylim(0,ny*pixsize)

    fig1.suptitle(file)

    xsr = fwhmx/Mag
    ysr = fwhmy/Mag

    fig1.text(0.75, 0.27, 
            'Magnification = ' + str(Mag) + 
            '\npixsize = ' + str(pixsize)[0:5] + 
            '\n Efficiency = ' + efc + '%' +  
            '\n fwhm x,y = ' + str(fwhmx)[0:5] + ', ' + str(fwhmy)[0:5] +  
            '\n ph = ' + cint + 'E7, phd = '+cphdet + 
            '\n sdiv = ' + csdiv + ' serr = ' + cserr + 
            '\n Spa-Res x,y = ' + str(xsr)[0:5] + ', ' + str(ysr)[0:5], 
            ha='center', va='center', 
            fontsize=16, linespacing=2, family='Latin Modern Roman',
            bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))
            # , usetex=True
    fig1.text(0.75, 0.08, 
            r'($ \mu m $)', 
            ha='center', va='center', 
            fontsize=16, linespacing=2, 
            usetex=True)

    plt.tight_layout()
    plt.show()