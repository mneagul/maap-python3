FROM continuumio/miniconda3:23.10.0-1
ENV LANG en_US.UTF-8
ENV TZ US/Pacific
ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir /projects
WORKDIR /projects
RUN sed -i -e 's/\/root/\/projects/g' /etc/passwd

COPY environment.yml /tmp
RUN conda env create -y -f "/tmp/environment.yml" \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && /opt/conda/bin/conda clean -afy

# Set the conda environment for all subsequent docker RUN commands
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

COPY --chown=0:0 entrypoint.sh /
RUN \
    # add user and configure it
    useradd -u 10001 -G wheel,root -d /home/user --shell /bin/bash -m user && \
    # Setup $PS1 for a consistent and reasonable prompt
    echo "export PS1='\W \`git branch --show-current 2>/dev/null | sed -r -e \"s@^(.+)@\(\1\) @\"\`$ '" >> /home/user/.bashrc && \
    # Set permissions on /etc/passwd and /home to allow arbitrary users to write
    chgrp -R 0 /home && \
    chmod -R g=u /etc/passwd /etc/group /home && \
    chmod +x /entrypoint.sh

ENV HOME=/home/user
WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]