#!/bin/tcsh -f
#SBATCH --time=300:00:00
#SBATCH --mem=24000
#SBATCH --output=results
#SBATCH --cores=6

# The above is required any time you are submitting to SLURM (job management software) on bswift. 
# Line 1 indicates we are using tcsh and the -f indicates we will be supplying arguments (subject ID's)
# Line 2 - maximum amount of time allocated
# Line 3 - memory requested
# Line 4 - name of file with command output
# Line 5 - the number of cores/nodes requested

# Set paths to mrtrix and ANTS software.
set path = ( $path /data/bswift-0/software/ANTs-2019-11/MRtrix3Tissue/bin)
set path = ( $path /data/bswift-0/software/ANTs-2019-11/ANTs-2.1.0-Linux/bin)

#Set subjects directory (Where you will access stored data)
setenv SUBJECTS_DIR /data/bswift-1/dcallow

# Echo commands/output
set echo
# sets the variable ${subj} equal to the input value we provide (see the above note about the -f in shebang)
set subj= ($argv[1]) \

# Make directory for each subject and a dwi folder for the analysis
mkdir SUBJECTS_DIR/${subj}/
mkdir SUBJECTS_DIR/${subj}/dwi

# Go to dwi folder (will do all processing here)
cd SUBJECTS_DIR/${subj}/dwi

# Go to subjects dicom folder and convert to mrtrix diffusion image format in current analysis location (should include bval/bvec information in header - also hopefully phase encoding direction)
mrcovert -force ${SUBJECTS_DIR}/location/folder/with/dwi/dicoms dwi.mif


cp ${SUBJECTS_DIR}/location/folder/with/dwi/dicoms/dwi.mif 
# Denoise and unring the dwi image
# NOTE: Denoising and Gibbs ringing removal (“unringing”) are performed prior to any other processing steps: most other processing steps would be invalidated if done in a different order.
dwidenoise -force dwi.mif dwi_denoise.mif
mrdegibbs -force dwi_denoise.mif dwi_denoised_unringed.mif

# Preprocess DTI data -pe_dir (needed if not going straight from dicoms -pe_dir AP (anterior to posterior)) -rpe_none tells that no reverse phase encoding or field map available.
dwifslpreproc -force -rpe_none dwi_denoised_unringed.mif dwi_prep.mif
# Create mask for field correction
dwi2mask -force dwi_prep.mif dwi_mask.mif

# B0 inhomogeneity correction using ANTS
dwibiascorrect -force -mask dwi_mask.mif ants dwi_prep.mif dwi_corrected.mif

# Regrid data to 1.5 x 1.5 x 1.5 mm^3 resolution
# Note: For some pipelines or applications, you might want to consider upsampling (or more generally regridding) your preprocessed diffusion MRI data. If you do this before the 3-tissue constrained spherical deconvolution (3-tissue CSD) step, you’ll get a higher quality result. Upsampling is useful if you’re after a higher quality visualisation, which reveals finer details. It might also benefit image registration, (population) template construction or even tractography. Do note that upsampling can easily generate very large image file(s), and will result in (sometimes drastically) increased computation times for the 3-tissue CSD step. Remember that voxels are 3-dimensional: e.g. if you were to upsample all voxel dimensions by a factor 2, you’re generating 8 times more voxels! If you’re just doing a “quick” test run to see if you can produce good 3-tissue CSD results from your data, you might want to skip this step initially.
mrgrid -force dwi_corrected.mif regrid dwi_corrected_upsampled.mif -voxel 1.5

# Create updated (upsampled) mask 
dwi2mask -force dwi_corrected_upsampled.mif dwi_mask_upsampled.mif

# Extract b0 image
dwiextract -force -bzero dwi_corrected_upsampled.mif lowb_brain_corrected.nii.gz

# Create tensor images (For analysis of FA/MD images etc....)
dwi2tensor -force dwi_corrected_upsampled.mif tensor.mif
tensor2metric -force -mask dwi_mask_upsampled.mif -adc MD.nii.gz tensor.mif
tensor2metric -force -mask dwi_mask_upsampled.mif -fa FA.nii.gz tensor.mif

# Create response function (This will allow us to determine the amount of diffusion signal coming from different tissue types within each voxel)
dwi2response -force dhollander dwi_corrected_upsampled.mif wm_response.txt gm_response.txt csf_response.txt



