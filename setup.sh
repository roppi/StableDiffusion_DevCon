#!/usr/bin/env bash

# Download Setup script
if [[ ! -d stable-diffusion-webui ]]
    then
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
fi

# Setup & Launch webui
cd stable-diffusion-webui
. webui.sh --xformers
