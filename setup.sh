#!/bin/bash

# Installation directory for sub-generator.py
sub_gen_dir="${HOME}/.local/share/whisper-mpv"

# Ask user for installation directory preference
echo "Where would you like to install sub-generator.py?"
echo "Press Enter to install in the default directory: ${sub_gen_dir}"
read -p "Installation directory: " user_sub_gen_dir

# Use user preference if available, else use default directory
if [[ ! -z "${user_sub_gen_dir}" ]]; then
    sub_gen_dir="${user_sub_gen_dir}"
fi

# Create installation directory if it doesn't exist
mkdir -p "${sub_gen_dir}"

# Install sub-generator.py
cp sub-generator.py "${sub_gen_dir}/"

# Install whisper
echo "Do you want to install Whisper (y/n)?"
read -p "Installation preference: " install_whisper

if [[ "${install_whisper,,}" == "y" ]]; then
    pip install git+https://github.com/openai/whisper.git
fi

# Install whisper-mpv
echo "Where do you wish to install Whisper-mpv?"
echo "Press Enter to use the default installation directory: ${HOME}/.local/bin/"
read -p "Installation directory: " user_whisper_mpv_dir

# Use user preference if available, else use default directory
if [[ ! -z "${user_whisper_mpv_dir}" ]]; then
    whisper_mpv_dir="${user_whisper_mpv_dir}"
else
    whisper_mpv_dir="${HOME}/.local/bin/"
fi

# Copy whisper-mpv to installation directory
chmod +x "$(pwd)/whisper-mpv"
cp "$(pwd)/whisper-mpv" ${whisper_mpv_dir}

# Ask user for language model preference

model_options=("tiny" "tiny.en" "base" "base.en" "small" "small.en" "medium" "medium.en" "large")
echo "Which language model do you wish to use?"
echo "Options: ${model_options[*]}"

while true; do
    read -p "Language model: " language_model
    
    if [[ -z "$language_model" ]]; then 
        echo "Error: Language model preference is required."
    elif [[ " ${model_options[@]} " =~ " ${language_model} " ]]; then
        language_model="${language_model}"
        break
    else
        echo "Invalid option. Please choose from the list."
    fi
done

# Ask user for preferred language (optional)
language_options=("ar" "bn" "cmn-CN" "cs" "da" "nl" "en" "fil" "fi" "fr" "de" "el" "hi" "hu" "id" "it" "ja" "ko" "ms" "no" "pl" "pt" "ru" "es" "sv" "th" "tr" "vi")

echo "Submit the language that you prefer to use."
echo "If you want this script to detect the language automatically, leave this part empty."
echo "Options: ${language_options[*]}"

while true; do
    read -p "Preferred language: " preferred_language
    
    if [[ -z "$preferred_language" ]]; then
        echo "Language will be detected automatically."
        preferred_language="auto"
	break
    elif [[ " ${language_options[@]} " =~ " ${preferred_language} " ]]; then
        echo "Preferred language is $preferred_language."	
        preferred_language="${preferred_language}"
        break
    else
        echo "Invalid option. Please choose from the list."
    fi
done

# Create configuration file
echo "# Whisper-mpv configuration file" > "${HOME}/.config/whisper-mpv.conf"
echo "WHISPER_MPV_LOCATION=${sub_gen_dir}" >> "${HOME}/.config/whisper-mpv.conf"
echo "WHISPER_MODEL=${language_model}" >> "${HOME}/.config/whisper-mpv.conf"
echo "LANGUAGE=${preferred_language}" >> "${HOME}/.config/whisper-mpv.conf"

# Add configuration file location to .bashrc
echo "export WHISPER_MPV_CONF=${HOME}/.config/whisper-mpv.conf" >> "${HOME}/.bashrc"

# Check if $whisper_mpv_dir is in the PATH and add it if it's not
if [[ ":$PATH:" != *":$whisper_mpv_dir:"* ]]; then
    echo "Adding ${whisper_mpv_dir} to PATH"
    echo 'export PATH="'"${whisper_mpv_dir}"':$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi
