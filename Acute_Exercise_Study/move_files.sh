#!/bin/tcsh

setenv FREESURFER_HOME /Applications/freesurfer_dev/
source $FREESURFER_HOME/SetUpFreeSurfer.csh
#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
mkdir /Volumes/DANIEL/dti_freesurf/dtrecon
mkdir ${SUBJECTS_ANAT}

setenv SUBJECTS_ANAT ${SUBJECTS_ANAT}
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/dtrecon
@ linenum = 1




foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

foreach cond (Ex Rest)

echo "subj = " ${subj} ", cond = " ${cond}

cd ${SUBJECTS_DIR}

#Must create the acqp.txt and index.txt file
cp /Volumes/DANIEL/acqp.txt ${SUBJECTS_ANAT}/${subj}.${cond}/acqp.txt

cp /Volumes/DANIEL/index.txt ${SUBJECTS_ANAT}/${subj}.${cond}/index.txt

mkdir ${subj}.${cond}

#Move trac based diffusion data to correct files so can process
cp /Volumes/DANIEL/dti_freesurf/trac/${subj}_${cond}.long.base_${subj}/dmri/ ${SUBJECTS_DIR}/${cond}.${subj}/

#Move freesurfer processed output to a file for processing
cd ${SUBJECTS_ANAT}/

cp -R /Volumes/DANIEL/freesurfer/${subj}_${cond}.long.base_${subj}/mri ${SUBJECTS_ANAT}/${subj}.${cond}/
cp -R /Volumes/DANIEL/freesurfer/${subj}_${cond}.long.base_${subj}/label ${SUBJECTS_ANAT}/${subj}.${cond}/
cp -R /Volumes/DANIEL/freesurfer/${subj}_${cond}.long.base_${subj}/scripts ${SUBJECTS_ANAT}/${subj}.${cond}/
cp -R /Volumes/DANIEL/freesurfer/${subj}_${cond}.long.base_${subj}/surf ${SUBJECTS_ANAT}/${subj}.${cond}/

#
end

end

