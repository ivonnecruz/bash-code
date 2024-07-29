#!/bin/bash
# Written by Ivonne Cruz 2024-05-30

display_usage() {
	echo "$(basename $0) [sub]"
	echo "This preprocessing script 1/4, requires 1 argument: 
		1) The ID of the subject;"
	}

	if [ $# -le 0 ]
	then
		display_usage
		exit 1
	fi

SUB=$1

######################################################################
# Convert T1w from .nii.gz to .mif && Set strides [-1 2 3]
mrconvert ${SUB}_T1w.nii.gz ${SUB}_T1w.mif -strides -1,2,3 -json_import ${SUB}_T1w.json

# Convert from .mif to .nii.gz && Include for SYNB0
mrconvert ${SUB}_T1w.mif ../synb0/INPUTS/T1.nii.gz