# FLAC to MP3 converter

The following script is used to convert a folder of FLAC audio files to a new folder of MP3 files. It can take a folder with nested directories (e.g. `artist/album1` and `artist/album2`) and replicate the same structure in MP3 format.

Suggested usage:
```
bash flac2mp3.sh flac_directory_path output_directory_path
```
`flac_directory_path` would usually contain various other folders with FLAC files (this also supports nested structures, e.g. `artist/album1/track1.flac`, `artist/album2/CD1/track2.flac`). After execution, in the path at `output_directory_path` one can find a folder named `mp3_converted` where all the converted files reside.

**Note:** the script requires the `ffmpeg` package. This is automatically installed with Homebrew if not present but it is preferable that the user installs it beforehand with their selected package manager.

The script is rather unoptimised (e.g. requires a move of the whole mp3 directory) so feel free to contribute.