## XICSRT crystal position and rotation error

import xicsrt
import numpy as np
from XICSRT_postanalysis import analysis
from analysis import run_analysis
import pathlib
import os

## Config
file = 'si533_HOPG'  # Config to load
here = os.path.realpath(pathlib.Path().resolve())
filename = here + '/DCI_plots/DCI_configs/' + file + '.hdf5'  # Load hdf5 config file

## Args
# args = np.arange(-0.00005, 0.00005, 0.00001)  # Distance in meters
args = [-0.00005, -0.00004, -0.00003, -0.00002, -0.00001, 0.0, 0.00001, 0.00002, 0.00003, 0.00004, 0.00005]  # Distance in meters
## Which crystal to translate
# crys = 'crystal'
crys = 'crystal2'

for j in range(0, 3):

    line = np.zeros(len(args))
    mk = ''
    dir = ''

    for i in range(0, len(args)):
        import xicsrt
        import matplotlib.pyplot as plt  

        config = xicsrt.xicsrt_io.load_config(filename = filename)
        config['general']['number_of_runs'] = 1
        config['general']['number_of_iter'] = 1
        config['sources']['source']['intensity'] = 1e6
        
        origin = config['optics'][crys]['origin']
        zaxis = config['optics'][crys]['zaxis'] 

        if j == 0:
            origin[0] = origin[0] + args[i] # Translation in x-axis
            mk = 'b:o'
            dir = 'x'
        elif j == 1:
            origin[1] = origin[1] + args[i] # Translation in y-axis
            mk = 'r:o'
            dir = 'y'
        else:
            origin[2] = origin[2] + args[i] # Translation in z-axis
            mk = 'g:o'
            dir = 'z'

        config['optics'][crys]['origin'] = origin     # new crystal position
        
        ## XICSRT
        results = xicsrt.raytrace(config)

        ## Results
        detImage = results['total']['image']['detector']
        xsum=np.sum(detImage, axis = 0)
        phdet=np.sum(xsum)

        line[i] = phdet
    
    plt.plot(args, line, mk, label = dir + '-translation')
    plt.legend(loc='upper left')

plt.show()
 