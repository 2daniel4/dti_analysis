# These scripts are meant to be run on UMD's bswift using the slurm job scheduling software
# Specifically, the should be run in the following order
1. mrtrix_preproc.sh (Setup, tensor estimation, response function estimation)
2. mrtrix_response.sh (Create average response function)
3. mrtrix_calculate.sh (Create normalized WM, GM, and CSF images)

# These images can then be used in later image processing methods (tbss, VBA, ROI, etc....)
