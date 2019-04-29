#!/bin/tcsh

#Set path to general work station
setenv home /Volumes/DANIEL

#set path to fa images
setenv FA /Volumes/DANIEL/dti_freesurf/dtrecon

echo create tbss directory -----------------------------------------------------------------------------------------------------

foreach cond (All Conditions)
foreach subj (All Subjects)

cd ${home}
#Make Directiory for tbss analysis called tbss
mkdir tbss
cd ${home}/tbss/

echo "subj = " ${subj} ", cond = " ${cond}

#Copy masked FA images created from dt_recon to tbss folder with new name based on condition and subject number
cp ${FA}/fa-masked.nii.gz ${home}/tbss/${cond}.${subj}.nii.gz

end

end

echo "tbss pipeline ----------------------------------------------------------------------------------------------"

cd ${home}/tbss/

#Can change fsl's tbss_1_preproc source code comand to prevent from eroding ($FSLDIR/bin/fslmaths $f -min 1 -roi -ero 1 $X 1 $Y 1 $Z 0 1 FA/${f}_FA *remove -ero*)
tbss_1_preproc *.nii.gz

#Allign to fMRIB58_FA image (can change flag to -n if want to align to own best image)
tbss_2_reg -T


#mean derived from subject specific (or use -T flag for fMRIB_FA subject specific template and skeleto)
tbss_3_postreg -S

#change input to threshold FA value of the skeleton (Usually between .2 and .3)
tbss_4_prestats 0.2
