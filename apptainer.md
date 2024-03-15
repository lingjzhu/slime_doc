It is recommended that you use `Apptainer` to manage your local Python environment. 

1. Find your environmnet from [Docker Hub](https://hub.docker.com/);

2. Set up the docker container using Apptainer.   
   For example, if your docker container is `pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel'. You can use the command below to pull the docker container. 
   ```
   export APPTAINER_CACHEDIR=/home/lingjzhu/scratch/cache/apptainer
   apptainer build local_env.sif docker://pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel
   ```
   The first line sets the cache directory for `Apptainer`. Otherwise cache files will be stored in your `/home` directory. Please avoid storing anything in your `/home` directory.
   Note that this process consumes a lot of memory. Please submit this job through `sbatch`.


3. (Optional) If you can find a docker container that satisfies your need. You can install a virtual enviroment using the above container.
 - 3.1. Create a temporary home directory
    ```      
    mkdir /project/6080355/lingjzhu/llm/home
    ```
 - 3.2. Run your container
    ```
    apptainer shell -C --home /project/6080355/lingjzhu/llm/home -W $SLURM_TMPDIR -B /home:/cluster_home -B /project -B /scratch local_env.sif
    ```
 - 3.3. The step above will start a shell inside this container. You can create a new environment using  `conda`. 
    ```
    conda create -p /project/6080355/lingjzhu/llm/vllm_env --clone base
    ```
    Please check [Anaconda documentation](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) to learn about how to create a stand-alone environment.

 - 3.4. After the environment is created. You can activate this environment using its absolute path.
    ```
    conda init
    source activate /project/6080355/lingjzhu/llm/home/.bashrc
    conda activate /project/6080355/lingjzhu/llm/vllm_env
    ```
 - 3.5. Now you can use `pip install` to install packages you like.
   ```
   pip install vllm
   ```
   All your newly installed packages and your conda environment should be at   `/project/6080355/lingjzhu/llm/vllm_env`. It is outside the container itself and has no impact on the original container. 
