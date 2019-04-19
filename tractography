setenv FREESURFER_HOME /Applications/freesurfer/
source $FREESURFER_HOME/SetUpFreeSurfer.csh
#Must set SUBJECTS_DIR to where data is or else uses what was set up when installing freesurfer
setenv SUBJECTS_DIR /Volumes/DANIEL/dti_freesurf/diffusion_recons/


#prep can be exchanged for different parts of the pipeline, jobs will create a file that you can submit to a cluster for parallel processing, c is the configuration file
trac-all -{which part of trac all you want to run (prep, bedpost etc.}} -jobs {location of job file which you can input into terminal} -c /Volumes/DANIEL/dmrirc.long.example.sh


##################--------------------------------------------------------
#configuration file - create a file with the following specifications for longitudinal processing

# FreeSurfer SUBJECTS_DIR
# T1 images and FreeSurfer segmentations are expected to be found here
# 
setenv SUBJECTS_DIR /Volumes/DANIEL/freesurfer/

# Output directory where trac-all results will be saved
# Default: Same as SUBJECTS_DIR
#
set dtroot = /Volumes/DANIEL/dti_freesurf/dt_recon

# Subject IDs (one per time point per subject)
#
set subjlist = (Ex.AES101 Rest.AES101 Ex.AES102 Rest.AES102 Ex.AES104 Rest.AES104 Ex.AES107 Rest.AES107 Ex.AES108 Rest.AES108 Ex.AES109 Rest.AES109 Ex.AES110 Rest.AES110 Ex.AES111 Rest.AES111 Ex.AES113 Rest.AES113 Ex.AES114 Rest.AES114 Ex.AES115 Rest.AES115 Ex.AES116 Rest.AES116 Ex.AES117 Rest.AES117 Ex.AES118 Rest.AES118 Ex.AES119 Rest.AES119 Ex.AES120 Rest.AES120 Ex.AES121 Rest.AES121 Ex.AES122 Rest.AES122 Ex.AES123 Rest.AES123 Ex.AES124 Rest.AES124 Ex.AES126 Rest.AES126 Ex.AES127 Rest.AES127 Ex.AES129 Rest.AES129 Ex.AES130 Rest.AES130 Ex.AES133 Rest.AES133 Ex.AES134 Rest.AES134 Ex.AES136 Rest.AES136 Ex.AES137 Rest.AES137 Ex.AES138 Rest.AES138 Ex.AES139 Rest.AES139)

# Longitudinal base template subject IDs (one for each time point above)
#
set baselist = (base_AES101 base_AES101 base_AES102 base_AES102 base_AES104 base_AES104 base_AES107 base_AES107 base_AES108 base_AES108 base_AES109 base_AES109 base_AES110 base_AES110 base_AES111 base_AES111 base_AES113 base_AES113 base_AES114 base_AES114 base_AES115 base_AES115 base_AES116 base_AES116 base_AES117 base_AES117 base_AES118 base_AES118 base_AES119 base_AES119 base_AES120 base_AES120 base_AES121 base_AES121 base_AES122 base_AES122 base_AES123 base_AES123 base_AES124 base_AES124 base_AES126 base_AES126 base_AES127 base_AES127 base_AES129 base_AES129 base_AES130 base_AES130 base_AES133 base_AES133 base_AES134 base_AES134 base_AES136 base_AES136 base_AES137 base_AES137 base_AES138 base_AES138 base_AES139 base_AES139)

# In case you want to analyze only Huey and Louie
# Default: Run analysis on all time points and subjects
#
set runlist = (1)

