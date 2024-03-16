### Downsampling/Upsampling

Using `librosa` or `torchaudio` for downsampling/upsampling is extremely slow. It can take days or weeks to process Common Voice. `ffmpeg` is recommended for downsampling/upsampling.
First, load `ffmpeg` in the terminal.
```
module load ffmpeg
```
Then you can call the function below to process an audio file.
```
def resample_audio(input_path,output_path):

    command = ['ffmpeg', '-nostdin', '-hide_banner', '-loglevel', 'quiet', '-nostats', '-i',input_path, '-acodec', 'pcm_s16le', '-f', 'wav', '-ar', '16000',output_path]
    subprocess.call(command)
```
You need to parallelize this function over 10+ cores if you have more than 100k audio files.
