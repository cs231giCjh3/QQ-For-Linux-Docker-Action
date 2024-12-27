# 自用Action构建Linux QQ Docker镜像  
# ⚠️⚠️⚠️如要使用 建议使用原板
## 因为使用Liteloader版本造成账户被风控，登录异常等可能的影响与本人无关

## 此构建配置流程完全透明 出于信任考量还是建议自行构建
### tips:此构建预配置了字体  使用霞鹜文楷屏幕阅读版 + YsabeauInfantItalic斜体
### 字体效果如图:
![1.png](https://raw.githubusercontent.com/cs231giCjh3/QQ-For-Linux-Docker-Action/refs/heads/main/1.png)
(背景图片原图: https://danbooru.donmai.us/posts/6613571 / https://twitter.com/majotabi_pr/status/1693908269822353871)

## 原版使用方法
releases下载镜像
解压为tar，导入镜像:
```
gunzip qq-image-original.tar.gz
docker load -i qq-image-original.tar
```
设置`xhost` (这一步每次开机都要运行)
```
xhost +SI:localuser:$(whoami)
```

## ⚠️⚠️tips2(重要!):  
通过`-v 保存数据的位置:/home/user`将主机目录挂载到容器内的`/home/user`后,主机目录可视为"共享文件夹",但是在QQ调起文件选择器从主机目录选择文件发送时,文件选择器传入的文件路径会是主机的而不是容器内的,导致QQ找不到文件,无法正常发送  

解决方法是使用`ln -s "保存数据的位置" /home/user`创建软链接,之后调起文件管理器时访问主机的`/home/user`来选择文件,这样可以使得QQ获取可以到达的文件路径   
(这实际使得传入QQ的路径也是`/home/user/*`)
## 运行镜像：  
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
              --env DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
              -e UID=$(id -u) \
              -e LANG=zh_CN.UTF-8 \
              -e XMODIFIERS \
              -e QT_IM_MODULE \
              -e GTK_IM_MODULE \
              qq-for-linux:latest-original
```

### 在docker run后再启动镜像只需要 `docker start qq`
### 若输入法有问题请检查系统的
```
XMODIFIERS
QT_IM_MODULE
GTK_IM_MODULE
```
### 环境变量是否存在：
```
echo $XMODIFIERS
echo $QT_IM_MODULE
echo $GTK_IM_MODULE
```
### 输出应该是（已经在Debian 12 KDE（Wayland/X11）下测试）
```
@im=fcitx
fcitx
fcitx
```
## Liteloader版使用
从releases下载镜像  
解压为tar，导入镜像：
```
gunzip qq-image-liteloader.tar.gz
docker load -i qq-image-liteloader.tar
```
设置`xhost` (这一步每次开机都要运行)
```
xhost +SI:localuser:$(whoami)
```

## ⚠️⚠️tips2(重要!):
通过`-v 保存数据的位置:/home/user`将主机目录挂载到容器内的`/home/user`后,主机目录可视为"共享文件夹",但是在QQ调起文件选择器从主机目录选择文件发送时,文件选择器传入的文件路径会是主机的而不是容器内的,导致QQ找不到文件,无法正常发送  

解决方法是使用`ln -s "保存数据的位置" /home/user`创建软链接,之后调起文件管理器时访问主机的`/home/user`来选择文件,这样可以使得QQ获取可以到达的文件路径   
(这实际使得传入QQ的路径也是`/home/user/*`)
## 运行镜像：  
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
              --env DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
              -e UID=$(id -u) \
              -e LANG=zh_CN.UTF-8 \
              -e XMODIFIERS \
              -e QT_IM_MODULE \
              -e GTK_IM_MODULE \
              qq-for-linux:latest-liteloader
```
### 在docker run后再启动镜像只需要 `docker start qq`
### 若输入法有问题请检查系统的
```
XMODIFIERS
QT_IM_MODULE
GTK_IM_MODULE
```
### 环境变量是否存在：
```
echo $XMODIFIERS
echo $QT_IM_MODULE
echo $GTK_IM_MODULE
```
### 输出应该是（已经在Debian 12 KDE（Wayland/X11）下测试）
```
@im=fcitx
fcitx
fcitx
```

## 已知问题及解决方法（如有）

可能无法使用基于ibus的输入法,遇到这种情况可以考虑换成基于fcitx的输入法

## Q&A

### 为什么要加`LANG=zh_CN.UTF-8`

测试发现如果`LANG`不是`zh_CN.UTF-8`可能导致不能用输入法

### 为什么要做这个镜像？

<del>Windows底下我管不了你QQ，Linux底下我还管不了你QQ了?</del>\
最开始是因为没有新版QQ的内测权限，于是用Docker卡bug来登陆，现在就只是用来隔离QQ,防止扫盘

### 为什么要安装Firefox?

不装Firefox打不开外部网页

# 致谢

感谢原作者[QQ-For-Linux-Docker@xys20071111](https://github.com/xys20071111/QQ-For-Linux-Docker)  
  
字体来源:  
[Ysabeau@CatharsisFonts](https://github.com/CatharsisFonts/Ysabeau)  
[LxgwWenKai-Screen@lxgw](https://github.com/lxgw/LxgwWenKai-Screen)
