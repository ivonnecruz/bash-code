#!/bin/bash
# Written by Ivonne Cruz 2024-06-03

display_usage() {
	echo "$(basename $0) [sub]"
	echo "This preprocessing script 4/4, requires 1 argument: 
		1) The ID of the subject;"
	}

	if [ $# -le 0 ]
	then
		display_usage
		exit 1
	fi

SUB=$1

# ANTs config
#export ANTSPATH=/usr/local/ANTs/bin/
#export PATH=${ANTSPATH}:$PATH

######################################################################
# Denoise & movement correction: TopUp + Eddy + EddyQC
dwifslpreproc ${SUB}_dwi_den_gib.mif ${SUB}_dwi_den_gib_eddy.mif \
 -pe_dir j- -rpe_pair  \
 -se_epi ${SUB}_b0_all.mif  \
 -eddy_options " --flm=quadratic --slm=linear --repol"  \
 -eddyqc_all eddyqc_output  \
 -nthreads 14

# Bias field correction
dwibiascorrect ants ${SUB}_dwi_den_gib_eddy.mif ${SUB}_dwi_den_gib_eddy_unb.mif -bias ${SUB}_bias.mif

# Convert preprocesed dMRI .mif to .nii.gz
mrconvert ${SUB}_dwi_den_gib_eddy_unb.mif ${SUB}_dwi_den_gib_eddy_unb.nii.gz -fslgrad ${SUB}_dwi.bvec ${SUB}_dwi.bval

# Brain mask
dwiextract ${SUB}_dwi_den_gib.mif - -bzero | mrmath - mean temp.nii -axis 3
bet temp.nii ${SUB}_brain -m -f 0.2
rm temp.nii

# Convert mask .nii.gz to .mif
mrconvert ${SUB}_brain_mask.nii.gz ${SUB}_brain_mask.mif
