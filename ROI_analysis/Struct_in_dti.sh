#!/bin/tcsh


setenv FREESURFER_HOME /Applications/freesurfer_dev/
source $FREESURFER_HOME/SetUpFreeSurfer.csh
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/dtrecon
setenv ANAT_DIR /Volumes/DANIEL/dti_freesurf/diffusion_recons


@ linenum = 1

#make directory for all subjects FA data before loop


foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

#AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139

foreach cond (Ex Rest)

echo "subj = " ${subj} ", cond = " ${cond}
set echo

cd ${SUBJECTS_DIR}

#mkdir ${SUBJECTS_DIR}/${cond}.${subj}/stats

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/brainmask.mgz --inv --interp nearest --o ${SUBJECTS_DIR}/${subj}.${cond}/mri/brainmask2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${SUBJECTS_DIR}/${cond}.${subj}/pve_T1_space.nii.gz --inv --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/pve2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

#Create hippocampal segmentation
mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --inv --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --inv --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

#creates a binary mask of body and head of hippocampus
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 226 --o ${SUBJECTS_DIR}/${cond}.${subj}/l_tail_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 226 --o ${SUBJECTS_DIR}/${cond}.${subj}/r_tail_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/l_body_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/r_body_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 226 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/l_tail_body_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 226 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/r_tail_body_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/l_head_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/r_head_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/l_body_head_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/r_body_head_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/lhipp2diff.nii.gz --match 226 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/full_l_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/rhipp2diff.nii.gz --match 226 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/full_r_hipp.nii.gz

#Mask the images using the white matter 2 diffusion file.
mri_mask ${SUBJECTS_DIR}/${cond}.${subj}/fa.nii.gz ${ANAT_DIR}/${subj}.${cond}/mri/brainmask2diff.nii.gz ${SUBJECTS_DIR}/${cond}.${subj}/fa-masked.nii.gz
mri_mask ${SUBJECTS_DIR}/${cond}.${subj}/adc.nii.gz ${ANAT_DIR}/${subj}.${cond}/mri/brainmask2diff.nii.gz ${SUBJECTS_DIR}/${cond}.${subj}/adc-masked.nii.gz
mri_mask ${SUBJECTS_DIR}/${cond}.${subj}/radialdiff.nii.gz ${ANAT_DIR}/${subj}.${cond}/mri/brainmask2diff.nii.gz ${SUBJECTS_DIR}/${cond}.${subj}/radialdiff-masked.nii.gz

end

end

