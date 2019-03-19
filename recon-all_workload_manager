#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=6

#Type this into the command line before submitting and to submit
#Depending on infrastructure may need to type these module load commands into command line before running this code.
#module load freesurfer
#module load matlab/2012b

#Type into command line
#foreach subj (All Subjects)
#foreach cond (All Conditions for Each Subject)
#sbatch recon-all_bswift.sh ${subj} ${cond}
#end
#end



set echo
#input arguments from sbatch recon-all_bswift.sh ${subj} ${cond}
set subj= ($argv[1]) \
set cond= ($argv[2]) 


echo --------------------------------------
echo start reconall at:
echo working on ${cond}.${subj}
date
echo --------------------------------------

#create freesurfer directory
mkdir /homes/dcallow/freesurfer

#set the environment for recon-all processing and outputs
setenv SUBJECTS_DIR /homes/dcallow/freesurfer



recon-all -all -s ${cond}.${subj} -i /homes/dcallow/Dicoms/${subj}/session-${cond}/anat/image000001.dcm


