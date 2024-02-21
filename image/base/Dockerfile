FROM continuumio/miniconda3:23.10.0-1
ENV LANG en_US.UTF-8
ENV TZ US/Pacific
ARG DEBIAN_FRONTEND=noninteractive

ENV BASE_IMAGE_TYPE=vanilla
ENV WORKSPACE_TYPE=vanilla

RUN mkdir -p /projects
WORKDIR /projects
RUN sed -i -e 's/\/root/\/projects/g' /etc/passwd


SHELL ["conda", "run", "-n", "vanilla", "/bin/bash", "-c"]

ADD . /


USER root

RUN conda config --system --add channels conda-forge
RUN conda config --system --remove channels defaults

# Install additional libraries required by Python packages which are in
# the minimal base image. Also install 'rsync' so the 'oc rsync' command
# can be used to copy files into the running container.
RUN apt-get clean && apt-get update && \
    apt-get install -y --no-install-recommends rsync gcc python3 vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY environment.yml /tmp

RUN conda env update --file "/tmp/environment.yml"

RUN npm install typescript -g

# Adjust permissions on home directory so writable by group root.
RUN chgrp -Rf root /home/$NB_USER && chmod -Rf g+w /home/$NB_USER

# Grant access to jupyterlab config files for base url rewriting
RUN chmod a+rwx -R /opt/conda/lib/python*/site-packages/

# Adjust permissions on /etc/passwd so writable by group root.
RUN chmod g+w /etc/passwd

###############################
# Non Custom Jupyter Extensions
###############################
RUN jupyter labextension install --no-build jupyterlab-plotly@5.5.0
RUN jupyter labextension disable @jupyterlab/apputils-extension:announcements

###############################
# Custom Jupyter Extensions
###############################
RUN jupyter labextension install @maap-jupyterlab/dps-jupyter-extension@0.5.2 --no-build

# PyPi package prepended with 'maap' so it more easily discoverable
RUN pip install maap-jupyter-server-extension==1.2.2
RUN jupyter server extension enable jupyter_server_extension

RUN jupyter labextension install @maap-jupyterlab/algorithms_jupyter_extension@0.2.0 --no-build
RUN jupyter labextension install @maap-jupyterlab/umf-jupyter-extension@1.0.0 --no-build
RUN jupyter labextension install @maap-jupyterlab/maap-libs-jupyter-extension@1.0.2 --no-build
RUN jupyter labextension install @maap-jupyterlab/edsc-jupyter-extension@1.0.4 --no-build
RUN jupyter labextension install @maap-jupyterlab/user-workspace-management-jupyter-extension@0.0.5 --no-build
RUN jupyter labextension install @maap-jupyterlab/maap-help-jupyter-extension@1.0.1 --no-build
RUN jupyter labextension install @maap-jupyterlab/che-sidebar-visibility-jupyter-extension@1.0.1 --no-build

RUN jupyter lab build && \
    jupyter lab clean && \
    jlpm cache clean && \
    npm cache clean --force && \
    rm -rf $HOME/.node-gyp && \
    rm -rf $HOME/.local

RUN find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy && \
    npm cache clean --force

# Install maap-py library
RUN mkdir /maap-py \
    && git clone --single-branch --branch v3.1.4 https://github.com/MAAP-Project/maap-py.git /maap-py/ \
    && pip install -e /maap-py/

COPY ./entrypoint.sh /entrypoint.sh
COPY ./jupyter_patch /opt/jupyter_patch

ENV ENVIRONMENTS_FILE_PATH=/opt/environments.json
COPY ./environments.json $ENVIRONMENTS_FILE_PATH

RUN echo 'printf "\e[101mNOTE: This terminal uses the default environment which might not be the same as your notebook.\e[49m\n\n"' >> /etc/profile

RUN conda list

# Reset Shell
SHELL ["/bin/sh", "-c"]

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]