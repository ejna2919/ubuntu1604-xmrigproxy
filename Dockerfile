FROM       ubuntu:16.04
MAINTAINER Mark Well "https://www.markwell.com"

RUN apt-get update

RUN apt-get install -y wget supervisor vim-tiny iputils-ping tmux bsdmainutils
WORKDIR /root
RUN wget --no-check-certificate https://github.com/xmrig/xmrig-proxy/releases/download/v2.6.5/xmrig-proxy-2.6.5-xenial-amd64.tar.gz \
-O  xmrig-proxy-2.6.5-xenial-amd64.tar.gz \
&& tar zxvpf xmrig-proxy-2.6.5-xenial-amd64.tar.gz \
&& rm xmrig-proxy-2.6.5-xenial-amd64.tar.gz

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
ADD supervisord.conf /etc/supervisord.conf
RUN rm -rf /root/xmrig-proxy-2.6.5/config.json
ADD config.json /root/xmrig-proxy-2.6.5/config.json

EXPOSE 3333
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
    

