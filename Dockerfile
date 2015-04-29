FROM debian:jessie
MAINTAINER Grzegorz Bizon "grzegorz.bizon@ntsn.pl"

# Install important packages
ENV DEBIAN_FRONTEND noninteractive
RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends && \
    echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends
RUN apt-get update && apt-get upgrade -y # update_2015043001
RUN apt-get install -y wget curl ca-certificates vim lsb-release && apt-get clean

# Install rethinkdb
RUN \
echo "deb http://download.rethinkdb.com/apt `lsb_release -cs` main" | tee /etc/apt/sources.list.d/rethinkdb.list && \
wget -qO- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \
apt-get update && \
apt-get install -y rethinkdb

# Define mountable workdir
VOLUME ["/data"]
WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]
EXPOSE 8080
EXPOSE 28015
EXPOSE 29015
