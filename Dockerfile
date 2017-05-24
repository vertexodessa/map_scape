
FROM ubuntu:16.04

MAINTAINER Ihor Ivlev version: 0.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get clean && apt-get update
RUN apt-get install -y locales apt-utils
RUN locale-gen en_US.UTF-8

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN  apt-get -y install \
          software-properties-common \
          emacs \
          pwgen \
          unzip \
          curl \
          git-core \
          libboost-all-dev g++ gcc libncurses-dev libncursesw5-dev mc pkg-config cmake  g++ gcc libncurses-dev libncursesw5-dev

RUN  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /map_solver/build/

ADD CMakeLists.txt /map_solver/CMakeLists.txt
ADD crafted_map.map /map_solver/crafted_map.map
ADD include /map_solver/include
ADD LICENSE /map_solver/LICENSE
ADD README.md /map_solver/README.md
ADD src /map_solver/src
#ADD test /map_solver/test

WORKDIR /map_solver/build/
RUN cmake ..
RUN cp ../crafted_map.map ./
RUN make -j 9

ENV TERM=xterm
CMD ./MapSolver


