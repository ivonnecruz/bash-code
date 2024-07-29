#!/bin/bash
# Written by Ivonne Cruz 2024-05-30

display_usage() {
	echo "$(basename $0) [sub]"
	echo "This preprocessing script 2/4, requires 1 argument: 
		1) The ID of the subject;"
	}

	if [ $# -le 0 ]
	then
		display_usage
		exit 1
	fi

SUB=$1

######################################################################
# Convert dMRI .nii.gz to .mif
mrconvert ${SUB}_dwi.nii.gz ${SUB}_dwi.mif -fslgrad ${SUB}_dwi.bvec ${SUB}_dwi.bval -json_import ${SUB}_dwi.json

# Denoise: Thermal noise
dwidenoise ${SUB}_dwi.mif ${SUB}_dwi_den.mif -noise ${SUB}_noise.mif

# Denoise: Gibss artifacts
mrdegibbs ${SUB}_dwi_den.mif ${SUB}_dwi_den_gib.mif

# Extraction of B0 images && Calculate the mean of B0 images
dwiextract ${SUB}_dwi_den_gib.mif - -bzero | mrmath - mean ${SUB}_b0_mean.mif -axis 3 

# Convert mean-b0 .nii.gz to .mif
mrconvert ${SUB}_b0_mean.mif ../synb0/INPUTS/b0.nii.gz

# Create acqparams.txt file
rt=$(jq .TotalReadoutTime sub-01_dwi.json)
echo "0 -1 0 $rt" > ${SUB}_acqparams.txt
echo "0 -1 0 0" >> ${SUB}_acqparams.txt

# Include acqparams.txt for SYNB0
cp ${SUB}_acqparams.txt ../synb0/INPUTS/acqparams.txt