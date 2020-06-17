#!/bin/tcsh
#SBATCH --time=300:00:00
#SBATCH --mem=60000
#SBATCH --output=result
#SBATCH --cores=4

set echo
set subj= ($argv[1]) \

cd /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion
rm -R -f /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion/AMICO
rm -R -f /data/bswift-1/dcallow/CONNECTOME/dwi/${subj}/T1w/Diffusion/bvals.scheme
source /data/bswift-0/software/loadpython3.csh 3.7

python <<EOF
import amico
import spams
#import camino
amico.core.setup()

ae = amico.Evaluation("/data/bswift-1/dcallow/CONNECTOME/dwi/", "${subj}/T1w/Diffusion")
# Set bStep for connectome data because often bvals are off by 5-10 and need order to be consistent
amico.util.fsl2scheme("/location/bvals","/location/bvecs,bStep=(0,1000,2000,3000)"
# Important to set b0_thr to 5 for dwi data from connectome due to weird b-values
ae.load_data(dwi_filename = "data.nii.gz", scheme_filename = "bvals.scheme", mask_filename ="nodif_brain_mask.nii.gz", b0_thr = 5)
ae.set_model("NODDI")
ae.generate_kernels(regenerate=True)
ae.load_kernels()
ae.fit()
ae.save_results()

EOF
