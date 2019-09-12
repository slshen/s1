FROM debian:stretch

RUN \
  addgroup --gid 102 docker

# install docker cli
RUN \
  apt-get update && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
  (curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -) && \
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   stretch \
   stable" && \
  apt-get update && \
  apt-get install -y docker-ce-cli

RUN \
  apt-get install -y ssh git man less traceroute build-essential \
    python3 curl python3-pip jq tig htop sudo

# install amazon corretto
RUN \
  curl -L -o /tmp/amazon-corretto.deb https://d3pxv6yz143wms.cloudfront.net/11.0.4.11.1/java-11-amazon-corretto-jdk_11.0.4.11-1_amd64.deb && \
  apt-get install -y java-common && \
  dpkg -i /tmp/amazon-corretto.deb

RUN \
  apt-get install -y dnsutils dstat neo4j-client net-tools lsof inetutils-syslogd

RUN \
  apt-get install -y apt-file && \
  apt-file update

COPY run.sh /usr/local/sbin/run.sh
COPY sshd_config /etc/ssh/sshd_config

RUN chmod a+rx /usr/local/sbin/run.sh && \
  echo "%sudo  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo-nopww

EXPOSE 222/tcp

ENTRYPOINT [ "/usr/local/sbin/run.sh" ]

