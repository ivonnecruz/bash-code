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

######################################################################
# Denoise & movement correction: TopUp + Eddy + EddyQC
dtifit --data=${SUB}_dwi_den_gib_eddy_unb.nii.gz \
 --mask=${SUB}_brain_mask.nii.gz \
 --bvecs=${SUB}_dwi.bvec \
 --bvals=${SUB}_dwi.bval \
 --out=${SUB}_diff

mv ${SUB}_diff* diff