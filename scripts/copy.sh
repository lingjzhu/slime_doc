#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --time=3-00:00
#SBATCH --account=def-lingjzhu


cp -r /source_path /target_path
