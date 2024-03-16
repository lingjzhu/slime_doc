### Tracking progress of a parallel job

You can parallelize your job with `process_map`, which also gives you a progress bar. Note that this is mostly for a small-scale job. It is not recommended for large-scale jobs.
  ```
from tqdm.contrib.concurrent import process_map
# some functions and some lists of files
...
r = process_map(resample_audio, file_list, max_workers=20,chunksize=1)
  ```

Save this script as `parallel_resample.py`. Then you can call this parallelized job using the slurm job script below.
```
#!/bin/bash
#SBATCH --account=def-lingjzhu
#SBATCH --ntasks=20               # number of processes
#SBATCH --mem-per-cpu=2G      # memory; default unit is megabytes
#SBATCH --time=1-00:00  

#module load python/3.9.6
#pip install librosa tqdm

python parallel_resample.py
```

Note that `max_workers` should be the same as `--ntasks`. 

### Parallelization using `xargs`
