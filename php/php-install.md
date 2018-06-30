这介绍一些如何在linux系统上组合 nginx 和 php

# 在 debian 系统上安装

## 安装相关需要的软件

```shell
apt-get install -y php php-all-dev php-http php-uuid 
apt-get install -y libapache2-mod-php7.2 php7.2 php7.2-bcmath php7.2-cgi php7.2-bz2 php7.2-cli php7.2-common
apt-get install -y php7.2-curl php7.2-dev php7.2-fpm php7.2-json php7.2-mbstring php7.2-mysql php7.2-intl 
apt-get install -y php7.2-opcache php7.2-pspell php7.2-soap php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xmlrpc
apt-get install -y php7.2-xsl php7.2-zip

# 正则表达式库 pcre
apt-get install -y libpcre++-dev libpcre2-dev libpcre3 libpcre3-dev

# openssl
apt-get install -y libssl-ocaml libssl-ocaml-dev libssl-dev openssl libssl1.1

# debian net tool
apt-get install net-tools

```

## 安装 nginx 

### 获取 nginx 源代码
1. 下载地址 http://nginx.org/en/download.html
2. 编译 nginx， 相关 configurate 文档地址 
   + http://nginx.org/en/docs/
   + http://nginx.org/en/docs/install.html
   + http://nginx.org/en/docs/configure.html
3. 实例 configurate

```config
./configure --prefix=/home/dai/bin/nginx/ \
            --with-threads \
            --with-http_ssl_module \
            --with-http_v2_module \
            --with-http_gunzip_module \
            --with-pcre
```

### 相关配置

#### php7.x-fpm 配置

修改 /etc/php/7.2/fpm/pool.d/www.conf

```config
;listen = /run/php/php7.2-fpm.sock
listen = 127.0.0.1:9000
```

#### 启动 php7.x-fpm

上面已经设置了相关的坚挺端口为 9000, 但是并未有启动起来，如果启动起来呢？

```shell
debian:bin# /usr/sbin/php-fpm7.2 -h
Usage: php-fpm7.2 [-n] [-e] [-h] [-i] [-m] [-v] [-t] [-p <prefix>] [-g <pid>] [-c <file>] [-d foo[=bar]] [-y <file>] [-D] [-F [-O]]
  -c <path>|<file> Look for php.ini file in this directory
  -n               No php.ini file will be used
  -d foo[=bar]     Define INI entry foo with value 'bar'
  -e               Generate extended information for debugger/profiler
  -h               This help
  -i               PHP information
  -m               Show compiled in modules
  -v               Version number
  -p, --prefix <dir>
                   Specify alternative prefix path to FastCGI process manager (default: /usr).
  -g, --pid <file>
                   Specify the PID file location.
  -y, --fpm-config <file>
                   Specify alternative path to FastCGI process manager config file.
  -t, --test       Test FPM configuration and exit
  -D, --daemonize  force to run in background, and ignore daemonize option from config file
  -F, --nodaemonize
                   force to stay in foreground, and ignore daemonize option from config file
  -O, --force-stderr
                   force output to stderr in nodaemonize even if stderr is not a TTY
  -R, --allow-to-run-as-root
                   Allow pool to run as root (disabled by default)
```

从上面的帮助文档可知道，启动时使用 /usr/sbin/php-fpm7.2 -R 进行启动。 通过相关的 service 的启动方式，后续补上
可以使用命令 `netstat -an | grep 9000` 查看相关的端口是否已经绑定


#### nginx 的相关配置

本文前面已经阐述过，相关的 nginx 安装目录在 /home/dai/bin/nginx, 所以我们相关的配置文件也就是在该文件夹下。
进入 `/home/dai/bin/nginx/conf` 进行如下的操作

```shell
cp nginx.conf nginx.conf.bk
cp nginx.conf.default nginx.conf
```

修改 nginx.conf 打开相关的操作如下的内容

```config
    server {
        listen       8080;
        server_name  localhost;

        ......

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ \.php$ {
            root           html;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            #fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
    }
```


## 相关参考网页地址

+ https://wiki.debian.org/nginx/FastCGI
+ https://blog.csdn.net/heluan123132/article/details/73468084
+ https://cuijunwei.com/2226
+ https://blog.csdn.net/icandoit_2014/article/details/71454481

