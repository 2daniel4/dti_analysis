#!/bin/tcsh
#set freesurfer home to wherever freesurfer was downloaded
setenv FREESURFER_HOME /Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

#location to wherever you are doing the analysis (flash drive etc.)
setenv home /Volumes/DANIEL
setenv DICOMS /Volumes/DANIEL/Dicoms


cd home
#make a folder for a freesurfer results
mkdir freesurfer


cd home/freesurfer

#create subject directory environment. Important for freesurfer.
setenv SUBJECTS_DIR /Volumes/DANIEL/freesurfer

@ linenum = 1



foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

foreach cond (Ex Rest)

echo "subj = "${subj}", cond = " ${cond}

#must have Dicoms folder created. Or some folder with a path to anatomical Dicom images. Input first dicom and will load all of them. subjid gives the naming of each subject
recon-all -all -base ${subj} ${con} -i /Volumes/DANIEL/Dicoms/${subj}/session-${cond}/anat/image000001.dcm

end
end

#For longitudinal processing must have done cross-sectional processing first

foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

foreach cond (Ex Rest)

recon-all -base  base_${subj} -tp Ex.${subj} -tp Rest.${subj} -all

recon-all -long ${cond}.${subj} base_${subj} -all

end
end


# To segment hippocampus with freesurfer dev version
foreach subj (AES101 AES102 AES104 AES107 AES108 AES109 AES110 AES111 AES113 AES114 AES115 AES116 AES117 AES118 AES119 AES120 AES121 AES122 AES123 AES124 AES126 AES127 AES129 AES130 AES133 AES134 AES136 AES137 AES138 AES139)

segmentHA_T1_long.sh base_${subj}

end

