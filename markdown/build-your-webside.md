---
title: 使用HEXO和GITHUB部署你自己的网站
date: 2018-02-09 16:26:43
tags: [hexo]
---

制作一个属于自己的博客很有必要，下面我以 hexo 和 github 搭建一个自己的博客。  
我使用的是 fedora 的linux发行版本，其他的linux发行版本或者window系统自动按照如下的，  
“手把手教你使用hexo搭建属于你的个人博客” 进行配置
相关参考网站：
* [手把手教你使用hexo搭建属于你的个人博客](https://segmentfault.com/a/1190000010881712)
* [github 上 markdown 教程](http://blog.csdn.net/kaitiren/article/details/38513715)
* [markdown 语言教程](https://www.appinn.com/markdown/)
* [部署到 github 主题不显示](http://blog.csdn.net/nathan1987_/article/details/50322493)


## 安装必要软件

``` bash
# dnf install -y npm git
```

## 注册相关 github 账号
自行处理这种注册账号问题


## 开始我们的安装

``` bash
# npm install -g hexo-cli
$ hexo init <folder>
$ cd <folder>
$ npm install
```
例如我的 <folder\> 为hexo

配置你的根目录下的 _config.yml 文件， 例如我的为：
``` yml
# URL
## If your site is put in a subdirectory, 
##    set url as 'http://yoursite.com/child' and root as '/child/'
url: https://goto0x00.github.io/web/
root: /web/
permalink: :year/:month/:day/:title/
permalink_defaults:
```

编辑你相关管的 md 文件，就是你自己的文章内容。例如可以使用如下的命令穿件一个博客内容：
``` bash
[dai@fedora hexo]$ hexo new "hello"
```
对应生产呢个的文件在 .../hexo/source/_posts/hello.md
对应的编辑该 md 文件就可以了。

相关的命令有:
+ hexo new      "postName" --新建文章
+ hexo new page "pageName" --新建页面


## 编译发布你的内容
在工程根目录下的 _config.yml 文件的 deploy 节点下添加如下的内容
``` yml
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://github.com/goto0x00/web.git
  branch: master
```
其中 repo 中对应的内容是你自己申请好的 github 账号地址

首次时需要执行如下的命令：
``` bash
$ npm install --save hexo-deployer-git
```

用如下的命令可以执行发布
``` bash
$ hexo d -g
```

如果想本地预览一下生成的页面是如何的，可以执行如下的命令：
``` bash
$ hexo d
$ hexo s
```
然后打开命令中提示的网页地址，一般地都是： http://localhost:4000
