# PLR_RGC_analysis

This repository contains all the code used for analyzing the data and generating the plots present in the manuscript with title: 
"Pupil-induced retinal binocularity potentiates low-contrast vision". 

Each folder contains the code used for a specific experiment or type of analysis described in the manuscript.\


# Requirements
-  Matlab R2021b

# Demo
The demo folder contains example scripts for analyzing the RGCs respoonses to a full-field flash stimulation. To generate the plots:
-  Download example data from [here](https://console.cloud.google.com/storage/browser/plr-rgc-data) . The file contains pre-processed neural data from a single recording session.
-  Run AnalyzeOneContrast. Be sure to change DATASET_PATH to point to the folder where you downloaed the data.
-  Run PlotOneContrast to generate the plots.

Additionally, PlotExampleROI wil ll plot trial-averaged response of a single RGC, as present in Fig.2 of the manuscript.


