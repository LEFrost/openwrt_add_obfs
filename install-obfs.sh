#!/bin/bash

mkdir backup
cp /usr/lib/lua/luci/model/cbi/shadowsocksr/client-config.lua backup/
cp /etc/init.d/shadowsocksr backup/
opkg install simple-obfs 
wget https://raw.githubusercontent.com/LEFrost/openwrt_add_obfs/master/client-config.lua
wget https://raw.githubusercontent.com/LEFrost/openwrt_add_obfs/master/shadowsocksr
mv client-config.lua /usr/lib/lua/luci/model/cbi/shadowsocksr/
mv shadowsocksr /etc/init.d/
chmod +x /etc/init.d/shadowsocksr 

