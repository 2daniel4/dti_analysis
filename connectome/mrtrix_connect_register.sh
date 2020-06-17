#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=2

set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)
setenv FREESURFER_HOME /data/bswift-0/software/freesurfer-dev/
source /data/bswift-0/software/freesurfer-dev/SetUpFreeSurfer.csh

#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /data/bswift-1/dcallow/CONNECTOME/anat/freesurfer
module load fsl
@ linenum = 1

set echo
set subj= ($argv[1]) \


# Dicom to Nifti file

cd /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion

# register b0 to anatomical image
bbregister --s ${subj} --mov /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion/nodif_brain_mask.nii.gz  --reg register.dat --t2

# Take anatomical ROI's into diffusion space by using reverse registration just created (Can do hippocampus and cortical ROIs)
mri_vol2vol --mov nodif_brain_mask.nii.gz --targ /data/bswift-1/dcallow/CONNECTOME/anat/freesurfer/${subj}/mri/lh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace.mgz --inv --interp nearest --o lhipp2diff.nii.gz --reg register.dat --no-save-reg
mri_vol2vol --mov nodif_brain_mask.nii.gz --targ /data/bswift-1/dcallow/CONNECTOME/anat/freesurfer/${subj}/mri/rh.hippoAmygLabels-T1.v21.HBT.FSvoxelSpace.mgz --inv --interp nearest --o rhipp2diff.nii.gz --reg register.dat --no-save-reg
mri_vol2vol --mov nodif_brain_mask.nii.gz --targ /data/bswift-1/dcallow/CONNECTOME/anat/freesurfer/${subj}/mri/ribbon.mgz --inv --interp nearest --o ribbon.nii.gz --reg register.dat --no-save-reg

# Extract ROI's
# Create threshold for CSF volume fraction above 50%
# Clean ROI of CSF
mri_binarize --i ribbon.nii.gz --match 3 42 --o cortex.nii.gz
mrthreshold FIT_ISOVF.nii.gz too_much_ISO.nii.gz -abs 0.5
mrthreshold FA.nii.gz too_much_ICVF.nii.gz -abs .3
#fslmaths FIT_ICVF.nii.gz -uthr .985 FIT_ICVF_thr.nii.gz
mrcalc -force too_much_ISO.nii.gz 0 cortex.nii.gz -if cleaned_cortex.nii.gz
mrcalc -force too_much_ICVF.nii.gz 0 cortex.nii.gz -if cleaned_cortex.nii.gz

mri_binarize --i lhipp2diff.nii.gz --match 226 231 232 --o full_lhipp.nii.gz
mrcalc -force too_much_ISO.nii.gz 0 full_lhipp.nii.gz -if cleaned_full_lhipp.nii.gz
mrcalc -force too_much_ICVF.nii.gz 0 cleaned_full_lhipp.nii.gz -if cleaned_full_lhipp.nii.gz

mri_binarize --i rhipp2diff.nii.gz --match 226 231 232 --o full_rhipp.nii.gz
mrcalc -force too_much_ISO.nii.gz 0 full_rhipp.nii.gz -if cleaned_full_rhipp.nii.gz
mrcalc -force too_much_ICVF.nii.gz 0 cleaned_full_rhipp.nii.gz -if cleaned_full_rhipp.nii.gz

fslmaths cleaned_full_lhipp.nii.gz -add cleaned_full_rhipp.nii.gz cleaned_full_bhipp.nii.gz
fslmaths cleaned_l_head_hipp.nii.gz -add cleaned_r_head_hipp.nii.gz cleaned_bhipp_head2diff.nii.gz
fslmaths cleaned_l_post_hipp.nii.gz -add cleaned_r_post_hipp.nii.gz cleaned_bhipp_post2diff.nii.gz

mri_binarize --i lhipp2diff.nii.gz --match 226 231 232 --o full_lhipp.nii.gz
mrcalc -force too_much_ISO.nii.gz 0 full_lhipp.nii.gz -if cleaned_full_lhipp.nii.gz
mrcalc -force too_much_ICVF.nii.gz 0 cleaned_full_lhipp.nii.gz -if cleaned_full_lhipp.nii.gz
