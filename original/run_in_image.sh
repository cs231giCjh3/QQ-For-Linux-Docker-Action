#!/bin/bash
# 检查是否运行了创建用户脚本
if [ ! -f /root/.first_run_done ]; then
    /root/adduser.sh
    touch /root/.first_run_done
fi
# 启动QQ
su -c "notify-send 如果你能看到这句话 那dbus就应该配置好了" user
su -c "qq" user
