FROM centos:latest
RUN gpg --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN yum install -y java-1.8.0-openjdk

COPY tika-server-1.18.jar /tika
COPY start-tika.sh /tika
WORKDIR /tika

LABEL org.label-schema.schema-version = "1.0" \
    org.label-schema.name="CentOS Base Image" \
    org.label-schema.vendor="CentOS" \
    org.label-schema.license="GPLv2" \
    org.label-schema.build-date="20180531"

EXPOSE 9998
CMD ["./start-tika.sh"]
