#!/bin/sh

#移除旧版本docker
yum remove docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine

#安装一些必要的系统工具
yum install -y yum-utils device-mapper-persistent-data lvm2

#添加软件源信息
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

#更新 yum 缓存
yum makecache fast

#安装 Docker-ce
yum -y install docker-ce

#启动 Docker 后台服务
systemctl start docker

#docker加入开机自启动
systemctl enable docker

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "insecure-registries":["192.168.1.188"],
  "registry-mirrors": ["http://192.168.1.188","https://xqy1iuas.mirror.aliyuncs.com"]
}
EOF

systemctl daemon-reload
systemctl restart docker

#下载docket-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.27.1/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
#修改权限
chmod +x /usr/local/bin/docker-compose
