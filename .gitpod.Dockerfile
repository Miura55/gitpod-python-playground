FROM python:3.12-slim

USER root:root

RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set up the workspace
RUN mkdir -p /workspace
ARG USERNAME=gitpod
ARG USER_UID=33333
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME
WORKDIR /workspace
RUN chown -R gitpod:gitpod /workspace
USER gitpod:gitpod
