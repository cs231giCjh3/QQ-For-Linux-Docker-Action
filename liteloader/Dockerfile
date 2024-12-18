FROM debian:12
ENTRYPOINT ["bash", "-c", "/root/run.sh"]

RUN mkdir -p /usr/share/fonts/truetype/lxgw-wenkai-screen/ && \
mkdir -p /usr/share/fonts/truetype/ysabeauinfant/
COPY ./qq.deb /root/qq.deb
COPY ./LiteLoaderQQNT.zip /root/LiteLoaderQQNT.zip
COPY ./run_in_image.sh /root/run.sh
COPY ./adduser.sh /root/adduser.sh
COPY ./ysabeauinfant/* /usr/share/fonts/truetype/ysabeauinfant/
COPY ./lxgw-wenkai-screen/* /usr/share/fonts/truetype/lxgw-wenkai-screen/
COPY local.conf /etc/fonts/local.conf

RUN apt-get update && \
apt-get install -y apt-transport-https ca-certificates && \
sed -i 's|http://|https://|g' /etc/apt/sources.list.d/debian.sources && \
chown root:root /usr/share/fonts/truetype/lxgw-wenkai-screen/* && \
chown root:root /usr/share/fonts/truetype/ysabeauinfant/* && \
chown root:root /etc/fonts/local.conf && chmod 644 /etc/fonts/local.conf && \
chmod +x /root/run.sh && chmod +x /root/adduser.sh && \
rm -rf /var/lib/apt/lists/* && \
apt update && \
    apt upgrade -y && \
    apt install -y sudo libgbm1 uuid-runtime libcurl4 \
    mesa-utils libgl1-mesa-glx libasound2 libnotify-bin firefox-esr firefox-esr-l10n-zh-cn \
    locales fonts-noto-cjk fonts-noto-color-emoji unzip vim nano /root/qq.deb && \
sed -i '/^#.* zh_CN.UTF-8 /s/^#//' /etc/locale.gen && locale-gen && \
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend noninteractive tzdata && \
mkdir /opt/liteloader/ && \
    cd /opt/liteloader && \
    unzip /root/LiteLoaderQQNT.zip && \
    echo "require(String.raw\`/opt/liteloader\`)" > /opt/QQ/resources/app/app_launcher/liteloader.js && \
    sed -i 's/\.\/application.asar\/app_launcher\/index\.js/\.\/app_launcher\/liteloader\.js/g' /opt/QQ/resources/app/package.json && \
rm /root/qq.deb && \
rm /root/LiteLoaderQQNT.zip && \
fc-cache -fv && \
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /tmp/* && \
rm -rf /var/tmp/*
