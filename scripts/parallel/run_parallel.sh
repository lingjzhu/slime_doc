#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=12G
#SBATCH --time=3-00:00
#SBATCH --account=def-lingjzhu

module load StdEnv/2020  gcc/9.3.0  cuda/11.4
module load arrow/13.0.0

cat filelist.txt | xargs -n 1 -p 4 bash call_python.sh
