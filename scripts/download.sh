#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=4G
#SBATCH --time=3-00:00
#SBATCH --account=def-lingjzhu

module load StdEnv/2020  gcc/9.3.0  cuda/11.4
module load arrow/13.0.0


cd /project/6080355/lingjzhu/fandom

pip install huggingface_hub --upgrade
pip install datasets --upgrade

python download.py  
