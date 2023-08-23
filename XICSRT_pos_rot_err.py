## XICSRT crystal position and rotation error

import xicsrt
import numpy as np
from XICSRT_postanalysis import analysis
from analysis import run_analysis
import pathlib
import os

## Config
file = 'si533_si422'  # Config to load
here = os.path.realpath(pathlib.Path().resolve())
filename = here + '/DCI_plots/DCI_configs/' + file + '.hdf5'  # Load hdf5 config file

## Args
args = np.arange(-0.000005, 0.000005, 0.000001)  # Distance in meters

for j in range(0, 3):

    line = np.zeros(len(args))
    mk = ''

    for i in range(0, len(args)):
        import xicsrt
        import matplotlib.pyplot as plt  

        config = xicsrt.xicsrt_io.load_config(filename = filename)
        config['general']['number_of_runs'] = 1
        config['general']['number_of_iter'] = 5
        config['sources']['source']['intensity'] = 1e6
        
        origin = config['optics']['crystal']['origin']
        zaxis = config['optics']['crystal']['zaxis'] 

        if j == 0:
            origin[0] = origin[0] + args[i] # Translation in x-axis
            mk = 'b:o'
        elif j == 1:
            origin[1] = origin[1] + args[i] # Translation in y-axis
            mk = 'r:o'
        else:
            origin[2] = origin[2] + args[i] # Translation in z-axis
            mk = 'g:o'

        config['optics']['crystal']['origin'] = origin
        
        ## XICSRT
        results = xicsrt.raytrace(config)

        ## Results
        detImage = results['total']['image']['detector']
        xsum=np.sum(detImage, axis = 0)
        phdet=np.sum(xsum)

        line[i] = phdet

    plt.plot(args, line, mk)


plt.show()
 