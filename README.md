<div align="center">

## FRP Docker Deploy

<img src="https://img.shields.io/badge/platform-Linux-blue" alt="Platform">
<img src="https://img.shields.io/badge/language-Docker-yellow" alt="Language">

</div>

## 自行编译示例

### FRPS
```
version: '3.8'
services:
  frps:
    image: frp-service:0.61.2
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      - FRP=frps  # 指定运行 frps 服务端
#    volumes:
#      - ./frps.toml:/frp/frps.toml  # 挂载自定义配置
    ports:
      - "7000:7000"
      - "7001:7001"
      - "7500:7500"
      - "7002-7010:7002-7010"
    restart: unless-stopped
```

## 使用docker镜像

### FRPC
```
version: '3.8'
services:
  frpc:
    image: lhyan/frp:0.61.2 # 可使用编译好的镜像
    environment:
      - FRP=frpc
    volumes:
      - ./frpc.toml:/frp/frpc.toml
    restart: unless-stopped
    network_mode: host
```

## Windows服务自启
[下载WinSW](https://github.com/winsw/winsw/releases)

已Frp客户端威例:

修改文件名为`FrpcService`

```shell
FrpcService.exe install
```

打开Windows 服务找到`FrpcService` 点击启动
