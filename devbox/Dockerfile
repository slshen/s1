FROM debian:bullseye

RUN \
  addgroup --gid 102 docker

# install docker cli
RUN \
  apt-get update && \
  apt-get install -y \
    apt-utils \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
  (curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -) && \
  add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   bullseye \
   stable" && \
  apt-get update && \
  apt-get install -y docker-ce-cli

RUN \
  apt-get install -y ssh git man less traceroute build-essential \
    python3 curl python3-pip jq tig htop sudo vim \
    dnsutils dstat neo4j-client net-tools lsof inetutils-syslogd \
    apt-file && \
  apt-file update

# install amazon corretto
RUN \
  curl -L https://apt.corretto.aws/corretto.key | apt-key add -  && \
  add-apt-repository 'deb https://apt.corretto.aws stable main' && \
  apt-get update && \
  apt-get install -y java-11-amazon-corretto-jdk

COPY run.sh /usr/local/sbin/run.sh
COPY sshd_config /etc/ssh/sshd_config

RUN chmod a+rx /usr/local/sbin/run.sh && \
  echo "%sudo  ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo-nopww

EXPOSE 3028/tcp

ENTRYPOINT [ "/usr/local/sbin/run.sh" ]
