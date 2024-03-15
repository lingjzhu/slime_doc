#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gpus-per-node=v100l:1
#SBATCH --ntasks-per-node=8
#SBATCH --mem=32G
#SBATCH --time=1-00:00
#SBATCH --account=def-lingjzhu

module load StdEnv/2023 apptainer/1.2.4
# set cache directory
export APPTAINER_CACHEDIR=/home/lingjzhu/scratch/cache/apptainer
export HF_DATASETS_CACHE=/home/lingjzhu/scratch/cache/huggingface
export TRANSFORMERS_CACHE=/home/lingjzhu/scratch/cache/huggingface

apptainer run -C --nv --home /project/6080355/lingjzhu/llm/home -W $SLURM_TMPDIR -B /home:/cluster_home -B /project -B /scratch llm_env.sif bash /project/6080355/lingjzhu/llm/execute.sh
