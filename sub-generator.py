import argparse
import os
from datetime import timedelta
import whisper

SUPPORTED_LANGUAGES = ['auto', 'ar', 'bn', 'cmn-CN', 'cs', 'da', 'nl', 'en', 'fil', 'fi', 'fr', 'de', 'el', 'hi', 'hu', 'id', 'it', 'ja', 'ko', 'ms', 'no', 'pl', 'pt', 'ru', 'es', 'sv', 'th', 'tr', 'vi']

def transcribe_audio(input_file: str, output_file: str, model_path: str, language: str):
    try:
        if not os.path.isfile(input_file):
            raise ValueError(f"Input file not found at path {input_file}")

        model = whisper.load_model(model_path)

        if language not in SUPPORTED_LANGUAGES:
            raise ValueError(f"Unsupported language: {language}")
        else:
            if language == "auto": 
                transcribe = model.transcribe(audio=input_file)
            else:
                transcribe = model.transcribe(audio=input_file, language=language) 
        segments = transcribe['segments']
        for segment in segments:
            beginning = str(0) + str(timedelta(seconds=int(segment['start']))) + ',000'
            ending = str(0) + str(timedelta(seconds=int(segment['end']))) + ',000'
            text = segment['text']
            segmentId = segment['id'] + 1
            segment = f"{segmentId}\n{beginning} --> {ending}\n{text[1:] if text[0] == ' ' else text}\n\n"

            with open(output_file, 'a', encoding='utf-8') as srt_file:
                srt_file.write(segment)

        print(f'Successfully generated subtitles at {os.path.abspath(output_file)}')

    except FileNotFoundError as e:
        print(f"File not found: {e}")
    except ValueError as e:
        print(f"Invalid input: {e}")
    except Exception as e:
        print(f'Error occurred during transcription: {e}')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Transcribe audio contents to subtitles using OpenAI Whisper')
    parser.add_argument('input_file', metavar='input', type=str, help='path to input audio file')
    parser.add_argument('-o', '--output', type=str, default='subtitles.srt', help='path to output subtitles file')
    parser.add_argument('-m', '--model', type=str, default='base', help='path to Whisper model checkpoint')
    parser.add_argument('-l', '--language', type=str, default='auto', help='language of the input audio')
    args = parser.parse_args()

    transcribe_audio(args.input_file, args.output, args.model, args.language)
