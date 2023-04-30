FROM ghcr.io/icg-software/karaf-base:latest

LABEL maintainer="icgsoftware <j_liepe@icg-software.de>"

ARG KARAF_VERSION=4.2.16

RUN chown karaf.karaf /entrypoint.sh
RUN chown karaf.karaf /opt/karaf/bin/initkaraf

WORKDIR ${KARAF_HOME}
USER karaf

RUN wget https://www.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz && \
    /tmp/installer.sh apache-karaf-${KARAF_VERSION}.tar.gz && \
    rm /tmp/karaf.valid

EXPOSE 1099 8101 8181 44444