# Input diffusion DICOMs (file names relative to dcmroot)
# If original DICOMs don't exist, these can be in other image format
# but then the gradient table and b-value table must be specified (see below)
#
set dcmroot = /Volumes/DANIEL/dti_freesurf/diffusion_recons/
set dcmlist = ( AES101.Ex/image000001.dcm AES101.Rest/image000001.dcm AES102.Ex/image000001.dcm AES102.Rest/image000001.dcm AES104.Ex/image000001.dcm AES104.Rest/image000001.dcm AES107.Ex/image000001.dcm AES107.Rest/image000001.dcm AES108.Ex/image000001.dcm AES108.Rest/image000001.dcm AES109.Ex/image000001.dcm AES109.Rest/image000001.dcm AES110.Ex/image000001.dcm AES110.Rest/image000001.dcm AES111.Ex/image000001.dcm AES111.Rest/image000001.dcm AES113.Ex/image000001.dcm AES113.Rest/image000001.dcm AES114.Ex/image000001.dcm AES114.Rest/image000001.dcm AES115.Ex/image000001.dcm AES115.Rest/image000001.dcm AES116.Ex/image000001.dcm AES116.Rest/image000001.dcm AES117.Ex/image000001.dcm AES117.Rest/image000001.dcm AES118.Ex/image000001.dcm AES118.Rest/image000001.dcm AES119.Ex/image000001.dcm AES119.Rest/image000001.dcm AES120.Ex/image000001.dcm AES120.Rest/image000001.dcm AES121.Ex/image000001.dcm AES121.Rest/image000001.dcm AES122.Ex/image000001.dcm AES122.Rest/image000001.dcm AES123.Ex/image000001.dcm AES123.Rest/image000001.dcm AES124.Ex/image000001.dcm AES124.Rest/image000001.dcm AES126.Ex/image000001.dcm AES126.Rest/image000001.dcm AES127.Ex/image000001.dcm AES127.Rest/image000001.dcm AES129.Ex/image000001.dcm AES129.Rest/image000001.dcm AES130.Ex/image000001.dcm AES130.Rest/image000001.dcm AES133.Ex/image000001.dcm AES133.Rest/image000001.dcm AES134.Ex/image000001.dcm AES134.Rest/image000001.dcm AES136.Ex/image000001.dcm AES136.Rest/image000001.dcm AES137.Ex/image000001.dcm AES137.Rest/image000001.dcm AES138.Ex/image000001.dcm AES138.Rest/image000001.dcm AES139.Ex/image000001.dcm AES139.Rest/image000001.dcm)

# Diffusion gradient tables (if there is a different one for each scan)
# Must be specified if they cannot be read from the DICOM headers
# The tables must have either three columns, where each row is a gradient vector
# or three rows, where each column is a gradient vector
# There must be as many gradient vectors as volumes in the diffusion data set
# Default: Read from DICOM header
#
set bveclist = ()

# Diffusion gradient table (if using the same one for all scans)
# Must be specified if it cannot be read from the DICOM headers
# The table must have either three columns, where each row is a gradient vector
# or three rows, where each column is a gradient vector
# There must be as many gradient vectors as volumes in the diffusion data set
# Default: Read from DICOM header
#
set bvecfile = ()

# Diffusion b-value tables (if there is a different one for each scan)
# Must be specified if they cannot be read from the DICOM headers
# There must be as many b-values as volumes in the diffusion data set
# Default: Read from DICOM header
#
set bvallist = ()

# Diffusion b-value table
# Must be specified if it cannot be read from the DICOM headers
# There must be as many b-values as volumes in the diffusion data set
# Default: Read from DICOM header
#
set bvalfile = ()

# Perform registration-based B0-inhomogeneity compensation?
# Default: 0 (no)
#
set dob0 = 1

# Input B0 field map magnitude DICOMs (file names relative to dcmroot)
# Only used if dob0 = 1
# Default: None
#
set b0mlist = (AES101.Ex/field/TE4.92_image000001.dcm AES101.Rest/field/TE4.92_image000001.dcm  AES102.Ex/field/TE4.92_image000001.dcm AES102.Rest/field/TE4.92_image000001.dcm AES104.Ex/field/TE4.92_image000001.dcm AES104.Rest/field/TE4.92_image000001.dcm AES107.Ex/field/TE4.92_image000001.dcm AES107.Rest/field/TE4.92_image000001.dcm AES108.Ex/field/TE4.92_image000001.dcm AES108.Rest/field/TE4.92_image000001.dcm AES109.Ex/field/TE4.92_image000001.dcm AES109.Rest/field/TE4.92_image000001.dcm AES110.Ex/field/TE4.92_image000001.dcm AES110.Rest/field/TE4.92_image000001.dcm AES111.Ex/field/TE4.92_image000001.dcm AES111.Rest/field/TE4.92_image000001.dcm AES113.Ex/field/TE4.92_image000001.dcm AES113.Rest/field/TE4.92_image000001.dcm AES114.Ex/field/TE4.92_image000001.dcm AES114.Rest/field/TE4.92_image000001.dcm AES115.Ex/field/TE4.92_image000001.dcm AES115.Rest/field/TE4.92_image000001.dcm AES116.Ex/field/TE4.92_image000001.dcm AES116.Rest/field/TE4.92_image000001.dcm AES117.Ex/field/TE4.92_image000001.dcm AES117.Rest/field/TE4.92_image000001.dcm AES118.Ex/field/TE4.92_image000001.dcm AES118.Rest/field/TE4.92_image000001.dcm AES119.Ex/field/TE4.92_image000001.dcm AES119.Rest/field/TE4.92_image000001.dcm AES120.Ex/field/TE4.92_image000001.dcm AES120.Rest/field/TE4.92_image000001.dcm AES121.Ex/field/TE4.92_image000001.dcm AES121.Rest/field/TE4.92_image000001.dcm AES122.Ex/field/TE4.92_image000001.dcm AES122.Rest/field/TE4.92_image000001.dcm AES123.Ex/field/TE4.92_image000001.dcm AES123.Rest/field/TE4.92_image000001.dcm AES124.Ex/field/TE4.92_image000001.dcm AES124.Rest/field/TE4.92_image000001.dcm AES126.Ex/field/TE4.92_image000001.dcm AES126.Rest/field/TE4.92_image000001.dcm AES127.Ex/field/TE4.92_image000001.dcm AES127.Rest/field/TE4.92_image000001.dcm AES129.Ex/field/TE4.92_image000001.dcm AES129.Rest/field/TE4.92_image000001.dcm AES130.Ex/field/TE4.92_image000001.dcm AES130.Rest/field/TE4.92_image000001.dcm AES133.Ex/field/TE4.92_image000001.dcm AES133.Rest/field/TE4.92_image000001.dcm AES134.Ex/field/TE4.92_image000001.dcm AES134.Rest/field/TE4.92_image000001.dcm AES136.Ex/field/TE4.92_image000001.dcm AES136.Rest/field/TE4.92_image000001.dcm AES137.Ex/field/TE4.92_image000001.dcm AES137.Rest/field/TE4.92_image000001.dcm AES138.Ex/field/TE4.92_image000001.dcm AES138.Rest/field/TE4.92_image000001.dcm AES139.Ex/field/TE4.92_image000001.dcm AES139.Rest/field/TE4.92_image000001.dcm )

