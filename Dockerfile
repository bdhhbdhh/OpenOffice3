FROM centos:7

ARG OO_VERSION=3.4.1
ARG OO_LANG=zh-CN
ARG OO_TGZ_URL="http://archive.apache.org/dist/incubator/ooo/files/localized/${OO_LANG}/${OO_VERSION}/Apache_OpenOffice_incubating_${OO_VERSION}_Linux_x86-64_install-rpm_${OO_LANG}.tar.gz"

ENV OPENOFFICE_DAEMON_PORT=8100
ENV APP_ROOT=/opt/app-root
ENV PATH=${APP_ROOT}/bin:${PATH} HOME=${APP_ROOT}

RUN (curl -0 $OO_TGZ_URL | tar -zx -C /tmp) && \
    yum install -y java && \
    yum localinstall -y /tmp/${OO_LANG}/RPMS/*.rpm && \
    yum clean all -y && \
    rm -rf /tmp/${OO_LANG}

COPY bin/ ${APP_ROOT}/bin/

RUN chmod -R u+x ${APP_ROOT}/bin && \
    chgrp -R 0 ${APP_ROOT} && \
    chmod -R g=u ${APP_ROOT} /etc/passwd
    
### Containers should NOT run as root as a good practice
USER 10001
WORKDIR ${APP_ROOT}

EXPOSE ${OPENOFFICE_DAEMON_PORT}

ENTRYPOINT [ "uid_entrypoint" ]
CMD run
