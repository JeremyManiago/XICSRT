## XICSRT post-analysis
#  Use xicsrt.xicsrt_io.load_results(filename='',path='') to load hdf5 file

def analysis(file, Mag):
    import sys
    import os
    import pathlib
    import numpy as np
    import xicsrt
    import matplotlib.pyplot as plt
    import scipy
    from scipy.interpolate import UnivariateSpline
    import pylab as pl
    from scipy.signal import chirp, find_peaks, peak_widths
    xicsrt.warn_version('0.8')

    here = os.path.realpath(pathlib.Path().resolve())

    #print(results)

    results = xicsrt.xicsrt_io.load_results(filename='results_' + file + '.hdf5', path = here + "/DCI_plots/DCI_results")


    sys.stdout = sys.stdout
    # original_stdout = sys.stdout # Save a reference to the original standard output
    # f = open('C:/Users/mania/Desktop/PPPL/XICRST Ray Tracing/Relating to Research/DCI_plots/DCI_results/info_' + file +'.txt', 'w') # open txt file
    # sys.stdout = f # Change the standard output to the file we created.


    # import xicsrt.visual.xicsrt_3d__plotly as xicsrt_3d
    # fig = xicsrt_3d.figure()
    # xicsrt_3d.add_rays(results)
    # xicsrt_3d.add_optics(results['config'])
    # xicsrt_3d.add_sources(results['config'])
    # xicsrt_3d.show()

    # import xicsrt.visual.xicsrt_2d__matplotlib as xicsrt_2d
    # xicsrt_2d.plot_intersect(results, 'crystal')

    print(results.keys())

    found=results['found']['history']['detector']
    print(found.keys())

    try:
        found2=results['found']['history']['crystal2']
        print(found2.keys())
    except:
        pass


    intensity=results['config']['sources']['source']['intensity']
    dw1=results['config']['optics']['crystal']['rocking_fwhm']
    print('dw1=',dw1)

    try:
        dw2=results['config']['optics']['crystal2']['rocking_fwhm']
        print('dw2=',dw2)
    except:
        pass
    
    


    plt.rcParams['text.usetex'] = False
    plt.rcParams["figure.figsize"] = [7.5, 3.5]
    plt.rcParams["figure.autolayout"] = True
    fig, ax = plt.subplots(2, 2, figsize=(8, 8), sharey=False)	# 2 rows, 2 columns, index [0,0] (row, column)
    fig1 = plt.gcf()

    cmaps = 'viridis'

    # var = str(args)
    # plt.suptitle(var)



    def plotdet(results):
        detImage = results['total']['image']['detector']
        pixsize = (1.0e6)*results['config']['optics']['detector']['pixel_size']
        print('Detector pixsize = ' + str(pixsize))
        try:
            c_pixsize = (1.0e6)*results['config']['optics']['crystal']['pixel_size']
        except:
            c_pixsize = 2000
            pass
        print('Concave Crystal pixsize = ' + str(c_pixsize))

        crystalImage = results['total']['image']['crystal']
        try:
            crystal2Image = results['total']['image']['crystal2']
        except:
            pass

        # get size of detector
        ny, nx = np.shape(detImage)
        # make pixel arrays
        xs = np.arange(nx)*pixsize
        ys = np.arange(ny)*pixsize
        xM, yM = np.meshgrid(xs, ys)

        # get size of crystal(s) 
        ncy, ncx = np.shape(crystalImage)
        # make pixel arrays
        xcs = np.arange(ncx)*c_pixsize
        ycs = np.arange(ncy)*c_pixsize
        xcM, ycM = np.meshgrid(xcs, ycs)

        # plt.contourf(xM, yM, detImage)
        # plt.show()
        plt.figure(2, figsize=(8, 8))
        plt.contourf(xM, yM, detImage, 7, cmap=cmaps)
        plt.title('Detector')
        plt.xlabel('Distance $(\mu m)$')
        plt.ylabel('Distance $(\mu m)$')
        plt.savefig(here + '/DCI_plots/DCI_futurework/det_plot_' + file + '.png', dpi = 1200)


        cxsum=np.sum(crystalImage,axis=0)
        cysum=np.sum(crystalImage,axis=1)

        phc=np.sum(cxsum)
        cphc=str(phc)
        intensity=results['config']['sources']['source']['intensity']
        iter=results['config']['general']['number_of_iter']
        intensity=intensity*iter
        c_cint=str(intensity*1.0E-7)[0:5]
        c_efc = np.round(phc/intensity * 100, 3)
        c_efc = str(c_efc)[0:6]

        plt.figure(3, figsize=(8, 8))
        plt.contourf(xcM, ycM, crystalImage, 7, cmap=cmaps)
        plt.title('Concave Crystal: Efficiency = ' + c_efc + '% ' + 
                  '\n Photons = ' + c_cint + 'E7, Photons on concave crystal = ' + cphc +
                  '\n Crystal pixsize = ' + str(c_pixsize)[0:5] + ' $(\mu m)$')
        plt.xlabel('Distance $(\mu m)$')
        plt.ylabel('Distance $(\mu m)$')
        plt.savefig(here + '/DCI_plots/DCI_futurework/concavecrystal_plot_' + file + '.png', dpi = 1200)

        try:
            c2xsum=np.sum(crystal2Image,axis=0)
            c2ysum=np.sum(crystal2Image,axis=1)

            phc2=np.sum(c2xsum)
            cphc2=str(phc2)
            c2_efc = np.round(phc2/intensity * 100, 3)
            c2_efc = str(c2_efc)[0:6]

            plt.figure(4, figsize=(8, 8))
            plt.contourf(xcM, ycM, crystal2Image, 7, cmap=cmaps)
            plt.title('Convex Crystal: Efficiency = ' + c2_efc + '% ' + 
                    '\n Photons = ' + c_cint + 'E7, Photons on convex crystal = ' + cphc2 +
                    '\n Crystal pixsize = ' + str(c_pixsize)[0:5] + ' $(\mu m)$')
            plt.xlabel('Distance $(\mu m)$')
            plt.ylabel('Distance $(\mu m)$')
            plt.savefig(here + '/DCI_plots/DCI_futurework/convexcrystal_plot_' + file + '.png', dpi = 1200)
        except:
            pass



        plt.figure(1)
        ax[0,0].contourf(xM, yM, detImage, 10, cmap=cmaps)
        ax[0,0].set_xlabel('Distance $(\mu m)$')
        ax[0,0].set_ylabel('Distance $(\mu m)$')






    plotdet(results)


    def plotline(results):

        from my_functions import my_fwhm
        from my_functions import gaussfit
        from my_functions import gaus
        from my_functions import fwhm_spl
        from my_functions import fwhm_spl_2
        from scipy.signal import chirp, find_peaks, peak_widths

        detImage = results['total']['image']['detector']

        # get size of detector
        ny, nx = np.shape(detImage)
        # make pixel arrays
        ixs = np.arange(nx)
        iys = np.arange(ny)

        xsum=np.sum(detImage,axis=0)
        ysum=np.sum(detImage,axis=1)

        phdet=np.sum(xsum)
        print('ph on det=',phdet)
        cphdet=str(phdet)
        #mos_dep=results['config']['optics']['crystal2']['mosaic_depth']
        #cmos_dep=str(mos_dep)[0:6]
        intensity=results['config']['sources']['source']['intensity']
        iter=results['config']['general']['number_of_iter']
        intensity=intensity*iter
        efc = np.round(phdet/intensity * 100, 3)
        efc = str(efc)[0:6]

        xsize_det=1.0e6*results['config']['optics']['detector']['xsize']
        ysize_det=1.0e6*results['config']['optics']['detector']['ysize']
        dxdpix=xsize_det/nx
        dydpix=ysize_det/ny
        xs=dxdpix*ixs
        ys=dydpix*iys

        nrm = 1 # nrm=np.max(xsum)/np.max(ysum)
        # rangex = np.max(xsum) - np.min(xsum)
        # rangey = np.max(ysum) - np.min(ysum)
        # xsum = (xsum-np.min(xsum))/rangex
        # ysum = (ysum-np.min(ysum))/rangey

        ax[1,0].plot(xs, xsum, lw=0.25, label="xsum", marker=".", ms=1)
        ax[1,0].set_xlabel('Distance $(\mu m)$')
        ax[1,0].set_ylabel('Normalized Intensity')
        ax[0,1].plot(nrm*ysum, ys, color='r',lw=0.25, label="ysum", marker=".", ms=1)    
        ax[0,1].invert_xaxis()
        ax[0,1].set_ylabel('Distance $(\mu m)$')
        ax[0,1].set_xlabel('Normalized Intensity')

        nspl=200
        thr=0.5

        try:
            fwhmx,fwhmgx,gfitx,rxmin,rxmax,rymx=my_fwhm(ys,ysum,thr,nspl)
        except:
            pass

        try:
            fwhmy,fwhmgy,gfity,rymin,rymax,rxmx=my_fwhm(xs,xsum,thr,nspl)
        except:
            pass
        
        try:
            fwgx,rxmin,rxmax,rxmx=fwhm_spl_2(ys,gfitx,thr,nspl)
        except:
            pass

        try:
            fwgy,rymin,rymax,rymx=fwhm_spl_2(xs,gfity,thr,nspl)
        except:
            pass

        try:
            print('fwhms of gaus fits x,y=',fwgx,fwgy)
        except:
            pass

        try:
            cfwgx=str(fwgx)[0:5]
        except:
            cfwgx= '?'
            pass

        try:
            cfwgy=str(fwgy)[0:5]
        except:
            cfwgy= '?'
            pass

        ixmx=np.argmax(ysum)
        iymx=np.argmax(xsum)
        print(ixmx,iymx)

        xmn=np.min(xs)
        xmx=np.max(xs)
        nf=10000
        xf=np.linspace(xmn,xmx,nf)
        dx=xmx-xmn
        xf1=xf*dx/nf

        spl=UnivariateSpline(xs,xsum)
        yf=spl(xf)

        ymx=np.max(yf)
        diff=yf-ymx/2

        iroots=np.where(np.diff(np.sign(np.array(diff))))[0]
        roots=xf[iroots]
        print(roots)
        rmax=max(roots)
        rmin=min(roots)
        dr=rmax-rmin
        #dr=roots[1]-roots[0]
        fwhm=dr
        print('fwhm=',fwhm)

        try:
            print('fwhmgx=',fwhmgx)
        except:
            pass

        try:
            print('fwhmgy=',fwhmgy)
        except: 
            pass

        try:
            cfwhm=str(fwhm)[0:5]
        except:
            cfwhm='?'
            pass

        try:
            cfwhmx=str(fwhmx)[0:5]
        except:
            cfwhmx='?'
            pass


        #Diffraction widths & other params
        dw1=1.0E6*results['config']['optics']['crystal']['rocking_fwhm']
        # dw2=1.0E6*results['config']['optics']['crystal2']['rocking_fwhm']
        pixsize=1.0E6*results['config']['optics']['detector']['pixel_size']
        #mos_sprd=57.3*results['config']['optics']['crystal2']['mosaic_spread']
        #cmos_sprd=str(mos_sprd)[0:7]
        sdiv=(180/np.pi)*results['config']['sources']['source']['spread']
        serr = sdiv/np.sqrt(phdet)
        csdiv=str(sdiv)[0:4]
        cserr=str(serr)[0:4]

        print('intensity=',intensity)
        print('Efficiency = ' + efc + '%')
        cint=str(intensity*1.0E-7)[0:5]
        print(cint)
        print('dw1=',dw1)
        # print('dw2=',dw2)
        # dws='dw1 '+str(dw1)[0:5] + ' ' + 'dw2 ' + str(dw2)[0:5]


        nrm=np.max(xsum)/np.max(ysum)

        
        try:
            ax[1,0].plot(ys, gfity, color='m', lw=0.75, label="xfit")
            ax[1,0].plot([rymin, rymax], [rymx/2, rymx/2], color='r', lw=0.75, label="xfwhm")
            # ax[1,0].plot(xf, yf, color='g', lw=0.25, label="xy fit")

            xspat_res = fwgy/Mag
            xsr = str(xspat_res)[0:5]
        except:
            xsr = '?'
            pass

        try:
            ax[0,1].plot(nrm*gfitx, xs, color='c', lw=0.75, label="yfit")
            ax[0,1].plot([rxmx/2, rxmx/2], [rxmin, rxmax], color='r', lw=0.75, label="yfwhm")
            # ax[0,1].plot(yf, xf, color='g', lw=0.25, label="xy fit")

            yspat_res = fwgx/Mag
            ysr = str(yspat_res)[0:5]
        except:
            ysr = '?'
            pass

        fig1.text(0.75, 0.265, 
                'Magnification = ' + str(Mag) + 
                '\npixsize = ' + str(pixsize)[0:5] + 
                '\n Efficiency = ' + efc + '%' + 
                '\n fwhm = ' + cfwhm + 
                '\n fwhm x,y = ' + cfwgy + ', ' + cfwgx + 
                '\n ph = ' + cint + 'E7, phd = '+cphdet + 
                '\n sdiv = ' + csdiv + ' serr = ' + cserr + 
                '\n Spa-Res x,y = ' + xsr + ', ' + ysr, 
                ha='center', va='center', 
                fontsize=16, linespacing=2, family='Latin Modern Roman',
                bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.5))
                # , usetex=True
        fig1.text(0.75, 0.065, 
                r'($ \mu m $)', 
                ha='center', va='center', 
                fontsize=16, linespacing=2, 
                usetex=True)
        #pl.ylabel('modeg ' + str(mo_deg) +'  ' +dws+' modep '+cmos_dep)
        #ax[0,0].set_title('pixsize '+str(pixsize)[0:5]) #+ ' mo_sprd ' + cmos_sprd+'E-3')
        ax[1,1].axis("off")
        ax[1,0].legend(loc='upper left')
        ax[0,1].legend(loc='upper left')
        
        # ax[0,0].set_xlim(1500, 2500)
        # ax[0,0].set_ylim(1500, 2500)
        # ax[1,0].set_xlim(1500, 2500)
        # ax[0,1].set_ylim(1500, 2500)
        fig1.suptitle(file)
        fig1.tight_layout()
        
        # plt.plot(xf,diff)
        # plt.show()


    plotline(results)
    fig1.tight_layout()
    fig1.savefig(here + '/DCI_plots/DCI_futurework/plots_' + file + '.png', dpi = 1200)
    # plt.show(block=True)
    fig1.clf()

    # sys.stdout = original_stdout # Reset the standard output to its original value
    # f.close() # close txt file


    return here + '/DCI_plots/DCI_futurework/plots_' + file + '.png'