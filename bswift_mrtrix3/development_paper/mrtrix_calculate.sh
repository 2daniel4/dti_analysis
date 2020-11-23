#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=6

# The above is required any time you are submitting to SLURM (job management software) on bswift. 
# Line 1 indicates we are using tcsh and the -f indicates we will be supplying arguments (subject ID's)
# Line 2 - maximum amount of time allocated
# Line 3 - memory requested
# Line 4 - name of file with command output
# Line 5 - the number of cores/nodes requested

# Set paths to mrtrix and ANTS software.
set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)

#Set subjects directory (Where you will access stored data)
setenv SUBJECTS_DIR /data/bswift-1/dcallow

# Echo commands/output
set echo
# sets the variable ${subj} equal to the input value we provide (see the above note about the -f in shebang)
set subj= ($argv[1]) \

# Go to dwi folder (will do all processing here)
cd SUBJECTS_DIR/${subj}/dwi

# Calculate FOD (white matter), gray matter, and CSF image from mean response
ss3t_csd_beta1 dwi_corrected_upsampled.mif ${SUBJECTS_DIR}/response/csf/average_response_wm.txt wmfod.mif ${SUBJECTS_DIR}/response/csf/average_response_gm.txt gm.mif ${SUBJECTS_DIR}/response/csf/average_response_csf.txt csf.mif -mask dwi_mask_upsampled.mif

# Normalize the images

# NOTE: This performs global intensity normalisation as well, making sure that amplitudes can be better (more predictably) relied upon for further processing steps.
# For group studies, when 3-tissue CSD is performed using a single unique set of 3-tissue response functions, the mtnormalise step makes the absolute amplitudes directly comparable between all subjects. As such, this step becomes absolutely crucial, even if bias field correction was already applied earlier in the pipeline using dwibiascorrect ants; as dwibiascorrect ants does not perform global intensity normalisation.
mtnormalise -force wmfod.mif wmfod_norm.mif gm.mif gm_norm.mif csf.mif csf_norm.mif -mask dwi_mask_upsampled.mif

# Create normalized WM, GM, and CSF images. This indicates the percentage of diffusion signal from different tissue types within each voxel (Useful for Partial volume correction or CSF/free water contamination correction)
mrconvert -force wmfod_norm.mif wm_norm.mif -coord 3 0
mrcalc -force wm_norm.mif gm_norm.mif csf_norm.mif -add -add sum_norm.mif                                               
mrcalc -force dwi_mask_upsampled.mif wm_norm.mif sum_norm.mif -divide 0 -if TW.nii.gz                                  
mrcalc -force dwi_mask_upsampled.mif gm_norm.mif sum_norm.mif -divide 0 -if TG.nii.gz
mrcalc -force dwi_mask_upsampled.mif csf_norm.mif sum_norm.mif -divide 0 -if TC.nii.gz
