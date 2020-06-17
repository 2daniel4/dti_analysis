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

5ttgen freesurfer -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/cort_subcort.nii.gz 5TT.mif
5tt2vis -force 5TT.mif vis.mif
labelconvert -force ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/cort_subcort.nii.gz /data/bswift-1/dcallow/CONNECTOME/FreeSurferColorLUT.txt /data/bswift-1/dcallow/CONNECTOME/fs_default.txt nodes.mif
tck2connectome -force 1M_SIFT.tck nodes.mif connectome.csv -symmetric -zero_diagonal
tck2connectome -force 1M_SIFT.tck nodes.mif distance.csv -scale_length -stat_edge mean -symmetric -zero_diagonal
tcksample -force 1M_SIFT.tck ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/FA.nii.gz mean_FA_per_streamline.csv -stat_tck mean
tck2connectome -force 1M_SIFT.tck nodes.mif mean_FA_connectome.csv -scale_file mean_FA_per_streamline.csv -stat_edge mean -symmetric -zero_diack2connectome -force 1M_SIFT.tck nodes.mif mean_FA_connectome.csv -scale_file mean_FA_per_streamline.csv -stat_edge mean -symmetric -zero_diagonal
