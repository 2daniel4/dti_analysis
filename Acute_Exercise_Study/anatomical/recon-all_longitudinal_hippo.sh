#!/bin/tcsh

#####For Slurm Submission parameters
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=6

#Type this into the command line before submitting and to submit
#Depending on infrastructure may need to type these module load commands into command line before running this code.
#module load freesurfer (for segmentHA must download freesurfer_dev version)
#module load matlab/2012b


#Slurm Submission Type into Command Line
#foreach subj (subject names)
#foreach cond (conditions for each subject)
# sbatch recon-all_bswift.sh ${subj} ${cond}
# end

set echo

#first two arguments provided and used to set variable for code
set subj= ($argv[1])
set cond= ($argv[2])

#set subject directory
setenv SUBJECTS_DIR /homes/dcallow/freesurfer

#===================Must Run These Seperately=====================================
#create base template for longitudinal images
recon-all -base base_${subj} -tp Ex.${subj} -tp Rest.${subj} -all

#===================Must Run These Seperately (All of first jobs must begin before using)=====================================
#create longitudinal images
recon-all -long ${cond}.${subj} base_${subj} -all

#===================Must Run These Seperately (All of previous code must have run before using) =====================================

#Create Hippocampal subfields (FS6.0 version)
#longHippoSubfieldsT1.sh base_${subj}

#Create Hippocampal and Amygdala subfields with freesurfer dev version (better segmentation and uses .1mm ex vivo segmentation)
segmentHA_T1_long.sh base_${subj}

#create a stats file for quantifying the volume of all of the hippocampal sub-regions
quantifyHAsubregions.sh hippoSF T1.long ${SUBJECTS_DIR}/hippocampal.stats
