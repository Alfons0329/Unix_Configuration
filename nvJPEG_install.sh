#!/bin/bash

get_file(){
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
    sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda-repo-ubuntu1804-11-0-local_11.0.2-450.51.05-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu1804-11-0-local_11.0.2-450.51.05-1_amd64.deb
    sudo apt-key add /var/cuda-repo-ubuntu1804-11-0-local/7fa2af80.pub
    sudo apt-get update
    sudo apt-get -y install cuda-11
}

configure(){
    export PATH=$PATH:/usr/local/cuda-11.0/bin
    export CUDADIR=/usr/local/cuda-11.0
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.0/lib64
}

make_folder(){
    cd ~/Documents/drivers/
    if [ ! -d CUDALibrarySamples ]
    then
        git clone git@github.com:NVIDIA/CUDALibrarySamples.git
    fi
    mkdir -p ~/Documents/drivers/CUDALibrarySamples/nvJPEG/nvJPEG-Decoder/build
}

do_make(){
    cd ~/Documents/drivers/CUDALibrarySamples/nvJPEG/nvJPEG-Decoder/build
    cmake ..
    cd ~/Documents/drivers/CUDALibrarySamples/nvJPEG/nvJPEG-Decoder/build
    make -j16
}

make_folder
configure
do_make
