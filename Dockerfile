FROM ubuntu:22.04

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install required tools and Python 3.11
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y \
    python3.11 python3.11-dev python3.11-venv \
    build-essential zip curl && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    pip3.11 install --upgrade pip

# Set working directory
WORKDIR /build

# Copy requirements.txt
COPY requirements.txt .

# Create target folder for layer
RUN mkdir -p python

# Install Python dependencies into the layer folder
RUN pip3.11 install -r requirements.txt -t python/

# Zip the layer
RUN zip -r9 /build/layer.zip python
