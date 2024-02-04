FROM nvidia/cuda:12.3.1-base-ubuntu22.04

# Install basics
RUN apt update && apt upgrade -y && apt install -y sudo wget git

# Add User
ARG USERNAME
RUN adduser $USERNAME \
    && echo $USERNAME ALL=\(ALL:ALL\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install development tools
RUN apt install -y python3 python3-venv libgl1 libglib2.0-0

# Set `DEVCONTAINER` environment variable to help with orientation
ENV DEVCONTAINER=true