conda init
source activate /project/6080355/lingjzhu/llm/home/.bashrc
conda activate /project/6080355/lingjzhu/llm/vllm_env

nvidia-smi

python /project/6080355/lingjzhu/llm/serve.py
