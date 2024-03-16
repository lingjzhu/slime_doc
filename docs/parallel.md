### Tracking progress of a parallel job

  ```
from tqdm.contrib.concurrent import process_map

r = process_map(resample_audio, file_list, max_workers=20,chunksize=1)
  ```
