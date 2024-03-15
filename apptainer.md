It is recommended that you use `Apptainer` to manage your local Python environment. 

### Find your environmnet from [Docker Hub](https://hub.docker.com/).

### Load apptainer in your environment
First, you need to load `apptainer` in your environment. Docker is banned on public servers because it needs root access to run. 
```
module load StdEnv/2023 apptainer/1.2.4 
```

### Set up the docker container using Apptainer.   
   For example, if your docker container is `pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel', you can use the command below to pull the docker container. If you are doing machine learning, you can use this container by default.
   ```
   export APPTAINER_CACHEDIR=/home/lingjzhu/scratch/cache/apptainer
   apptainer build local_env.sif docker://pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel
   ```
   The first line sets the cache directory for `Apptainer`. Otherwise cache files will be stored in your `/home` directory. Please avoid storing anything in your `/home` directory.
   Note that this process consumes a lot of memory. Please submit this job through `sbatch`.


### (Optional) If you can't find a docker container that satisfies your need. You can install a virtual enviroment using the above container.
 - Create a temporary home directory
    ```      
    mkdir /project/6080355/lingjzhu/llm/home
    ```
 - Run your container
    ```
    apptainer shell -C --home /project/6080355/lingjzhu/llm/home -W $SLURM_TMPDIR -B /home:/cluster_home -B /project -B /scratch local_env.sif
    ```
 - The step above will start a shell inside this container. You can create a new environment using  `conda`. 
    ```
    conda create -p /project/6080355/lingjzhu/llm/vllm_env --clone base
    ```
    Please check [Anaconda documentation](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#activating-an-environment) to learn about how to create a stand-alone environment.

 - After the environment is created. You can activate this environment using its absolute path.
    ```
    conda init
    source activate /project/6080355/lingjzhu/llm/home/.bashrc
    conda activate /project/6080355/lingjzhu/llm/vllm_env
    ```
 - Now you can use `pip install` to install packages you like.
   ```
   pip install vllm
   ```
   All your newly installed packages and your conda environment should be at   `/project/6080355/lingjzhu/llm/vllm_env`. It is outside the container itself and has no impact on the original container.

### (Optional) If you need a more customized environment than what `conda` can provide, you can also create a docker environment  
Please do everything below on your local computer, where you have root/admin access. 
 - First, write a docker script to set up your environment. For example,
   ```
   FROM ubuntu:22.04
   RUN apt update
   RUN apt install -y git python3-pip libsndfile1
   RUN apt install -y automake autoconf libtool
   RUN git clone https://github.com/rhasspy/espeak-ng && \
       cd espeak-ng && \
       bash autogen.sh && ./configure && make -j8 && make install && \
       ldconfig
   RUN pip install git+https://github.com/shivammehta25/Matcha-TTS.git
   RUN pip install gradio==3.48.0 # Breaks with gradio 4
   CMD ["matcha-tts-app"]
   ```
- Then create a docker image using the above script. Please follow the tutorial [here](https://docs.docker.com/get-started/02_our_app/).
- Upload your docker image to docker hub followings the steps described [here](https://docs.docker.com/get-started/04_sharing_app/). You'll need to register for an account on docker hub.
- Use `Apptainer` to pull this docker image on `Cedar`. See instructions above. 
  
