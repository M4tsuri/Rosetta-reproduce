# syntax=docker/dockerfile:1

FROM ubuntu:18.04

# set the port 7891 to your own proxy port or remove these lines
ENV https_proxy=http://host.docker.internal:7891
ENV http_proxy=http://host.docker.internal:7891
ENV all_proxy=socks5://host.docker.internal:7891
RUN echo "Acquire::http::Proxy \"$http_proxy\";" > /etc/apt/apt.conf.d/proxy.conf

RUN echo '\
Acquire::Retries "100";\
Acquire::https::Timeout "240";\
Acquire::http::Timeout "240";\
' > /etc/apt/apt.conf.d/99custom

RUN apt-get update && apt-get install -y python3-dev python3-pip libssl-dev cmake git fish xxd
RUN pip3 install --upgrade pip && pip3 install tensorflow==1.14.0

RUN git config --global http.proxy $http_proxy && \
    git config --global https.proxy $https_proxy

WORKDIR /workspace
RUN git clone https://github.com/LatticeX-Foundation/Rosetta.git --recursive
RUN cd Rosetta && ./rosetta.sh compile --enable-protocol-mpc-securenn --enable-protocol-zk && ./rosetta.sh install

VOLUME [ "/workspace" ]
