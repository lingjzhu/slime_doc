from huggingface_hub import snapshot_download


while True:
    try:
        snapshot_download(repo_id="UBC-SLIME/allthetropes", repo_type="dataset", local_dir="/project/6080355/lingjzhu/fandom",local_dir_use_symlinks=False,resume_download=False,max_workers=1)
        break
    except:
        continue
