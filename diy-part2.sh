#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.10/g' target/linux/x86/Makefile
sed -i 's/192.168.1.1/192.168.1.11/g' package/base-files/files/bin/config_generate
sed -i "s/timezone='UTC'/timezone='CST-8'/" package/base-files/files/bin/config_generate
sed -i "/timezone='CST-8'/a \ \ \ \ \ \ \ \ set system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='0.openwrt.pool.ntp.org'/add_list system.ntp.server='ntp.aliyun.com'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='1.openwrt.pool.ntp.org'/add_list system.ntp.server='time1.cloud.tencent.com'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='2.openwrt.pool.ntp.org'/add_list system.ntp.server='time.ustc.edu.cn'/" package/base-files/files/bin/config_generate
sed -i "s/add_list system.ntp.server='3.openwrt.pool.ntp.org'/add_list system.ntp.server='cn.pool.ntp.org'/" package/base-files/files/bin/config_generate
#修改版本为编译日期
#cp -f feeds/smpackage/.github/diy/banner package/base-files/files/etc/banner
#sed -i "s/%D %V, %C/openwrt $(date +'%m.%d') by Masaaki/g" package/base-files/files/etc/banner
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='OpenWrt by Masaaki'/g"  package/base-files/files/etc/openwrt_release
# openclash
cd /workdir
#预置OpenClash内核和GEO数据
export CORE_VER=https://raw.githubusercontent.com/vernesong/OpenClash/core/dev/core_version
export CORE_TUN=https://github.com/vernesong/OpenClash/raw/core/dev/premium/clash-linux
export CORE_DEV=https://github.com/vernesong/OpenClash/raw/core/dev/dev/clash-linux
export CORE_MATE=https://github.com/vernesong/OpenClash/raw/core/dev/meta/clash-linux

export CORE_TYPE=$(echo x86_64 | grep -Eiq "64|86" && echo "amd64" || echo "arm64")
export TUN_VER=$(curl -sfL $CORE_VER | sed -n "2{s/\r$//;p;q}")

export GEO_MMDB=https://github.com/alecthw/mmdb_china_ip_list/raw/release/lite/Country.mmdb
export GEO_SITE=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geosite.dat
export GEO_IP=https://github.com/Loyalsoldier/v2ray-rules-dat/raw/release/geoip.dat

cd OpenClash/luci-app-openclash/root/etc/openclash
curl -sfL -o ./Country.mmdb $GEO_MMDB
curl -sfL -o ./GeoSite.dat $GEO_SITE
curl -sfL -o ./GeoIP.dat $GEO_IP

mkdir ./core && cd ./core

curl -sfL -o ./tun.gz "$CORE_TUN"-"$CORE_TYPE"-"$TUN_VER".gz
gzip -d ./tun.gz && mv ./tun ./clash_tun

curl -sfL -o ./meta.tar.gz "$CORE_MATE"-"$CORE_TYPE".tar.gz
tar -zxf ./meta.tar.gz && mv ./clash ./clash_meta

curl -sfL -o ./dev.tar.gz "$CORE_DEV"-"$CORE_TYPE".tar.gz
tar -zxf ./dev.tar.gz

chmod +x ./clash* ; rm -rf ./*.gz
