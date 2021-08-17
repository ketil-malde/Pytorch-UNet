# Use an official Python runtime as a parent image

# FROM tensorflow/tensorflow:1.15.2-gpu-py3 # Pytorch not compatible with 3090, works for 2080
# FROM nvcr.io/nvidia/pytorch:20.12-py3  # fails to detect GPU, not compat without AVX
# FROM nvidia/cuda:11.0-base # No a6000 support
# FROM nvidia/cuda:11.4.1-cudnn8-runtime-ubuntu20.04 # Imports an old pytorch (no A6000 support)

FROM nvcr.io/nvidia/pytorch:21.07-py3    
# ^ works on nautilus/A6000

# Set the working directory to 
WORKDIR /project

# User configuration - override with --build-arg
ARG user=myuser
ARG group=mygroup
ARG uid=1000
ARG gid=1000

# Some debs want to interact, even with apt-get install -y, this fixes it
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/project

# Install any needed packages from apt
RUN apt-get update && apt-get install -y sudo python3 python3-pip git

# Configure user
RUN groupadd -f -g $gid $user
RUN useradd -u $uid -g $gid $user
RUN usermod -a -G sudo $user
RUN passwd -d $user

COPY . /project
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

# Use v 410 for tensorflow:1.15.2, 460? for pytorch containers
# RUN apt-get install -y nvidia-utils-460

RUN mkdir /project/runs /project/checkpoints
RUN chown $user:$gid runs checkpoints

# Run when the container launches
CMD "bash"

