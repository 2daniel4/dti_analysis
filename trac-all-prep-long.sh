#!/bin/tcsh

setenv FREESURFER_HOME /Applications/freesurfer/
source $FREESURFER_HOME/SetUpFreeSurfer.csh
#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/diffusion_recons/
#set path to configuration file
setenv config /Volumes/DANIEL/
@ linenum = 1

#Make sure to create directories for trac-all (Should be indexing into folders with recon-all and dti dicoms) that are specified in config file

#Run trac-all -prep version which includes, eddy and b0 corrrection and registration to anat.
#Calls on configuration file

#trac-all -prep -jobs file -c ${config}/dmrirc.long.example.sh to create jobs files
trac-all -prep -c ${config}/dmrirc.long.example.sh
