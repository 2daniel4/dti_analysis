#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=250000
#SBATCH --output=results
#SBATCH --nodes=1

set echo
setenv FSLDIR /data/bswift-0/software/fsl6.0.1
source ${FSLDIR}/etc/fslconf/fsl.csh
# Must module load python and gcc

setenv SUBJECTS_DIR /data/bswift-1/dcallow
#set subj= ($argv[1]) \

mkdir ${SUBJECTS_DIR}/CONNECTOME
cd ${SUBJECTS_DIR}/CONNECTOME/
mkdir tbss
cd ${SUBJECTS_DIR}/CONNECTOME/tbss

# Copy over FA images
/bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/FA.nii.gz ${SUBJECTS_DIR}/CONNECTOME/tbss/${subj}.nii.gz


# Run separately after copying over all FA images - Then comment out set subj part
#fslreorient2std *.nii.gz
#tbss_1_preproc *.nii.gz
#tbss_2_reg -T
#tbss_3_postreg -S
#tbss_4_prestats 0.2

# Non FA tbss

cd ${SUBJECTS_DIR}/CONNECTOME/tbss

# mkdir of any folder type you plan to analyze in addition to FA
# mkdir
# Copy over all files other files
# /bin/cp ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion/MD.nii.gz ${SUBJECTS_DIR}/CONNECTOME/tbss/${subj}.nii.gz
non_FA_tbss {folder}
