记录软件各种功能
读入 json
mvc结构模式
对象类型封装
对象类型继承

读入 程序资源 配置文件

调用c语言编写数据

程序基于网络命令


networksetup -listnetworkserviceorder
networksetup -listallnetworkservices// 显示最简单的所有在网络列表里的网络()可以是同一个硬件的不同命名
networksetup -listallhardwareports //显示所有支持的硬件唯一

networksetup -listnetworkserviceorder
//列出排序的 软件（硬件可以重命名不同软件列表） 网络列表（ ）不包括地址
    (2) Ethernet
    (Hardware Port: Ethernet, Device: en0)
   
    (3) Ethernet Adaptor (en7)
    (Hardware Port: Ethernet Adaptor (en7), Device: en7)
networksetup -listallnetworkservices
//列出现在 软件列表 网络所有可用网络名字 也就是详细属性里的 “Hardware Port”

    An asterisk (*) denotes that a network service is disabled.
    Built-in Serial Port (1)
    Ethernet
    Ethernet Adaptor (en7)
    Bluetooth PAN
    haha
    
networksetup -listallhardwareports
//列出网络信息（硬件信息） 包括 “Hardware Port” “Device” “Ethernet”
    //Hardware Port: Bluetooth PAN
    //Device: en1
    //Ethernet Address: 00:1a:7d:da:12:13

networksetup -detectnewhardware
//发现新的硬件 无返回值

networksetup -getmacaddress <hardwareport or device name>
//获取指定“Hardware Port”字段值的地址 ，基本无用



networksetup -getinfo <networkservice>
//获取网络详细信息 参数“Hardware Port”名字
    DHCP Configuration
    IP address: 192.168.5.4
    Subnet mask: 255.255.255.0
    Router: 192.168.5.1
    Client ID:
    IPv6: Automatic
    IPv6 IP address: none
    IPv6 Router: none
    Ethernet Address: 14:dd:a9:e8:33:81

networksetup -removenetworkservice <networkservice>
//移除本地网络服务

networksetup -ordernetworkservices <service1> <service2> <service3> <...>
//排序授权网络服务 第一个是默认链接的网络服务

//在单个帧中, IP数据包必须小于1500字节, 这个1500就是MTU(max transmission unit)能达到的最大值, 它是数据链路层允许的最大IP包。
networksetup -getMTU <hardwareport or device name>
networksetup -setMTU <hardwareport or device name> <value>
networksetup -listvalidMTUrange <hardwareport or device name>

//操作网端口速度信息 例如 100M 网 1000M网 大部分是自动，单有时候1000M网卡上无法识别出1000M 需要手动设置
networksetup -getmedia <hardwareport or device name>
networksetup -setmedia <hardwareport or device name> <subtype> [option1] [option2] [...]
networksetup -listvalidmedia <hardwareport or device name>



networksetup -setmanual <networkservice> <ip> <subnet> <router>
//手动设置 指定网络服务的信息 包括ip ： 0.0.0.0  段地址（子掩盖吗）：255.255.255.0  路由地址 ：192.168.5.1


//DHCP 是BOOTP 的增强版本都是bai基于TCP/IP协议的协议。BOOTP只用于无盘工作站，DHCP 即可用于无盘站也可用于一般的网络应用。

networksetup -setdhcp <networkservice> [clientid]
//设置指定网络以dhcp协议运行

networksetup -setbootp <networkservice>
//设置指定网络以BOOTP协议运行

networksetup -setmanualwithdhcprouter <networkservice> <ip>
//设置手动配置dhcp路由地址


networksetup -getcomputername
//获取电脑名字 应该是网络共享时候的名字
networksetup -setcomputername <name>
//设置电脑名字

networksetup -getadditionalroutes <networkservice>
//获取路由额外地址 不知道啥意思
    There are no additional IPv4 routes on Ethernet.
    
networksetup -setadditionalroutes <networkservice> [ <dest> <mask> <gateway> ]*
//设置路由额外地址

networksetup -setv4off <networkservice>
//设置IPv4方式运行

networksetup -setv6off <networkservice>
//设置IPv6方式运行

networksetup -setv6automatic <networkservice>
//设置IPv6方式自动获取ip等运行

networksetup -setv6LinkLocal <networkservice>
//设置IPv6本地连接？


networksetup -setv6manual <networkservice> <networkservice> <address> <prefixlength> <router>
//手动设置IPv6网络信息

networksetup -getv6additionalroutes <networkservice>
//获取路由额外地址

networksetup -setv6additionalroutes <networkservice> [ <dest> <prefixlength> <gateway> ]*
//设置路由额外地址

networksetup -getdnsservers <networkservice>
//获取dns服务器

networksetup -setdnsservers <networkservice> <dns1> [dns2] [...]
//设置dns服务器

networksetup -getsearchdomains <networkservice>

networksetup -setsearchdomains <networkservice> <domain1> [domain2] [...]

networksetup -create6to4service <newnetworkservicename>

networksetup -set6to4automatic <networkservice>

networksetup -set6to4manual <networkservice> <relayaddress>

networksetup -getftpproxy <networkservice>
//获取ftp代理信息
    
    Enabled: No
    Server:
    Port: 0
    Authenticated Proxy Enabled: 0

networksetup -setftpproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setftpproxystate <networkservice> <on off>

//web代理操作
networksetup -getwebproxy <networkservice>
networksetup -setwebproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setwebproxystate <networkservice> <on off>

