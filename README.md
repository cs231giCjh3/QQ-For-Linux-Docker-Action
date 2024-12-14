# 自用 Action构建 QQ for Linux 的Docker镜像  

## 声明:此构建配置流程完全透明 `qq.deb`为 https://im.qq.com/ 取得的链接下载  

### tips:此构建预配置了字体  使用霞鹜文楷屏幕阅读版+ysabeauinfant英文斜体  

定制字体请修改容器内的 `/etc/fonts/local.conf`  

字体效果如图:
![111.png](https://raw.githubusercontent.com/cs231giCjh3/QQ-For-Linux-Docker-Action/refs/heads/main/111.png)
## Liteloader版使用方法
从releases下载镜像  
解压为tar  
导入镜像:
```
gunzip qq-image-liteloader.tar.gz
docker load -i qq-image-liteloader.tar
```
设置`xhost` (这一步每次开机都要运行)
```
xhost +SI:localuser:$(whoami)
```
运行镜像:
```
docker run  --name qq \
            -d --cap-add=SYS_ADMIN \
            --security-opt=no-new-privileges \
            --dns 119.29.29.29 --dns 223.5.5.5 \
            --dns 114.114.114.114 --dns 223.6.6.6 \
            -v 保存数据的位置:/home/user \
            -v /run/user/$(id -u)/bus:/run/user/$(id -u)/bus \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
           --env DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" -e UID=$(id -u) \
           -e LANG \
           -e XMODIFIERS \
           -e QT_IM_MODULE \
           -e GTK_IM_MODULE \
            qq-for-linux:latest-liteloader
```
## 原版使用方法
releases下载镜像  
解压为tar  
导入镜像:
```
gunzip qq-image-original.tar.gz
docker load -i qq-image-original.tar
```
设置`xhost` (这一步每次开机都要运行)
```
xhost +SI:localuser:$(whoami)
```
运行镜像:
```
docker run  --name qq \
            -d --cap-add=SYS_ADMIN \
            --security-opt=no-new-privileges \
            --dns 119.29.29.29 --dns 223.5.5.5 \
            --dns 114.114.114.114 --dns 223.6.6.6 \
            -v 保存数据的位置:/home/user \
            -v /run/user/$(id -u)/bus:/run/user/$(id -u)/bus \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
            -e DISPLAY=$DISPLAY \
           --env DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" -e UID=$(id -u) \
           -e LANG \
           -e XMODIFIERS \
           -e QT_IM_MODULE \
           -e GTK_IM_MODULE \
            qq-for-linux:latest-original
```
## 已知问题及解决方法（如有）

可能无法使用基于ibus的输入法,遇到这种情况可以考虑换成基于fcitx的输入法

## Q&A

### 为什么要做这个镜像？

<del>Windows底下我管不了你QQ，Linux底下我还管不了你QQ了?</del>\
最开始是因为没有新版QQ的内测权限，于是用Docker卡bug来登陆，现在就只是用来隔离QQ,防止扫盘

### 为什么要安装Firefox?

不装Firefox打不开外部网页



# 致谢作者[@xys20071111](https://github.com/xys20071111/)
