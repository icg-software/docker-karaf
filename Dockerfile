FROM spalarus/centos-jdk-hybrid:8

MAINTAINER spalarus <s.palarus@gmail.com>

ENV KARAF_VERSION=4.1.3
ENV KARAF_HOME=/opt/karaf

ADD ./entrypoint.sh /entrypoint.sh
ADD ./initkaraf /opt/karaf/bin/initkaraf

RUN groupadd -r karaf -g 1001 && useradd -u 1001 -r -g karaf -m -d /opt/karaf -s /sbin/nologin \ 
    -c "Karaf user" karaf && chmod 755 /opt/karaf && \
    wget http://www-us.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz && \
    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz && \
    rm apache-karaf-${KARAF_VERSION}.tar.gz && \
    chmod u+x /entrypoint.sh && \
    chmod u+x /opt/karaf/bin/initkaraf && \
    chown -R karaf /opt/karaf

USER karaf

WORKDIR ${KARAF_HOME}
ENV OSGI_IMPLEMENTATION=
ENV FETCH_CUSTOM_URL=
ENV KARAF_INIT_COMMANDS=

VOLUME ["/opt/karaf/deploy","/opt/karaf/etc","/opt/karaf/data"]
EXPOSE 1099 8101 8181 44444
ENTRYPOINT ["/entrypoint.sh"]

# Define default command.
CMD ["/opt/karaf/bin/karaf"] 

