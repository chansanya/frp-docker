<center>
  FRP Docker Deploy
<center>

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
