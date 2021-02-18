#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results_connect
#SBATCH --cores=4


setenv FREESURFER_HOME /data/bswift-0/software/freesurfer-dev/
source /data/bswift-0/software/freesurfer-dev/SetUpFreeSurfer.csh

#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /data/bswift-1/dcallow
source /data/bswift-0/software/loadpython.csh 3.7
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)

@ linenum = 1

set echo
set subj= ($argv[1]) \

#mkdir ${SUBJECTS_DIR}/CONNECTOME
cd ${SUBJECTS_DIR}/CONNECTOME/dwi
#mkdir fod_input
#mkdir mask_input
setenv FSLDIR /data/bswift-0/software/fsl6.0.1
source ${FSLDIR}/etc/fslconf/fsl.csh

# Dicom to Nifti file

cd ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/

# Create an image 5TT.mif with the different tissue type segmentations
5ttgen freesurfer -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/cort_subcort.nii.gz 5TT.mif

# Create vis.mif for visualization purposes
5tt2vis -force 5TT.mif vis.mif

#extract mean bo
mrconvert -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/wmfod.mif - -coord 3 0 | mrcat ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/csf.mif ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/gm.mif - tissueRGB.mif -axis 3

# Take freesurfer subcortical segmentation and convert it into nodes for tractography and connectome analysis 
labelconvert -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/cort_subcort.nii.gz /data/bswift-1/dcallow/CONNECTOME/FreeSurferColorLUT.txt /data/bswift-1/dcallow/CONNECTOME/fs_default.txt nodes.mif


# Perform stractography of 10 Million streamlines using act
tckgen -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/wmfod.mif 10M.tck -act 5TT.mif -backtrack -crop_at_gmwmi -seed_dynamic ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/wmfod.mif -maxlength 250 -select 10M -step 1 -angle 45 -cutoff 0.06

# Filter and get weights from tcksift2
tcksift2 -force 10M.tck ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/wmfod.mif -act 5TT.mif weights.csv

# Create connectome from tck using above calculated weights
tck2connectome -force 10M.tck nodes.mif connectome.csv -tck_weights_in weights.csv -out_assignments assignments.txt -symmetric -zero_diagonal