//安全web代理
networksetup -getsecurewebproxy <networkservice>
networksetup -setsecurewebproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setsecurewebproxystate <networkservice> <on off>

//流媒体代理
networksetup -getstreamingproxy <networkservice>
networksetup -setstreamingproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setstreamingproxystate <networkservice> <on off>

//不知道什么代理
networksetup -getgopherproxy <networkservice>
networksetup -setgopherproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setgopherproxystate <networkservice> <on off>

//防火墙代理？
networksetup -getsocksfirewallproxy <networkservice>
networksetup -setsocksfirewallproxy <networkservice> <domain> <port number> <authenticated> <username> <password>
networksetup -setsocksfirewallproxystate <networkservice> <on off>

networksetup -getproxybypassdomains <networkservice>
networksetup -setproxybypassdomains <networkservice> <domain1> [domain2] [...]
networksetup -getproxyautodiscovery <networkservice>
networksetup -setproxyautodiscovery <networkservice> <on off>
networksetup -getpassiveftp <networkservice>
networksetup -setpassiveftp <networkservice> <on off>

//airport代理
networksetup -getairportnetwork <device name>
networksetup -setairportnetwork <device name> <network> [password]
networksetup -getairportpower <device name>
networksetup -setairportpower <device name> <on off>

//WIFI网络操作

networksetup -listpreferredwirelessnetworks <device name>
//列出首选的无线网络

networksetup -addpreferredwirelessnetworkatindex <device name> <network> <index> <security type> [password]
//设置添加首选无线网

//以下wifi增删改
networksetup -removepreferredwirelessnetwork <device name> <network>

networksetup -removeallpreferredwirelessnetworks <device name>

networksetup -getnetworkserviceenabled <networkservice>

networksetup -setnetworkserviceenabled <networkservice> <on off>

networksetup -createnetworkservice <newnetworkservicename> <hardwareport>

networksetup -renamenetworkservice <networkservice> <newnetworkservicename>

networksetup -duplicatenetworkservice <networkservice> <newnetworkservicename>
//复制本地网络服务


//VLAN一般指虚拟局域网。VLAN（Virtual Local Area Network）
//的中文名为"虚拟局域网"。虚拟局域网（VLAN）是一组逻辑上的设备和用户，这些设备和用户并不受物理位置的限制，
//可以根据功能、部门及应用等因素将它们组织起来，相互之间的通信就好像它们在同一个网.
networksetup -createVLAN <VLAN name> <parent device name> <tag>
networksetup -deleteVLAN <VLAN name> <parent device name> <tag>
networksetup -listVLANs
networksetup -listdevicesthatsupportVLAN


//Bond来绑定多个网卡作为一个逻辑网口,配置单个的IP地址,会大幅提升服务器的网络吞吐(I/O)
networksetup -isBondSupported <hardwareport>
networksetup -createBond <bondname> <hardwareport1> <hardwareport2> <...>
networksetup -deleteBond <bonddevicename>
networksetup -addDeviceToBond <hardwareport> <bonddevicename>
networksetup -removeDeviceFromBond <hardwareport> <bonddevicename>
networksetup -listBonds
networksetup -showBondStatus <bonddevicename>

//PPPoE（英语：Point-to-Point Protocol Over Ethernet），以太网上的点对点协议，是将点对点协议（PPP）封装在以太网（Ethernet）框架中的一种网络隧道协议。
networksetup -listpppoeservices
networksetup -showpppoestatus <service name ie., MyPPPoEService>
networksetup -createpppoeservice <device name ie., en0> <service name> <account name> <password> [pppoe service name]
networksetup -deletepppoeservice <service name>
networksetup -setpppoeaccountname <service name> <account name>
networksetup -setpppoepassword <service name> <password>
networksetup -connectpppoeservice <service name>
networksetup -disconnectpppoeservice <service name>


//本地网络分类？在MAC 网络上边位置中国呢可以编辑不知道到底干啥
networksetup -getcurrentlocation
networksetup -listlocations
networksetup -createlocation <location name> [populate]
networksetup -deletelocation <location name>
networksetup -switchtolocation <location name>

//未知用法 提示不再支持 ,难道是网络配置文件 的操作？
networksetup -listalluserprofiles
networksetup -listloginprofiles <service name>

networksetup -enablesystemprofile <service name> <on off>
networksetup -enableloginprofile <service name> <profile name> <on off>
networksetup -enableuserprofile <profile name> <on off>

//EEE802 LAN/WAN委员会为解决无线局域网网络安全问题,提出了802.1X协议。后来,802.1X协议作为局域网端口的一个普通接入控制机制在以太网中被广泛应用,
networksetup -import8021xProfiles <service name> <file path>
networksetup -export8021xProfiles <service name> <file path> <yes no>
networksetup -export8021xUserProfiles <file path> <yes no>
networksetup -export8021xLoginProfiles <service name> <file path> <yes no>
networksetup -export8021xSystemProfile <service name> <file path> <yes no>

//设置tls标识用户配置文件

networksetup -settlsidentityonsystemprofile <service name> <file path> <passphrase>
>networksetup -settlsidentityonuserprofile <profile name> <file path> <passphrase>networksetup -deletesystemprofile <service name>
networksetup -deleteloginprofile <service name> <profile name>
networksetup -deleteuserprofile <profile name>


networksetup -version
//版本信息

networksetup -help
//帮助可以显示每一个命令英文解释

networksetup -printcommands
//打印出所有支持命令


