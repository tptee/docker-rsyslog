FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

# rsyslog
RUN echo "deb http://ppa.launchpad.net/adiscon/v8-stable/ubuntu trusty main" > /etc/apt/sources.list.d/rsyslog-v8-stable.list && \
  apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0x0f6dd8135234bf2b && \
  apt-get update && apt-get install -y rsyslog-elasticsearch

# conf
ADD 80-elasticsearch.conf /etc/rsyslog.d/
RUN sed 's/#$ModLoad imudp/$ModLoad imudp/' -i /etc/rsyslog.conf
RUN sed 's/#$UDPServerRun 514/$UDPServerRun 514/' -i /etc/rsyslog.conf
RUN sed 's/#$ModLoad imtcp/$ModLoad imtcp/' -i /etc/rsyslog.conf
RUN sed 's/#$InputTCPServerRun 514/$InputTCPServerRun 514/' -i /etc/rsyslog.conf

EXPOSE 514/tcp 514/udp

ENTRYPOINT ["/usr/sbin/rsyslogd"]
CMD ["-n"]

