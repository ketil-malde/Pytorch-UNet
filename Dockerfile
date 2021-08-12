# Use an official Python runtime as a parent image
FROM tensorflow/tensorflow:1.15.2-gpu-py3

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

# Run when the container launches
CMD "bash"

