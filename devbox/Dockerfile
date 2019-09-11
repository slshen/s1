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

COPY run.sh /usr/local/sbin/run.sh

RUN chmod a+rx /usr/local/sbin/run.sh

EXPOSE 222/tcp

ENTRYPOINT [ "/usr/local/sbin/run.sh" ]

