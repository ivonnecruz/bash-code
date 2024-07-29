#!/bin/bash

# Written by Ivonne Cruz 2024-07-29

for SUB in sub-03 sub-04 sub-05 sub-06 sub-07 sub-08 sub-09 sub-10 sub-11 sub-12 sub-13 sub-14 sub-15 sub-16 sub-17 sub-19; do

    mkdir ${SUB}/dwi/diff

    cp *01.sh ${SUB}/dwi

    cd ${SUB}/dwi
    bash process-01.sh ${SUB}
    cd ../..

done