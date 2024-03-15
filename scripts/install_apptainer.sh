#!/bin/bash
#SBATCH --nodes=1  
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16G
#SBATCH --time=3-00:00
#SBATCH --account=def-lingjzhu


module load StdEnv/2023 apptainer/1.2.4 

# set cache directory
# please change this to your own /sractch
export APPTAINER_CACHEDIR=/home/lingjzhu/scratch/cache/apptainer

# install environment
# please find your own environment from docker hub
apptainer build llm_env.sif docker://pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel
#apptainer build macha_tts.sif docker://ubcslime/macha-tts
#apptainer build mfa.sif docker://mmcauliffe/montreal-forced-aligner
#apptainer build py27.sif docker://python:2.7.18-stretch
