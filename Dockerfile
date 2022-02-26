FROM rockylinux:8.5 as build-env

LABEL mantainer="serialt <tserialt@gmail.com> build tuna web image"


# change repo to aliyun
RUN  sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-*.repo && \
    yum -y install epel-release && sed -e "s|^metalink|#metalink|g" \
    -e "s|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com/|g" \
    -i.bak \
    -i /etc/yum.repos.d/epel*.repo

RUN  yum -y update && yum install glibc  autoconf  make xz openssl  openssl-devel gcc gcc-c++ wget -y && yum -y install  libxslt-devel -y gd gd-devel GeoIP GeoIP-devel pcre pcre-devel


ADD build.sh /opt/
RUN bash /opt/build.sh

ADD nginx.conf  /opt/nginx/conf/


FROM rockylinux:8.5

LABEL mantainer="serialt <tserialt@gmail.com> build tuna web image"

# change repo to aliyun
RUN  sed -e 's|^mirrorlist=|#mirrorlist=|g' \
    -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
    -i.bak \
    /etc/yum.repos.d/Rocky-*.repo && \
    yum -y install epel-release && sed -e "s|^metalink|#metalink|g" \
    -e "s|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com/|g" \
    -i.bak \
    -i /etc/yum.repos.d/epel*.repo

RUN yum -y update

COPY --from=build-env /opt /opt
COPY --from=build-env /usr/local/bin/dumb-init /usr/local/bin/dumb-init
ENV LANG=en_US.UTF-8
ENV TZ="Asia/Shanghai"



WORKDIR /root
ENTRYPOINT ["/opt/run.sh"]
