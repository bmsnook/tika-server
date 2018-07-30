FROM centos:latest
RUN gpg --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y nmap-ncat
RUN yum install -y net-tools
RUN yum install -y which

LABEL org.label-schema.schema-version = "1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20180531"

CMD ["/bin/bash"]
