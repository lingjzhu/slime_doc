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
You can also use `xargs` to parallelize your script. This is usually better than using Python functions to parallelize because `xargs` will simply skip all errors and proceed to the next file/process. This makes your script fault-tolerant.

If you have [a list of files](../scripts/parallel/files) to process, you can first generate a list of all your files as a `.txt` file, with one file per line, like this [filelist.txt](../scripts/parallel/filelist.txt). 

Then you can write a [Python script](../scripts/parallel/process_a_file.py) to process one file. `argparse` is used so that this script can accept a command line argument as an input. 

Then you need [a bash script](../scripts/parallel/call_python.sh) to call your Python script. The `$1` means the first argument passed to this batch script. Here a file path will be passed to this bash script and this argument will immediately be passed to the Python script. 

Finally, we parallel this bash script using `xargs`, as in [this bash script](../scripts/parallel/run_parallel.sh).
```
cat filelist.txt | xargs -n 1 -P 4 bash call_python.sh
```

 - `cat filelist.txt` prints all content of `filelist.txt`
 - `|` means passing the output of its left shell command as the input to its right shell command.
 - calling `xargs` launches multiple parallel processes
   - `-n 1` means accepting one line of the output from `cat filelist.txt`. In this context, it's one file path.
   - `-P 4` means launches 4 parallel processes
   - `bash call_python.sh` calls the bash script. In addition to calling this bash script, `xargs` also passes one file path as an argument to `call_python.sh`. This file path is the `$1` inside `call_python.sh`.
   - When you submit your job script, please request as many cpu cores as the number of processes specified in `xargs`. 




### Using Ray

A tutorial is available [here](https://docs.ray.io/en/latest/ray-core/examples/gentle_walkthrough.html).

```
import ray
ray.init()
```

```
@ray.remote
def retrieve_task(item):
    return retrieve(item)

start = time.time()
object_references = [
    retrieve_task.remote(item) for item in range(8)
]
data = ray.get(object_references)
print_runtime(data, start)
```
