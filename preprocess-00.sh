#!/bin/bash
# Written by Ivonne Cruz 2024-06-03

display_usage() {
	echo "$(basename $0) [sub]"
	echo "This preprocessing script 0/4, requires 1 argument: 
		1) The ID of the subject;"
	}

	if [ $# -le 0 ]
	then
		display_usage
		exit 1
	fi

SUB=$1

######################################################################
# Create folders for SYNB0-Disco
mkdir SYNB0
mkdir SYNB0/INPUTS
mkdir SYNB0/OUTPUTS