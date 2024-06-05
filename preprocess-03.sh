#!/bin/bash
# Written by Ivonne Cruz 2024-06-03

display_usage() {
	echo "$(basename $0) [sub]"
	echo "This preprocessing script 3/4, requires 1 argument: 
		1) The ID of the subject;"
	}

	if [ $# -le 0 ]
	then
		display_usage
		exit 1
	fi

SUB=$1

######################################################################
sudo docker run --rm \
-v $(pwd)/INPUTS/:/INPUTS/ \
-v $(pwd)/OUTPUTS:/OUTPUTS/ \
-v /usr/local/freesurfer/7.4.1/license.txt:/extra/freesurfer/license.txt \
--user $(id -u):$(id -g) \
leonyichencai/synb0-disco:v3.0 \
--notopup

fslmerge -t OUTPUTS/b0_all.nii.gz OUTPUTS/b0_d_smooth.nii.gz OUTPUTS/b0_u.nii.gz
mrconvert OUTPUTS/b0_all.nii.gz ../dwi/${SUB}_b0_all.mif