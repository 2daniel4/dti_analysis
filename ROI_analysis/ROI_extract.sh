#!/bin/tcsh


setenv FREESURFER_HOME /Applications/freesurfer_dev/
source $FREESURFER_HOME/SetUpFreeSurfer.csh
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/dtrecon
setenv trac /Volumes/DANIEL/dti_freesurf/trac/


@ linenum = 1

#make directory for all subjects FA data before loop

foreach cond (Ex Rest)
echo post.${cond}
foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

#AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139

#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/fa-masked.nii.gz /Volumes/DANIEL/excess/fa-masked.nii.gz
#for md and rd  -mul 1000
#fslstats /Volumes/DANIEL/excess/fa-masked.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/full_hipp_ROI.nii.gz -M

#For thresholded values
#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/adc-masked.nii.gz /Volumes/DANIEL/excess/fa-masked.nii.gz
#for md and rd  -mul 1000
#fslstats /Volumes/DANIEL/excess/adc-masked.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/full_l_anter_hipp.nii.gz -M

#create bilateral mask
#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/full_r_hipp.nii.gz -add ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/full_l_hipp.nii.gz ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/bilateral_full_hipp.nii.gz


#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/full_l_hipp.nii.gz -add ${SUBJECTS_DIR}/${cond}.${subj}/full_r_hipp.nii.gz ${SUBJECTS_DIR}/${cond}.${subj}/full_hipp.nii.gz

#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/fa_in_t1.nii.gz /Volumes/DANIEL/excess/fa.nii.gz
#for md and rd  -mul 1000
#fslstats /Volumes/DANIEL/excess/fa.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/bilateral_full_hipp.nii.gz -M

#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/fa-masked.nii.gz /Volumes/DANIEL/excess/fa.nii.gz
#for md and rd  -mul 1000
#fslstats /Volumes/DANIEL/excess/fa.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/full_hipp.nii.gz -M

#For thresholded values
#fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/adc-masked.nii.gz /Volumes/DANIEL/excess/fa-masked.nii.gz
#for md and rd  -mul 1000
#fslstats /Volumes/DANIEL/excess/adc-masked.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/full_l_anter_hipp.nii.gz -M
end

end

#create a summary statistics sheet

foreach cond (Ex Rest)
echo full_MD.${cond}
foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)


fslmaths ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/MD_in_t1.nii.gz -mul 1000 /Volumes/DANIEL/excess/MD.nii.gz
#for md and rd  -mul 1000
fslstats /Volumes/DANIEL/excess/MD.nii.gz -k ${SUBJECTS_DIR}/${cond}.${subj}/dti_in_anat/bilateral_full_hipp.nii.gz -M

end

end