# Input B0 field map phase DICOMs (file names relative to dcmroot)
# Only used if dob0 = 1
# Default: None
#
set b0plist = ( AES101.Ex/phase/TE7.38_image000001.dcm AES101.Rest/phase/TE7.38_image000001.dcm  AES102.Ex/phase/TE7.38_image000001.dcm AES102.Rest/phase/TE7.38_image000001.dcm AES104.Ex/phase/TE7.38_image000001.dcm AES104.Rest/phase/TE7.38_image000001.dcm AES107.Ex/phase/TE7.38_image000001.dcm AES107.Rest/phase/TE7.38_image000001.dcm AES108.Ex/phase/TE7.38_image000001.dcm AES108.Rest/phase/TE7.38_image000001.dcm AES109.Ex/phase/TE7.38_image000001.dcm AES109.Rest/phase/TE7.38_image000001.dcm AES110.Ex/phase/TE7.38_image000001.dcm AES110.Rest/phase/TE7.38_image000001.dcm AES111.Ex/phase/TE7.38_image000001.dcm AES111.Rest/phase/TE7.38_image000001.dcm AES113.Ex/phase/TE7.38_image000001.dcm AES113.Rest/phase/TE7.38_image000001.dcm AES114.Ex/phase/TE7.38_image000001.dcm AES114.Rest/phase/TE7.38_image000001.dcm AES115.Ex/phase/TE7.38_image000001.dcm AES115.Rest/phase/TE7.38_image000001.dcm AES116.Ex/phase/TE7.38_image000001.dcm AES116.Rest/phase/TE7.38_image000001.dcm AES117.Ex/phase/TE7.38_image000001.dcm AES117.Rest/phase/TE7.38_image000001.dcm AES118.Ex/phase/TE7.38_image000001.dcm AES118.Rest/phase/TE7.38_image000001.dcm AES119.Ex/phase/TE7.38_image000001.dcm AES119.Rest/phase/TE7.38_image000001.dcm AES120.Ex/phase/TE7.38_image000001.dcm AES120.Rest/phase/TE7.38_image000001.dcm AES121.Ex/phase/TE7.38_image000001.dcm AES121.Rest/phase/TE7.38_image000001.dcm AES122.Ex/phase/TE7.38_image000001.dcm AES122.Rest/phase/TE7.38_image000001.dcm AES123.Ex/phase/TE7.38_image000001.dcm AES123.Rest/phase/TE7.38_image000001.dcm AES124.Ex/phase/TE7.38_image000001.dcm AES124.Rest/phase/TE7.38_image000001.dcm AES126.Ex/phase/TE7.38_image000001.dcm AES126.Rest/phase/TE7.38_image000001.dcm AES127.Ex/phase/TE7.38_image000001.dcm AES127.Rest/phase/TE7.38_image000001.dcm AES129.Ex/phase/TE7.38_image000001.dcm AES129.Rest/phase/TE7.38_image000001.dcm AES130.Ex/phase/TE7.38_image000001.dcm AES130.Rest/phase/TE7.38_image000001.dcm AES133.Ex/phase/TE7.38_image000001.dcm AES133.Rest/phase/TE7.38_image000001.dcm AES134.Ex/phase/TE7.38_image000001.dcm AES134.Rest/phase/TE7.38_image000001.dcm AES136.Ex/phase/TE7.38_image000001.dcm AES136.Rest/phase/TE7.38_image000001.dcm AES137.Ex/phase/TE7.38_image000001.dcm AES137.Rest/phase/TE7.38_image000001.dcm AES138.Ex/phase/TE7.38_image000001.dcm AES138.Rest/phase/TE7.38_image000001.dcm AES139.Ex/phase/TE7.38_image000001.dcm AES139.Rest/phase/TE7.38_image000001.dcm )

