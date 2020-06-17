#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=6

set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)

set echo
#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /data/bswift-1/dcallow

@ linenum = 1
set subj= ($argv[1]) \

mkdir ${SUBJECTS_DIR}/CONNECTOME
mkdir ${SUBJECTS_DIR}/CONNECTOME/response

# Move response files to wm, gm, and csf folders giving them subject specific names

cd ${SUBJECTS_DIR}/CONNECTOME/dwi/${subj}/T1w/Diffusion
mkdir /${SUBJECTS_DIR}/CONNECTOME/response/wm/
cp wm_response.txt /${SUBJECTS_DIR}/CONNECTOME/response/wm/${subj}.wm_response.txt
mkdir /${SUBJECTS_DIR}/CONNECTOME/response/gm/
cp gm_response.txt /${SUBJECTS_DIR}/CONNECTOME/response/gm/${subj}.gm_response.txt
mkdir /${SUBJECTS_DIR}/CONNECTOME/response/csf/
cp csf_response.txt /${SUBJECTS_DIR}/CONNECTOME/response/csf/${subj}.csf_response.txt

# Calculate average response
cd ${SUBJECTS_DIR}/CONNECTOME/response/wm
responsemean *.txt average_response_wm.txt
cd ${SUBJECTS_DIR}/CONNECTOME/response/csf
responsemean *.txt average_response_csf.txt
cd ${SUBJECTS_DIR}/CONNECTOME/response/gm
responsemean *.txt average_response_gm.txt
