#!/bin/tcsh

#Set freesurfer environment - If don't set in command line or here all freesurfer functions will be unknown
#Path is to where you downloaded freesurfer
setenv FREESURFER_HOME /Applications/freesurfer/
source $FREESURFER_HOME/SetUpFreeSurfer.csh

#folder with freesurfer recon-all outputs data folders
setenv anat /Volumes/DANIEL/freesurfer/data

#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer 
#Will move freesurfer anatomical output folders into this directory as well as DICOMS
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/diffusion_recons

#location of dti processing output
setenv dtrecon /Volumes/DANIEL/dti_freesurf/dtrecon
#Otherwise copy over mri, surf, and label folders into new working direcroty with DTI Dicoms

#setenv to location where analysis is being run
setenv home /Volumes/DANIEL/

#setenv to location where dti Dicoms are 
setenv DICOMS /Volumes/DANIEL/Dicoms/${subj}/session-${cond}/dwi/


echo "-------------------------------------------------------------------------------------------------"

#make directories for analysis
cd ${home}
#Create directory for dti preprocessing
mkdir dti_freesurf
cd ${home}/dti_freesurf
mkdir ${dtrecon}
mkdir ${SUBJECTS_DIR}
cd ${home}

#list all subjects inside ().
foreach subj ()

#list all conditions for each subject
foreach cond ()

echo "subj = " ${subj} ", cond = " ${cond}


mkdir /${SUBJECTS_DIR}/${subj}_${cond}
cd /${SUBJECTS_DIR}/${subj}_${cond}

#Move DICOMS into folder to be processed into 3D image
cp ${DICOMS}/*.dcm /${SUBJECTS_DIR}/${subj}_${cond}

#May need to copy surf, label, and mri folder from anatomical freesurfer (recon-all) output
cp -R ${anat}/mri ${SUBJECTS_DIR}/${subj}_${cond}
cp -R ${anat}/surf ${SUBJECTS_DIR}/${subj}_${cond}/
cp -R ${anat}/label ${SUBJECTS_DIR}/${subj}_${cond}/

#Convert into DCM (don't always need this step) but I like to do it to debug
cd ${SUBJECTS_DIR}/${subj}_${cond}/
mri_convert image000001.dcm ${SUBJECTS_DIR}/${subj}_${cond}/dwi.nii.gz

#--sd subject ID path --s subject name (Created a new version of dt_recon because issue with registration - get on listserve conversation!)
dt_recon --sd ${SUBJECTS_DIR} --i ${SUBJECTS_DIR}/${subj}_${cond}/image000001.dcm --s ${subj}_${cond} --b dwi.bvals dwi.voxel_space.bvecs --o ${results}/${cond}.${subj}

end
end

end

#------------------------------------------------------------------------------------------------------
echo Complete: Make sure to check all registrations (lowb to anat) and if errors persist run bbregister independently on the trouble images
