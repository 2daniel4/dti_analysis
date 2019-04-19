#!/bin/tcsh

#Set freesurfer environment - If don't set in command line or here all freesurfer functions will be unknown
#Path is to where you downloaded freesurfer
setenv FREESURFER_HOME /Applications/freesurfer/
source $FREESURFER_HOME/SetUpFreeSurfer.csh

#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer 
#Should have the anatomical outputs from freesurfer under this subj_dir
setenv SUBJECTS_DIR /path/2/subj_dir

#Otherwise copy over mri, surf, and label folders into new working direcroty with DTI Dicoms

#setenv to location where analysis is being run
setenv home /Volumes/DANIEL/

#setenv to location where Dicoms are 
#setenv DICOMS /path/2/Diffusion/Dicoms
#setenv results /path/2/output/results

echo "-------------------------------------------------------------------------------------------------"

#make directories for analysis
cd home
mkdir dti_freesurf
cd home/dti_freesurf
mkdir diffusion_recons
cd home

#list all subjects inside ().
foreach subj ()

#list all conditions for each subject
foreach cond ()

echo "subj = " ${subj} ", cond = " ${cond}


mkdir /path/2/subj_dir/${subj}_${cond}
cd /path/2/subj_dir/${subj}_${cond}


cp DICOMS/*.dcm /path/2/subj_dir/${subj}_${cond}

#May need to copy surf, label, and mri folder from anatomical freesurfer (recon-all) output
cp -R /path/2/freesurfer/data/mri /path/2/subj_dir/${subj}_${cond}/
cp -R /path/2/freesurfer/data//surf /path/2/subj_dir/${subj}_${cond}/
cp -R /path/2/freesurfer/data/label /path/2/subj_dir/${subj}_${cond}/

#Convert into DCM (don't always need this step) but I like to do it to debug
cd /path/2/subj_dir/${subj}_${cond}/
mri_convert image000001.dcm /path/2/subj_dir/${subj}_${cond}/dwi.nii.gz

#--sd subject ID path --s subject name (Created a new version of dt_recon because issue with registration - get on listserve conversation!)
dt_recon --sd /path/2/subj_dir --i /path/2/subj_dir/${subj}_${cond}/image000001.dcm --s ${subj}_${cond} --b dwi.bvals dwi.voxel_space.bvecs --o /results/${cond}.${subj}

end

end

#------------------------------------------------------------------------------------------------------
echo Complete: Make sure to check all registrations (lowb to anat) and if errors persist run bbregister independently on the trouble images