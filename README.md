# Description
whisper-mpv is a project that automates the process of downloading, translating, and generating subtitles for a video, and then playing it with mpv. The project depends on OpenAI Whisper for generating accurate subtitles.

The script uses yt-dlp to download the video and OpenAI's Whisper for generating subtitles in the language of your choice. The generated subtitle file is then passed to mpv for playing the video with subtitles.

## Requirements
This project uses the following dependencies:
- yt-dlp
- mpv
- git
- python
- pip
- bash

## Installation
```bash
git clone https://github.com/Ramkafasi/whisper-mpv && cd whisper-mpv && chmod +x setup.sh && ./setup.sh
```
# Features to be implemented in the next release
--video flag for using whisper-mpv with locally stored files
--language flag for specifying a language regardless of the config files definition
--scraper flag for selecting different scraper from yt-dlp

# Copyright
This project is being created by Ramkafasi and it's licensed under GNU GPLv3

This project uses OpenAI's Whisper for generating accurate subtitles. OpenAI Whisper is licensed under MIT.

# Contributions
Contributions to this project are welcome. If you would like to contribute, please create a pull request.
