## Different DCI Crystal Configurations

import sys
import os
import pathlib
import numpy as np
import xicsrt
from scipy.interpolate import UnivariateSpline

xicsrt.warn_version('0.8')


here = os.path.realpath(pathlib.Path().resolve())


""" (Lu) Concave Si-533, Convex Si-422, Alpha = -10 deg, Mag~2.53 """
# region  

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.4764
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, -1.1369e-16,  1.4953]
config['optics']['crystal']['zaxis']  = [0.0,  0.45327   , -0.89137]
config['optics']['crystal']['xsize']  = 0.075
config['optics']['crystal']['ysize']  = 0.025
#config['optics']['crystal']['zsize']  = z
config['optics']['crystal']['radius'] = 0.823
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.82817
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0,  0.32371 , 1.2593]
config['optics']['crystal2']['zaxis']  = [0.0, -0.098655, 0.99512]
config['optics']['crystal2']['xsize']  = 0.045
config['optics']['crystal2']['ysize']  = 0.015
#config['optics']['crystal2']['zsize']  = z
config['optics']['crystal2']['radius'] = 0.50005
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.1085
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 45.0e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  0.95101,  1.9419]
config['optics']['detector']['zaxis']  = [0.0, -0.67667, -0.73628]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='Lu_si533_si422.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)




""" Concave Si-533, Convex Si-422, Alpha = 0 deg, Mag~21 """
# region  

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0,  0.0,          1.0484953]
config['optics']['crystal']['zaxis']  = [0.0,  0.36739660,  -0.93006437]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
#config['optics']['crystal']['zsize']  = z
config['optics']['crystal']['radius'] = 0.82300000
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.82822287
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0,  0.32345771, 0.70296524]
config['optics']['crystal2']['zaxis']  = [0.0, 0.050162207, 0.99874108]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
#config['optics']['crystal2']['zsize']  = z
config['optics']['crystal2']['radius'] = 0.42044225
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.1086024
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 45.0e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  6.7198918,   6.2906278]
config['optics']['detector']['zaxis']  = [0.0, -0.75311426, -0.65788974]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='si533_si422.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)



"""Concave 60deg and Convex 30deg pair, Alpha = 0 deg, Mag~1 """
# region  

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0,  0.0, 1.4255]
config['optics']['crystal']['zaxis']  = [0.0,  0.5, -0.86603]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
#config['optics']['crystal']['zsize']  = z
config['optics']['crystal']['radius'] = 0.823
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.86603
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 10e-5     # 28.0e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.4115, 1.1879]
config['optics']['crystal2']['zaxis']  = [0.0, 0.0     , 1]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
#config['optics']['crystal2']['zsize']  = z
config['optics']['crystal2']['radius'] = 0.47516
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.5
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 10e-5    # 45.0e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  0.823,    1.4255]
config['optics']['detector']['zaxis']  = [0.0, -0.86603, -0.5]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='double_60deg_30deg.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)




""" Single crystal to replace Concave 60deg and Convex 30deg pair, Alpha = 0 deg, Mag~1 """
# region  

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0.0    ,  0.95032]
config['optics']['crystal']['zaxis']  = [0.0, 0.86603, -0.5]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
#config['optics']['crystal']['zsize']  = z
config['optics']['crystal']['radius'] = 0.4751593
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 1.5
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  0.823  ,  1.4255]
config['optics']['detector']['zaxis']  = [0.0, -0.86603, -0.5]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='single_30deg.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)




""" Concave Si-533, Convex HOPG, Alpha = 30 deg(CW), Mag~1.0 """
# region 

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0,        1.7599]
config['optics']['crystal']['zaxis']  = [0.0, 0.36726, -0.93012]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
config['optics']['crystal']['radius'] = 0.82300000 # meters
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.82817
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6 # 10.196e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
# config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.47425, 1.253]
config['optics']['crystal2']['zaxis']  = [0.0, 0.55381, 0.83264]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
config['optics']['crystal2']['zsize']   = 0.0001
config['optics']['crystal2']['radius'] = 0.31056
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 3.354
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 5000.0e-6 #48.620e-5
#mo_deg=1.0E-9
config['optics']['crystal2']['mosaic_spread'] = np.radians(0.2)
config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0, 0.55818, 1.2219]
config['optics']['detector']['zaxis']  = [0.0, 0.93758, -0.34778]
config['optics']['detector']['xsize']  = 0.04
config['optics']['detector']['ysize']  = 0.04
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='-30deg_si533_HOPG.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)



""" Concave Si-533, Convex HOPG, Alpha = 0 deg, Mag~0.816 """
# region 

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0,        1.0483]
config['optics']['crystal']['zaxis']  = [0.0, 0.36726, -0.93012]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
config['optics']['crystal']['radius'] = 0.82300000 # meters
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.82817
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6 # 10.196e-6
#mo_deg=2.0E-6
#config['optics']['crystal']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
# config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.47425, 0.54136]
config['optics']['crystal2']['zaxis']  = [0.0, 0.55381, 0.83264]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
config['optics']['crystal2']['zsize']  = 0.0001
config['optics']['crystal2']['radius'] = 0.31056
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 3.354
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 5000.0e-6 #48.620e-5
#mo_deg=1.0E-9
config['optics']['crystal2']['mosaic_spread'] = np.radians(0.2)
config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0, 0.549,    0.51363]
config['optics']['detector']['zaxis']  = [0.0, 0.93758, -0.34778]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='si533_HOPG.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)



