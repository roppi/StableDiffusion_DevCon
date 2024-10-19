#!/usr/bin/env bash

clone_dir=${1:-"stable-diffusion-webui"}

function setup_symlinks {
    # Outputs
    rm -rf "./${clone_dir}/outputs"
    ln -s "$(pwd)/Outputs/" "./${clone_dir}/outputs"
    # Models
    rm -rf "./${clone_dir}/models/Stable-diffusion"
    ln -s "$(pwd)/Models/" "./${clone_dir}/models/Stable-diffusion"
    # Lora
    rm -rf "./${clone_dir}/models/Lora"
    ln -s "$(pwd)/Lora/" "./${clone_dir}/models/Lora"
    # LyCORIS
    rm -rf "./${clone_dir}/models/LyCORIS"
    ln -s "$(pwd)/LyCORIS/" "./${clone_dir}/models/LyCORIS"
    # VAE
    rm -rf "./${clone_dir}/models/VAE"
    ln -s "$(pwd)/VAE/" "./${clone_dir}/models/VAE"
    # Negatives
    rm -rf "./${clone_dir}/embeddings"
    ln -s "$(pwd)/Negatives/" "./${clone_dir}/embeddings"
    # Extensions
    rm -rf ./${clone_dir}/extensions
    ln -s "$(pwd)/Extensions/" "./${clone_dir}/extensions"
    # Setting Files
    ln -s "$(pwd)/Settings/params.txt" "./${clone_dir}/params.txt"
    ln -s "$(pwd)/Settings/styles.csv" "./${clone_dir}/styles.csv"
}


# Download Setup script
if [[ ! -d "${clone_dir}" ]]
    then
    # Download WebUI Forge
    git clone "https://github.com/lllyasviel/stable-diffusion-webui-forge" "${clone_dir}"

    # Create Symboliclinks
    setup_symlinks
fi

# Setup & Launch webui
cd "${clone_dir}"
. webui.sh