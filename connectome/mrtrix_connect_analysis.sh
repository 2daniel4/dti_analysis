#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=4

set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)

#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /data/bswift-1/dcallow

@ linenum = 1

set subj= ($argv[1]) \

# Calculate white, gray and CSF images

cd ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion
dwi2fod -force msmt_csd dwi.mif ${LOCATION_avg_response_wm}/average_response_wm.txt wmfod.mif ${location_avg_response_gm}/average_response_gm.txt gm.mif ${location_avg_response_csf}/average_response_csf.txt csf.mif

# Normalize accross subjects
mtnormalise -force wmfod.mif wmfod_norm.mif gm.mif gm_norm.mif csf.mif csf_norm.mif -mask nodif_brain_mask.nii$

# Create image easy to visualize (decfod)
fod2dec -force wmfod_norm.mif decfod.mif -mask nodif_brain_mask.nii.gz

# Create images with percentage of wm, gm and csf signal at each voxel.
mrconvert -force wmfod_norm.mif wm_norm.mif -coord 3 0
mrcalc -force wm_norm.mif gm_norm.mif csf_norm.mif -add -add sum_norm.mif
mrcalc -force nodif_brain_mask.nii.gz wm_norm.mif sum_norm.mif -divide 0 -if TW.nii.gz
mrcalc -force nodif_brain_mask.nii.gz gm_norm.mif sum_norm.mif -divide 0 -if TG.nii.gz
mrcalc -force nodif_brain_mask.nii.gz csf_norm.mif sum_norm.mif -divide 0 -if TC.nii.gz

# Create MD and FA images
dwi2tensor -force dwi.mif tensor.mif
tensor2metric -force -fa FA.nii.gz tensor.mif
tensor2metric -force -adc MD.nii.gz tensor.mif
