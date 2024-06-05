#!/bin/bash

# Written by Ivonne Cruz 2024-06-04

# ANTs configuration
export ANTSPATH=/usr/local/ANTs/bin/
export PATH=${ANTSPATH}:$PATH

for SUB in sub-02; do

    mkdir ${SUB}/SYNB0
    mkdir ${SUB}/SYNB0/INPUTS
    mkdir ${SUB}/SYNB0/OUTPUTS

    cp *01.sh ${SUB}/anat
    cp *02.sh ${SUB}/dwi
    cp *03.sh ${SUB}/SYNB0
    cp *04.sh ${SUB}/dwi

    cd ${SUB}/anat
    bash preprocess-01.sh ${SUB}
    cd ../dwi
    bash preprocess-02.sh ${SUB}
    cd ../SYNB0
    bash preprocess-03.sh ${SUB}
    cd ../dwi
    bash preprocess-04.sh ${SUB}
    cd ../..
done