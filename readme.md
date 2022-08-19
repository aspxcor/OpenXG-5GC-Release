# OpenXG Core Network Installation Instructions



> ## docker 部署

1. 下载源码

   ```shell
   git clone http://git.opensource5g.org/openxg/openxg-5gcs-release.git
   ```

2. 安装docker、docker-compose

   ```shell
   cd openxg-5gcs-release/scripts
   ./install.sh -I
   ```

3. 创建docker网桥

   ```shell
   docker network create docker-openxg --subnet=172.11.200.0/24 -o com.docker.network.bridge.name=docker-openxg
   ```

4. 启动数据库

   ```shell
   cd openxg-5gcs-release/docker-compose
   docker-compose -f docker-mysql.yml up -d
   ```
   以上命令部署了phpmyadmin，通过访问http://本机ip:8080 可以打开。用户名为：yunshou，密码为：123456；
   用户sim卡信息在 Witcomm-DB数据库 users表中。

5. 在基站主机配置到核心网的静态路由

   在基站所在主机中执行以下命令：

   ```shell
   route add -net 172.11.200.0 netmask 255.255.255.0 gw <核心网所在主机的IP>
   ```



> ## 运行

```shell
cd openxg-5gcs-release/docker-compose
docker-compose -f docker-3-network-element.yml up -d  #构建并启动容器
```



> ## 关闭

```shell
cd openxg-5gcs-release/docker-compose
docker-compose -f docker-3-network-element.yml down  #关闭并删除容器
```



> ## 日志

```shell
cd openxg-5gcs-release/docker-compose
docker-compose -f docker-3-network-element.yml logs -f amf  #查看amf日志
docker-compose -f docker-3-network-element.yml logs -f smf  #查看smf日志
docker-compose -f docker-3-network-element.yml logs -f spgwu  #查看spgwu日志
```



> ## 网元配置文件