# Echo spacing for field mapping sequence (from sequence printout)
# Only used if dob0 = 1
# Default: None
#
set echospacing = 0.7

# Perform registration-based eddy-current compensation?
# Default: 1 (yes)
#
set doeddy = 1

# Rotate diffusion gradient vectors to match eddy-current compensation?
# Only used if doeddy = 1
# Default: 1 (yes)
#
set dorotbvecs = 1

# Fractional intensity threshold for BET mask extraction from low-b images
# This mask is used only if usemaskanat = 0
# Default: 0.3
#
set thrbet = 0.5

# Perform diffusion-to-T1 registration by flirt?
# Default: 0 (no)
#
set doregflt = 0

# Perform diffusion-to-T1 registration by bbregister?
# Default: 1 (yes)
#
set doregbbr = 1

# Perform registration of T1 to MNI template?
# Default: 1 (yes)
#
set doregmni = 1

# MNI template
# Only used if doregmni = 1
# Default: $FSLDIR/data/standard/MNI152_T1_1mm_brain.nii.gz
#
set mnitemp = $FSLDIR/data/standard/MNI152_T1_1mm_brain.nii.gz

# Perform registration of T1 to CVS template?
# Default: 0 (no)
#
set doregcvs = 0

# CVS template subject ID
# Only used if doregcvs = 1
# Default: cvs_avg35
#
set cvstemp =

# Parent directory of the CVS template subject
# Only used if doregcvs = 1
# Default: $FREESURFER_HOME/subjects
#
set cvstempdir =

# Use brain mask extracted from T1 image instead of low-b diffusion image?
# Has no effect if there is no T1 data
# Default: 1 (yes)
#
set usemaskanat = 1

# Paths to reconstruct
# Default: All paths in the atlas
#
set pathlist = ( lh.cst_AS rh.cst_AS \
                 lh.unc_AS rh.unc_AS \
                 lh.ilf_AS rh.ilf_AS \
                 fmajor_PP fminor_PP \
                 lh.atr_PP rh.atr_PP \
                 lh.ccg_PP rh.ccg_PP \
                 lh.cab_PP rh.cab_PP \
                 lh.slfp_PP rh.slfp_PP \
                 lh.slft_PP rh.slft_PP )

# Number of path control points
# It can be a single number for all paths or a different number for each of the
# paths specified in pathlist
# Default: 7 for the forceps major, 6 for the corticospinal tract,
#          4 for the angular bundle, and 5 for all other paths
#
set ncpts = (6 6 5 5 5 5 7 5 5 5 5 5 4 4 5 5 5 5)

# List of training subjects
# This text file lists the locations of training subject directories
# Default: $FREESURFER_HOME/trctrain/trainlist.txt
#
set trainfile = $FREESURFER_HOME/trctrain/trainlist.txt

# Number of "sticks" (anisotropic diffusion compartments) in the bedpostx
# ball-and-stick model
# Default: 2
#
set nstick = 2

# Number of MCMC burn-in iterations
# (Path samples drawn initially by MCMC algorithm and discarded)
# Default: 200
#
set nburnin = 200

# Number of MCMC iterations
# (Path samples drawn by MCMC algorithm and used to estimate path distribution)
# Default: 7500
#
set nsample = 10000

# Frequency with which MCMC path samples are retained for path distribution
# Default: 5 (keep every 5th sample)
#
set nkeep = 5

# Reinitialize path reconstruction?
# This is an option of last resort, to be used only if one of the reconstructed
# pathway distributions looks like a single curve. This is a sign that the
# initial guess for the pathway was problematic, perhaps due to poor alignment
# between the individual and the atlas. Setting the reinit parameter to 1 and
# rerunning "trac-all -prior" and "trac-all -path", only for the specific
# subjects and pathways that had this problem, will attempt to reconstruct them
# with a different initial guess.
# Default: 0 (do not reinitialize)
#
set reinit = 0