""" Concave 4th Order HOPG, Convex Si-422, Alpha = 0 deg, Mag~21 """
# region 

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
# config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0,          1.2156]
config['optics']['crystal']['zaxis']  = [0.0, 0.39504,   -0.91867]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
# config['optics']['crystal']['zsize']  = 0.0001
config['optics']['crystal']['radius'] = 0.9102
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.8385
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 3600.0e-6 # 9.8054e-3
#mo_deg=2.0E-6
config['optics']['crystal']['mosaic_spread'] = np.radians(0.2)
config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.35472,    0.87936]
config['optics']['crystal2']['zaxis']  = [0.0, -0.0096757, 0.99995]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
config['optics']['crystal2']['radius'] = 0.500
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.1085
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 45.0e-5 # 13.404e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  7.5751,   7.9927]
config['optics']['detector']['zaxis']  = [0.0, -0.71237, -0.70181]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='4thHOPG_si422.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)


""" Concave 4th Order HOPG, Convex Si-422, Alpha = 64 deg, Mag~0.4 """
# region 

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
# config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0,        0.72305]
config['optics']['crystal']['zaxis']  = [0.0, 0.39504, -0.91867]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
# config['optics']['crystal']['zsize']  = 0.0001
config['optics']['crystal']['radius'] = 0.9102
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.8385
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 3600.0e-6 # 9.8054e-3
#mo_deg=2.0E-6
config['optics']['crystal']['mosaic_spread'] = np.radians(0.2)
config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.35472,    0.38686]
config['optics']['crystal2']['zaxis']  = [0.0, -0.0096761, 0.99995]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
config['optics']['crystal2']['radius'] = 0.500
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.1085
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 45.0e-5 # 13.404e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  0.73822,  0.76467]
config['optics']['detector']['zaxis']  = [0.0, -0.71237, -0.70181]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='64deg_4thHOPG_si422.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)



""" Concave Si-533, Convex alpha-Quartz-2023, Alpha = 0 deg, Mag~1.96 """
# region 

# 1.
config = dict()


# 2.
config['general'] = {}
config['general']['number_of_iter'] = 5
config['general']['save_images'] = False


# 3.
config['sources'] = {}
config['sources']['source'] = {}
config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
config['sources']['source']['intensity'] = 1e7
config['sources']['source']['wavelength'] = 1.5406
config['sources']['source']['spread'] = np.radians(6.0)
config['sources']['source']['xsize'] = 0.00
config['sources']['source']['ysize'] = 0.00
config['sources']['source']['zsize'] = 0.00


# 4.Concave crystal
config['optics'] = {}
config['optics']['crystal'] = {}
config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalCrystal'
# config['optics']['crystal']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal']['check_size'] = True
config['optics']['crystal']['origin'] = [0.0, 0,          0.57317]
config['optics']['crystal']['zaxis']  = [0.0, 0.36726,   -0.93012]
config['optics']['crystal']['xsize']  = 0.02
config['optics']['crystal']['ysize']  = 0.02
config['optics']['crystal']['zsize']  = 0.0001
config['optics']['crystal']['radius'] = 0.45
config['optics']['crystal']['convex'] = False

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal']['crystal_spacing'] = 0.82817
config['optics']['crystal']['rocking_type'] = 'gaussian'
config['optics']['crystal']['rocking_fwhm'] = 28.0e-6 # 9.8054e-3
#mo_deg=2.0E-6
# config['optics']['crystal']['mosaic_spread'] = np.radians(0.2)
# config['optics']['crystal']['mosaic_depth'] = 15


# 5. Convex crystal
#config['optics'] = {}
config['optics']['crystal2'] = {}
config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalCrystal'
#config['optics']['crystal2']['class_name'] = 'XicsrtOpticSphericalMosaicCrystal'
config['optics']['crystal2']['check_size'] = True
config['optics']['crystal2']['origin'] = [0.0, 0.20955, 0.34919]
config['optics']['crystal2']['zaxis']  = [0.0, 0.22191, 0.97507]
config['optics']['crystal2']['xsize']  = 0.02
config['optics']['crystal2']['ysize']  = 0.02
config['optics']['crystal2']['radius'] = 0.19955
config['optics']['crystal2']['convex'] = True

# Rocking curve FWHM in radians.
# This is taken from x0h
config['optics']['crystal2']['crystal_spacing'] = 1.3745
config['optics']['crystal2']['rocking_type'] = 'gaussian'
config['optics']['crystal2']['rocking_fwhm'] = 27.7e-6 # 13.404e-6
#mo_deg=1.0E-9
#config['optics']['crystal2']['mosaic_spread'] = np.radians(mo_deg)
#config['optics']['crystal2']['mosaic_depth'] = 15


# 6.
config['optics']['detector'] = {}
config['optics']['detector']['class_name'] = 'XicsrtOpticDetector'
config['optics']['detector']['origin'] = [0.0,  0.48982, 0.45826]
config['optics']['detector']['zaxis']  = [0.0, -0.93192, -0.36266]
config['optics']['detector']['xsize']  = 0.004
config['optics']['detector']['ysize']  = 0.004
config['optics']['detector']['pixel_size']  = 0.00005
# endregion
# 7.
xicsrt.xicsrt_io.save_config(config, filename='si533_aqz2023.hdf5', path= here + '/DCI_plots/DCI_configs', overwrite=True)
