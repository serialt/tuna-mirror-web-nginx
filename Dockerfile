# Dockerizing Ubuntu: Dockerfile for building Ubuntu images
#
FROM ubuntu:latest

LABEL mantainer="serialt <tserialt@gmail.com> build a vm image"

#set timezone 
ENV  TZ=Asia/Shanghai
ENV  DEBIAN_FRONTEND=noninteractive
ENV IMAU_DUMP_INIT=1.2.5


# change apt source 
RUN sed -e "s@http://.*archive.ubuntu.com@http://mirrors.aliyun.com@g" \
    -e "s@http://.*security.ubuntu.com@http://mirrors.aliyun.com@g"  \
    -i.bak \
    -i /etc/apt/sources.list

# update package
RUN  apt-get update &&  apt-get upgrade -y && apt-get install -y apt-transport-https ca-certificates gnupg-agent tzdata wget curl vim && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata  && \
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${IMAU_DUMP_INIT}/dumb-init_${IMAU_DUMP_INIT}_x86_64  && \ 
    chmod +x /usr/local/bin/dumb-init


# # change apt source to https
# RUN sed -e "s@http://mirrors.aliyun.com@https://mirrors.aliyun.com@g" \
#     -e "s@http://mirrors.aliyun.com@https://mirrors.aliyun.com@g"  \
#     -i.bak \
#     -i /etc/apt/sources.list



ADD nginx /opt/nginx

ADD nginx.conf  /opt/nginx/conf/
ADD run.sh /opt/



WORKDIR /opt
ENTRYPOINT ["/opt/run.sh"]
