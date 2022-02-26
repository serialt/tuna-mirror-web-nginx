#!/usr/bin/env bash
# ***********************************************************************
# Description   : IMAU of Serialt
# Version       : 1.0
# Author        : serialt
# Email         : tserialt@gmail.com
# Github        : https://github.com/serialt
# Created Time  : 2022-02-26 23:28:03
# Last modified : 2022-02-27 00:11:54
# FilePath      : /tuna-mirror-web/run.sh
# Other         : 
#               : 
# 
# 
#                 人和代码，有一个能跑就行
# 
# 
# ***********************************************************************


ln -snf /opt/mirror/* /opt/mirror-web/

dumb-init /opt/nginx/sbin/nginx 
