`webdataset` format is strongly recommended for any training dataset > 50 GB. It is simple, portable and scalable. 

A good tutorial of `webdataset` from `speechbrain` is available [here](https://colab.research.google.com/drive/1s171JSA53_ktvc1zQp6uMcM0TChtCcZ9?usp=sharing).

### Format
```
> tar -t data-archives/shard-0000.tar
spk1-utt1.wav
spk1-utt1.txt
spk1-utt1.json
spk1-utt2.wav
spk1-utt2.txt
spk1-utt2.json
spk2-utt1wav
spk2-utt1.txt
spk2-utt1.json
...
```

### Loading
`webdataset` can be loaded as an `IterableDataset` in `torch`
```
import webdataset as wds  # Note the typical import shorthand
dataset = (
      wds.WebDataset("data-archives/shard-00{00...24}.tar")  # 25 shards
      .decode()  # Automagically decode files
      .shuffle(size=1000)  # Shuffle on-the-fly in a buffer
      .batch(batchsize=10)  # Create batches
)
```
