#!/usr/bin/env bash
webUiVersion="1.7.0"

# Download Setup script
if [[ ! -d stable-diffusion-webui ]]
    then
    # Download WebUI
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

    # Create Symboliclinks
    # Outputs
    rm -rf ./stable-diffusion-webui/outputs
    ln -s "$(pwd)"/Outputs/ ./stable-diffusion-webui/outputs
    # Models
    rm -rf ./stable-diffusion-webui/models/Stable-diffusion
    ln -s "$(pwd)"/Models/ ./stable-diffusion-webui/models/Stable-diffusion
    # Lora
    rm -rf ./stable-diffusion-webui/models/Lora
    ln -s "$(pwd)"/Lora/ ./stable-diffusion-webui/models/Lora
    # LyCORIS
    rm -rf ./stable-diffusion-webui/models/LyCORIS
    ln -s "$(pwd)"/LyCORIS/ ./stable-diffusion-webui/models/LyCORIS
    # VAE
    rm -rf ./stable-diffusion-webui/models/VAE
    ln -s "$(pwd)"/VAE/ ./stable-diffusion-webui/models/VAE
    # Negatives
    rm -rf ./stable-diffusion-webui/embeddings
    ln -s "$(pwd)"/Negatives/ ./stable-diffusion-webui/embeddings
    # Extensions
    rm -rf ./stable-diffusion-webui/extensions
    ln -s "$(pwd)"/Extensions/ ./stable-diffusion-webui/extensions
    # Setting Files
    ln -s "$(pwd)"/Settings/params.txt ./stable-diffusion-webui/params.txt
    ln -s "$(pwd)"/Settings/styles.csv ./stable-diffusion-webui/styles.csv
fi

# Setup & Launch webui
cd stable-diffusion-webui
. webui.sh
