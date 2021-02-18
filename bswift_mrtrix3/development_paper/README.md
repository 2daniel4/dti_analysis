# These scripts are meant to be run on UMD's bswift using the slurm job scheduling software
# Specifically, the should be run in the following order
1. mrtrix_preproc.sh (Setup, tensor estimation, response function estimation)
2. mrtrix_response.sh (Create average response function)
3. mrtrix_calculate.sh (Create normalized WM, GM, and CSF images)

The steps in this code allow you to take diffusion images from dicom - > diffusion tensor based images while going through best preprocessing steps as outline by mrtrix3 (https://mrtrix.readthedocs.io/en/latest/)
These images can then be used in later image processing and anlysis methods (tbss, VBA, ROI, etc....)
