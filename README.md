#Must have freesurfer and fsl downloaded!

# Tractography analysis
# Also useful pipeline for preping dti data.

#Current trac-all points to an epidewarp.fsl function that only allows for fsl version 5.x or earlier. 
#Must add an else statement in epidewarp.fsl function that allows for fsl version 6.x and must make all other code including trac-preproc and trac-all point to it.

#Converts dicoms into dti

#Eddy current corrects dti

#B0 inhomogeneity corrects dti

##egisters dti to anat
