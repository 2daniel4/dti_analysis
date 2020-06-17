#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=4

setenv FSLDIR /data/bswift-0/software/fsl6.0.1
source ${FSLDIR}/etc/fslconf/fsl.csh
set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)
#setenv FREESURFER_HOME /data/bswift-0/software/freesurfer-dev/
#source /data/bswift-0/software/freesurfer-dev/SetUpFreeSurfer.csh
#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /data/bswift-1/dcallow

@ linenum = 1

set subj= ($argv[1]) \

#mkdir ${SUBJECTS_DIR}/CONNECTOME
#cd ${SUBJECTS_DIR}/CONNECTOME/
#cd ${SUBJECTS_DIR}/CONNECTOME/analysis
#mkdir ${subj}

# NODDI results
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/AMICO/NODDI/*.nii.gz ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/AMICO/NODDI/*.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/MD.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/FA.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/TC.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/TG.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/
#/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/TG.nii.gz ${SUBJECTS_DIR}/CONNECTOME/analysis/${subj}/

cd /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion

cd ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/

#fslmaths MD.nii.gz -mul 1000 MD.nii.gz
# Extract mean value within ROI (fslstats (image) -k (ROI) -M)
#fslstats FIT_OD.nii.gz -k cleaned_full_bhipp.nii.gz -M
