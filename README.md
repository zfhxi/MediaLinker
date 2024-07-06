
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
    restart: always
networks: {}
```

第一次创建容器并启动后，请修改`./config/envs`中的变量，然后重启容器（envs.template只是一个示例模板，不用修改）。

> 注：
> - 在升级镜像时，`./config/envs`不会被覆盖，建议比对`envs`和`envs.template`的差异，按需来添加新版镜像带来的环境变量（比如RouteRule、MediaPathMapping）。
> - emby和jellyfin是同样的配置方式，只需要把部署的jellyfin当作emby来配合本项目使用。

### TODO

- [x] 通过环境变量修改constant-pro.js中的mediaPathMapping。
