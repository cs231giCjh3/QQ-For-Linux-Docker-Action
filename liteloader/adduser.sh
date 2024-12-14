#!/bin/bash
uuid=$(uuidgen)
USER_ID=1000
USERNAME="user"
useradd -m -u $USER_ID $USERNAME
echo "$USERNAME:$uuid" | chpasswd
chown $USERNAME:$USERNAME /home/$USERNAME
chown -R $USERNAME:$USERNAME /opt/QQ
