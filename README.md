# Whisper-mpv

whisper-mpv is a project that automates the process of downloading, translating, and generating subtitles for a video, and then playing it with mpv. The project depends on OpenAI Whisper for generating accurate subtitles.

The script uses yt-dlp to download the video and OpenAI's Whisper for generating subtitles in the language of your choice. The generated subtitle file is then passed to mpv for playing the video with subtitles.

## Requirements

To run whisper-mpv, ensure you have the following dependencies installed on your computer:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [mpv](https://mpv.io/)
- [git](https://git-scm.com/)
- [python](https://www.python.org/)
- [pip](https://pypi.org/project/pip/)
- [bash](https://www.gnu.org/software/bash/)

## Installation

To install whisper-mpv, you can use the following command in your terminal:

```
git clone https://github.com/Ramkafasi/whisper-mpv && cd whisper-mpv && chmod +x setup.sh && ./setup.sh
```
## Usage

To use whisper-mpv, run the following command:

```
whisper-mpv.sh "video-url"
```
This command will download, translate and generate subtitles for the video before playing it with mpv.

# Features to be implemented in the next release

The following features will be implemented in the next release:

- `--video` flag to allow the use of whisper-mpv with locally stored files
- `--language` flag to specify a language regardless of the config file's definition
- `--scraper` flag to select a different scraper from yt-dlp

## Contributions

Contributions to this project are welcome. If you would like to contribute, please create a pull request.

## License

This project is licensed under the GNU GPLv3. It utilizes OpenAI Whisper, which is licensed under the MIT License.
