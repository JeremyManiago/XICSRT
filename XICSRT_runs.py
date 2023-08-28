## XICSRT runs

import xicsrt
import numpy as np
from XICSRT_postanalysis import analysis
from analysis import run_analysis
import pathlib
import os

## Config
here = os.path.realpath(pathlib.Path().resolve())

def lcon(file, args, Mag):

    # for i in len(args):
    config = xicsrt.xicsrt_io.load_config(filename = here + '/DCI_plots/DCI_configs/' + file + '.hdf5')
    
    config['general']['number_of_runs'] = 1
    config['general']['number_of_iter'] = 5

    # config['sources']['source']['class_name'] = 'XicsrtSourceFocused'
    config['sources']['source']['class_name'] = 'XicsrtSourceDirected'
    config['sources']['source']['intensity'] = 1e7
    # config['sources']['source']['wavelength'] = 1.5406
    # config['sources']['source']['target'] = [0.0, 0,        1.0483]
    config['sources']['source']['spread'] = np.radians(6.0)

    # config['sources']['source']['xsize'] = 0.0000084
    # config['sources']['source']['ysize'] = 0.0000084
    # config['sources']['source']['zsize'] = 0.0005

    # config['optics']['crystal']['zsize']  = 0.0001
    # config['optics']['crystal2']['zsize']  = 0.0001
    config['optics']['crystal']['pixel_size']  = 0.00005
    config['optics']['crystal2']['pixel_size']  = 0.00005

    config['optics']['detector']['xsize']  = 0.0004
    config['optics']['detector']['ysize']  = 0.0004
    config['optics']['detector']['pixel_size']  = 0.000005 # 0.000005 
    
    
    ## XICSRT
    # results = xicsrt.raytrace_mp(config,processes=5)
    
    # results = xicsrt.raytrace(config)
    # xicsrt.xicsrt_io.save_results(results, filename = 'results_' + file + '.hdf5', path = here + '/DCI_plots/DCI_results', overwrite=True)

    run_analysis(file, args, Mag)
    ## Post Analysis
    # png = analysis(file, Mag)
    # return png

args = ''
# args = [-2, -1, 0, 1, 2]
args = str(args)

 
# file = 'Lu_si533_si422'
# Mag = 2.53
# png = lcon(file, args, Mag)

file = 'si533_si422'
Mag = 21.30
png = lcon(file, args, Mag)

# file = 'double_60deg_30deg'
# Mag = 1
# png = lcon(file, args, Mag)

# file = 'single_30deg'
# Mag = 1
# png = lcon(file, args, Mag)

# file = 'si533_HOPG'
# Mag = 0.8164
# png = lcon(file, args, Mag)

# file = '10deg_si533_HOPG'
# Mag = 0.75
# png = lcon(file, args, Mag)

# file = '-30deg_si533_HOPG'
# Mag = 1.0
# png = lcon(file, args, Mag)

# file = '-35deg_si533_HOPG'
# Mag = 1.0
# png = lcon(file, args, Mag)

# file = '4thHOPG_si422'
# Mag = 20.07
# png = lcon(file, args, Mag)

# file = '64deg_4thHOPG_si422'
# Mag = 0.3972
# png = lcon(file, args, Mag)


# file = 'si533_aqz2023'
# Mag = 1.96
# png = lcon(file, args, Mag)





## Open folder with configs, results, and plots
import os
folder = here + "/DCI_plots/DCI_futurework"
folder = os.path.realpath(folder)
os.startfile(folder) 

# path = png
# path = os.path.realpath(path)
# os.startfile(path) 

## Notify that runs are finished
# from notif import notif
# notif() 
