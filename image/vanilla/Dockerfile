FROM quay.io/devfile/base-developer-image:ubi8-latest
ENV LANG en_US.UTF-8
ENV TZ US/Pacific
ARG DEBIAN_FRONTEND=noninteractive

#Install miniconda
USER root
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh &&  \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN mkdir -p /projects
WORKDIR /projects
RUN sed -i -e 's/\/root/\/projects/g' /etc/passwd

COPY --chown=0:0 entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENV HOME=/home/user
ENTRYPOINT [ "/entrypoint.sh" ]

COPY environment.yml /tmp
RUN conda env create -y -f "/tmp/environment.yml" \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && /opt/conda/bin/conda clean -afy

# Set the conda environment for all subsequent vanilla RUN commands
# When maap-py is updated and installed via our environment.yml,
# we won't need this line unless other envrionment specific commands are added
SHELL ["conda", "run", "-n", "vanilla", "/bin/bash", "-c"]

# Install maap-py library
RUN mkdir /maap-py \
    && git clone --single-branch --branch v3.1.4 https://github.com/MAAP-Project/maap-py.git /maap-py/ \
    && pip install -e /maap-py/

RUN conda list

ARG IMAGE_REF
ENV DOCKERIMAGE_PATH=${IMAGE_REF}




