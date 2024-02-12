#!/usr/bin/env bash

function setup_symlinks {
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
}

function setup_forge {
    cd ./stable-diffusion-webui

    # Add Forge repos
    git remote add forge https://github.com/lllyasviel/stable-diffusion-webui-forge
    git fetch forge
    
    # Create Branch
    git branch lllyasviel/main
    git branch -u forge/main

    # Download Forge
    git pull

    cd ../
}


# Download Setup script
if [[ ! -d stable-diffusion-webui ]]
    then
    # Download WebUI
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

    # Create Symboliclinks
    setup_symlinks

    # Confirm Setup WebUI Forge
    read -r -p "WebUI Forge を 使用しますか？[y/N] : " useForge
    if [[ $useForge = [yY] ]]; then
        setup_forge
    fi
fi

# Setup & Launch webui
cd stable-diffusion-webui
. webui.sh