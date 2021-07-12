#!/bin/sh

    
yum install -y nfs-common nfs-utils  rpcbind 
 
#分配权限
mkdir /home/nfsdata  && chmod 666 /home/nfsdata && chown nfsnobody /home/nfsdata  
 
# 配置挂载
#vim /etc/exports
echo "/home/nfsdata *(rw,no_root_squash,no_all_squash,sync)" > /etc/exports
 
# 启动
systemctl start rpcbind && systemctl start nfs