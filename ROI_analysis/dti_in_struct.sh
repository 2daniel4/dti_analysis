!/bin/tcsh


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

mkdir ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat
rm -R ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/*


cp ${ANAT_DIR}/${subj}.${cond}/mri/brainmask.mgz ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/brainmask.mgz

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/fa-masked.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/brainmask.mgz --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/fa_in_t1.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/adc-masked.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/brainmask.mgz --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/MD_in_t1.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg


cp ${ANAT_DIR}/${subj}.${cond}/mri/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz
cp ${ANAT_DIR}/${subj}.${cond}/mri/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz

#Create hippocampal segmentation
mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lhipp2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

mri_vol2vol --mov ${SUBJECTS_DIR}/${cond}.${subj}/lowb.nii.gz --targ ${ANAT_DIR}/${subj}.${cond}/mri/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --interp nearest --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rhipp2diff.nii.gz --reg ${SUBJECTS_DIR}/${cond}.${subj}/register.dat --no-save-reg

#creates a binary mask of body and head of hippocampus
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/l_tail_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/r_tail_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/l_body_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/r_body_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/l_tail_body_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 231 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/r_tail_body_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/l_head_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/r_head_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/l_body_head_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/r_body_head_hipp.nii.gz

mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/lh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/full_l_hipp.nii.gz
mri_binarize --i ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/rh.hippoAmygLabels-T1.long.v21.HBT.FSvoxelSpace.mgz --match 226 231 232 --o ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/full_r_hipp.nii.gz

end

end
