#常规方法
1. 下载插件
下载[simple-obfs](http://openwrt-dist.sourceforge.net/packages/base/x86_64/simple-obfs_0.0.5-4_x86_64.ipk)并安装(这里提供的是x86_64版本，[其他版本](http://openwrt-dist.sourceforge.net/packages/base/)选择对应版本cpu，下载simple-obfs_*****.ipk>)
2. 解析文本
在/usr/lib/lua/luci/model/cbi/shadowsocksr/client-config.lua文件中，写入一下代码（划去部分为上下文，**只需写入非划去部分**)，也可以直接下载client-config.lua直接替换

~~o = s:option(Value, "server_port", translate("Server Port"))
o.datatype = "port"
o.rmempty = false~~
```
o = s:option(Value, "plugin", "Plugin")
o:depends("type", "ss")

o = s:option(Value, "plugin_opts", "Plugin Opts")
o:depends("type", "ss")
```
~~-- o = s:option(Value, "timeout", translate("Connection Timeout"))
-- o.datatype = "uinteger"
-- o.default = 60
-- o.rmempty = false~~

3. 写入文件
在/etc/init.d/shadowsocksr文件中，加入代码，**划去部分不需要加入**，或者下载shadowsocksr直接替换，替换后需要为/etc/init.d/shadowsocksr赋予运行权限，即 运行`chmod +x /etc/init.d/shadowsocksr`
~~if [ "\$stype" == "ss" ] ;then
cat <<-EOF >\$config_file
{
"server": "\$hostip",
"server_port": \$(uci_get_by_name \$1 server_port),
"local_address": "0.0.0.0",
"local_port": \$(uci_get_by_name \$1 local_port),
"password": "\$(uci_get_by_name \$1 password)",
"timeout": \$(uci_get_by_name \$1 timeout 60),
"method": "\$(uci_get_by_name \$1 encrypt_method_ss)",
"reuse_port": true,
"fast_open": \$fastopen
}
EOF~~
```
local plugin=$(uci_get_by_name $1 plugin)
if [ -n "$plugin" -a -x "/usr/bin/$plugin" ]; then
    sed -i "s@$hostip\",@$hostip\",\n    \"plugin\": \"$plugin\",\n    \"plugin_opts\": \"$(uci_get_by_name $1 plugin_opts)\",@" $config_file
fi
```