FROM continuumio/miniconda3:23.10.0-1

RUN mkdir -p /projects
WORKDIR /projects
RUN sed -i -e 's/\/root/\/projects/g' /etc/passwd



COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV HOME=/home/user
#ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
ENTRYPOINT [ "/entrypoint.sh" ]
#CMD ["tail", "-f", "/dev/null"]