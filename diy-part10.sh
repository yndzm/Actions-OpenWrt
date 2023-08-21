#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source

# svn co https://github.com/kenzok8/small-package/trunk/luci-app-mosdns package/diy/luci-app-mosdns
# svn co https://github.com/kenzok8/small-package/trunk/mosdns package/diy/mosdns
# svn co https://github.com/kenzok8/small-package/trunk/v2dat package/diy/v2dat
