//
//  MyModel.swift
//  SwitchNet
//
//  Created by YiEN on 2021/1/20.
//

import Foundation

struct BaseNetInfo: Codable {
    //记录顺序
    var id: Int?
    //记录名字
    var netName: String?
    //用户自定义名称但是有些手机共享的网络总是会变
    var netExName: String?
    //记录是否是当前选中
    var isDefault: Bool?
    
    
}

//结构和命令
//yien@192 ~ % networksetup -getinfo "Ethernet 2"
//DHCP Configuration
//IP address: 192.168.5.4
//Subnet mask: 255.255.255.0
//Router: 192.168.5.1
//Client ID:
//IPv6: Automatic
//IPv6 IP address: none
//IPv6 Router: none
//Ethernet Address: 14:dd:a9:e2:06:81
struct ExNetInfo: Codable {
    var IP_address: String?
    var Subnet_mask: String?
    var Router: String?
    var Client_ID: String?
    var Ethernet_Address: String?
    var IPv6: String?
    var IPv6_IP_address: String?
    var IPv6_Router: String?
}
/**
 命令networksetup -listallhardwareports

结果 获取起硬件值

 Hardware Port: Built-in Serial Port (1)
 Device: serial1
 Ethernet Address: N/A

 Hardware Port: Ethernet
 Device: en0
 Ethernet Address: 14:dd:a9:e2:06:81

 Hardware Port: Ethernet Adaptor (en7)
 Device: en7
 Ethernet Address: ce:71:39:54:af:9b

 Hardware Port: Bluetooth PAN
 Device: en1
 Ethernet Address: 00:1a:7d:da:71:13
 
 networksetup -createnetworkservice "新网络" "Ethernet"
 networksetup -renamenetworkservice <networkservice> <newnetworkservicename>
 */
