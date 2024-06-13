
原作者仓库：<https://github.com/thsrite/MediaLinker>

本项目为自用版。

非容器运行问题请去原作者仓库提issue，请给原作者大佬点赞！

### 部署方式

#### docker部署

```yaml
version: "3.3"
services:
  zmedialinker:
    container_name: zmedialinker
    network_mode: host
    environment:
      - TZ=Asia/Shanghai
      - NGINX_PORT=8091 # 改成你想要的端口
    volumes:
      - ./config:/config # 你需要修改的变量目录
    image: zfhxi/zmedialinker:latest
networks: {}
```

第一次创建容器并启动后，请修改`./config/envs`中的变量，然后重启容器。

### TODO

- [ ] 通过环境变量修改constant-pro.js中的embyPathMapping/plexPathMapping。


### 部分环境配置

主要的变量都在base_config中，如下是原仓库中对环境变量的介绍。本仓库并未测试开启SSL功能，如需开启SSL，请自行添加相应的环境变量并测试。

| 参数            | 是否必填    | 说明                                                                                               |
|---------------|:--------|--------------------------------------------------------------------------------------------------|
| AUTO_UPDATE   | 可选      | 重启自动更新，true/false，默认`false`                                                                      |
| SERVER        | 可选      | 服务端，emby/plex，默认`emby`                                                                           |
| NGINX_PORT    | 可选      | nginx端口，默认`8091`                                                                                 |
| NGINX_SSL_PORT | 可选      | nginx ssl端口，默认`8095`                                                                             |
| REPO_URL      | 可选      | 仓库地址，默认`https://github.com/chen3861229/embyExternalUrl`                                          |
| SSL_ENABLE    | 可选      | 是否开启ssl，true/false，默认`false`                                                                     |
| SSL_CRON      | 可选      | ssl证书更新时间，默认每2小时执行一次                                                                             |
| SSL_DOMAIN    | 可选      | 域名，开启SSL的时候必填                                                                                    |
| 证书路径        | 开启SSL必填 | 映射到宿主机/opt/fullchain.pem                                                                         |
| 证书路径        | 开启SSL必填 | 映射到宿主机/opt/privkey.pem                                                                           |
| 证书申请命令     | 开启SSL必填 | 映射到宿主机/opt/ssl [ssl示例](config%2Fssl)                                                             |

