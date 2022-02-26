#!/usr/bin/env bash
# ***********************************************************************
# Description   : IMAU of Serialt
# Version       : 1.0
# Author        : serialt
# Email         : serialt@qq.com
# Github        : https://github.com/serialt
# Created Time  : 2022-02-24 23:26:51
# Last modified : 2022-02-27 00:42:22
# FilePath      : /tuna-mirror-web/build.sh
# Other         : 
#               : 
# 
# 
#                 人和代码，有一个能跑就行
# 
# 
# ***********************************************************************



export IMAU_NGINX_VERSION="1.20.2"
export IMAU_NGINX_fancyindex="0.5.2"
export IMAU_NJS="0.6.2"
export IMAU_DUMP_INIT=1.2.5





download(){
    cd /tmp/
    wget https://github.com/aperezdc/ngx-fancyindex/releases/download/v${IMAU_NGINX_fancyindex}/ngx-fancyindex-${IMAU_NGINX_fancyindex}.tar.xz
    wget https://nginx.org/download/nginx-${IMAU_NGINX_VERSION}.tar.gz
    wget https://github.com/nginx/njs/archive/refs/tags/0.6.2.tar.gz
    tar -xf 0.6.2.tar.gz && tar -xf nginx-${IMAU_NGINX_VERSION}.tar.gz && ngx-fancyindex-${IMAU_NGINX_fancyindex}.tar.xz
    wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${IMAU_DUMP_INIT}/dumb-init_${IMAU_DUMP_INIT}_x86_64 
    chmod +x /usr/local/bin/dumb-init
}

build(){
    
    cd /tmp/nginx-${IMAU_NGINX_VERSION} 
    ./configure --prefix=/opt/nginx \
                --with-pcre --with-http_auth_request_module \
                --with-http_ssl_module --with-http_v2_module \
                --with-http_realip_module --with-http_addition_module \
                --with-http_sub_module --with-http_dav_module \
                --with-http_flv_module --with-http_mp4_module \
                --with-http_gunzip_module --with-http_gzip_static_module \
                --with-http_random_index_module --with-http_secure_link_module\
                 --with-http_stub_status_module  --with-mail \
                 --with-mail_ssl_module  --with-stream --with-stream_ssl_module \
                 --with-stream_realip_module \
                 --add-dynamic-module=/tmp/ngx-fancyindex-${IMAU_NGINX_fancyindex} \
                 --add-dynamic-module=/tmp/njs-${IMAU_NJS}/nginx

    
}

download
build

