#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# DIY扩展 在此脚本 增加插件
TIME() {
[[ -z "$1" ]] && {
	echo -ne " "
} || {
     case $1 in
	r) export Color="\e[31;1m";;
	g) export Color="\e[32;1m";;
	b) export Color="\e[34;1m";;
	y) export Color="\e[33;1m";;
	z) export Color="\e[35;1m";;
	l) export Color="\e[36;1m";;
      esac
	[[ $# -lt 2 ]] && echo -e "\e[36m\e[0m ${1}" || {
		echo -e "\e[36m\e[0m ${Color}${2}\e[0m"
	 }
      }
}
echo
TIME y "添加 281677160 package"
git clone https://github.com/281677160/openwrt-package package/281677160
echo
TIME r "删除无用主题"
rm -rf ./feeds/freifunk/themes
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf ./feeds/luci/themes/luci-theme-netgear
rm -rf ./feeds/luci/themes/luci-theme-material
echo
TIME b "修改 默认IP为 192.168.57.1"
sed -i "s/192.168.1.1/192.168.57.1/g" package/base-files/files/bin/config_generate
echo
TIME b "插件 重命名"
sed -i 's/cbi("qbittorrent"),_("qBittorrent")/cbi("qbittorrent"),_("BT下载")/g' package/lean/luci-app-qbittorrent/luasrc/controller/qbittorrent.lua
echo
TIME g "设置密码为空"
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings
echo
TIME g "更新配置"
./scripts/feeds install -a
TIME g "配置更新完成"
sed -i 's/02b79d5e2b07b5e64cd28f1fe84395ee11eef95fc49fd923a9ab93022b148be6/skip/g' feeds/packages/utils/containerd/Makefile
