# To build:
# docker build -t toast_ubuntu --build-arg CMBS4USER --rm=true .

# To start:
# hostname="`hostname -s`-docker"
# DOCKER_IMA=toast_ubuntu:latest
# docker run -ti -h $hostname -v $HOME/home-cmbs4:/home/$CMBS4USER $DOCKER_IMA bash

# Clean up:
# docker rm $(docker ps -a -q)

FROM ubuntu:20.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install -y wget emacs git
RUN apt-get install -y cmake
RUN apt-get install -y python3-numpy python3-scipy python3-astropy
RUN apt-get install -y python3-numexpr python3-healpy ipython3
RUN apt-get install -y python3-fitsio python3-yaml
RUN apt-get install -y python3-pandas
RUN apt-get install -y python-is-python3
RUN apt-get install -y fftw3 libfftw3-dev libblas-dev liblapack-dev
RUN apt-get install -y python3-dev libpython3.8-dev
RUN apt-get install -y python3-setuptools python3-h5py
RUN apt-get install -y python3-magic

# Need to use pip3 for tomlkit and traitlets newer version
RUN apt-get install -y python3-pip
RUN pip3 install tomlkit traitlets==5.1.1 pshmem

# # Update cmake
RUN apt-get remove -y --purge cmake
WORKDIR /usr/local
RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0-rc2/cmake-3.23.0-rc2-linux-x86_64.sh
RUN chmod +x cmake-3.23.0-rc2-linux-x86_64.sh &&\
    bash ./cmake-3.23.0-rc2-linux-x86_64.sh --skip-license

# Clone and install toast
ARG TOAST_VERSION
RUN mkdir -p /opt/toast
RUN git clone https://github.com/hpc4cmb/toast.git && \
    cd toast && \
    git checkout toast3 && \
    git checkout $TOAST_VERSION && \
    mkdir build && \
    cd build && \
    ../platforms/linux-gcc.sh -DCMAKE_INSTALL_PREFIX=/opt/toast && \
    make -j 4 && \
    make install

# Copy the script
COPY docker/run_toast_healpix_coadd /usr/local/bin

ENV PATH $PATH:/opt/toast/bin
ENV PYTHONPATH /opt/toast/lib/python3.8/site-packages:${PYTHONPATH}

RUN echo "export PATH=$PATH:/opt/toast/bin" > /opt/toast/set_toast.sh && \
    echo "export PYTHONPATH=/opt/toast/lib/python3.8/site-packages:\${PYTHONPATH}" >> /opt/toast/set_toast.sh

# Add $CMBS4USER as user and create groups wheel and spt
ARG CMBS4USER
RUN useradd -ms /bin/bash -u 1001 $CMBS4USER && \
    addgroup wheel && \
    addgroup -gid 1003 cmbs4

# Add CMBS4USER to wheel and spt
RUN usermod -aG wheel $CMBS4USER && \
    usermod -aG cmbs4 $CMBS4USER

ENV USER $CMBS4USER
ENV HOME /home/$CMBS4USER
ENV SHELL /bin/bash

USER $CMBS4USER
WORKDIR /home/$CMBS4USER
