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


# Calculate average response
cd ${SUBJECTS_DIR}/response/wm
responsemean *.txt average_response_wm.txt
cd ${SUBJECTS_DIR}/response/csf
responsemean *.txt average_response_csf.txt
cd ${SUBJECTS_DIR}/response/gm
responsemean *.txt average_response_gm.txt
