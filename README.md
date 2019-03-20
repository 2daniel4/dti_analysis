# dti_analysis
# These scripts allow for creation of FA and other diffusivity images from DICOMs
# They also can be used to create subject specific subcortical segmentations based on anatomical T1 images for use in ROI analysis 
# This is so you don't have to warp all subjects to standard space and can infer more about location of effects.
# Many of the subcortical segmentation codes from freesurfer can take a LONG time to run
# Therefore I have included the ability to paralize and submit multiple subjects at once to a supercomputer if you have access to one.
# The job submission is scripted in SLURM.
