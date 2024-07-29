#!/bin/bash

# Written by Ivonne Cruz 2024-06-04

# ANTs configuration
export ANTSPATH=/usr/local/ANTs/bin/
export PATH=${ANTSPATH}:$PATH

for SUB in sub-32 sub-33; do

    mkdir ${SUB}/synb0
    mkdir ${SUB}/synb0/INPUTS
    mkdir ${SUB}/synb0/OUTPUTS
    mkdir ${SUB}/dwi/diff

    cp *01.sh ${SUB}/anat
    cp *02.sh ${SUB}/dwi
    cp *03.sh ${SUB}/synb0
    cp *04.sh ${SUB}/dwi
    cp *05.sh ${SUB}/dwi

    cd ${SUB}/anat
    bash preprocess-01.sh ${SUB}
    cd ../dwi
    bash preprocess-02.sh ${SUB}
    cd ../synb0
    bash preprocess-03.sh ${SUB}
    cd ../dwi
    bash preprocess-04.sh ${SUB}
    bash process-05.sh ${SUB}
    cd ../../..

done