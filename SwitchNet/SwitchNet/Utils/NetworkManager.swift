//  网络模块
//  NetworkInfo.swift



import Foundation
import Cocoa
import SystemConfiguration

final class NetworkManager {

    // Credit: vadian
    // https://stackoverflow.com/a/31838376/13164334
    class func getMACAddressFromBSD(bsd: String) -> String? {
        let MAC_ADDRESS_LENGTH = 6
        let separator = ":"

        var length: size_t = 0
        var buffer: [CChar]

        let bsdIndex = Int32(if_nametoindex(bsd))
        if bsdIndex == 0 {
            Log.error("Could not find index for bsd name \(bsd)")
            return nil
        }
        let bsdData = Data(bsd.utf8)
        var managementInfoBase = [CTL_NET, AF_ROUTE, 0, AF_LINK, NET_RT_IFLIST, bsdIndex]

        if sysctl(&managementInfoBase, 6, nil, &length, nil, 0) < 0 {
            Log.error("Could not determine length of info data structure")
            return nil
        }

        buffer = [CChar](unsafeUninitializedCapacity: length, initializingWith: {buffer, initializedCount in
            for idx in 0..<length { buffer[idx] = 0 }
            initializedCount = length
        })

        if sysctl(&managementInfoBase, 6, &buffer, &length, nil, 0) < 0 {
            Log.error("Could not read info data structure")
            return nil
        }

        let infoData = Data(bytes: buffer, count: length)
        let indexAfterMsghdr = MemoryLayout<if_msghdr>.stride + 1
        let rangeOfToken = infoData[indexAfterMsghdr...].range(of: bsdData)!
        let lower = rangeOfToken.upperBound
        let upper = lower + MAC_ADDRESS_LENGTH
        let macAddressData = infoData[lower..<upper]
        let addressBytes = macAddressData.map { String(format: "%02x", $0) }
        return addressBytes.joined(separator: separator)
    }

    class func isReachable() -> Bool {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "captive.apple.com") else {
            return false
        }
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)

        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)

        let isReachable: Bool = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    // from Goshin 获取ip 正则表达式匹配事咧
    class func getRouterAddress(bsd: String) -> String? {

        let ipAddressRegex = #"\s([a-fA-F0-9\.:]+)(\s|%)"# // for ipv4 and ipv6

        let routerCommand = ["-c", "netstat -rn", "|", "egrep -o", "default.*\(bsd)"]
        guard let routerOutput = Commands.execute(executablePath: .shell, args: routerCommand).0 else {
            return nil
        }

        let regex = try? NSRegularExpression.init(pattern: ipAddressRegex, options: [])
        let firstMatch = regex?.firstMatch(in: routerOutput,
                                        options: [],
                                        range: NSRange(location: 0, length: routerOutput.count))
        if let range = firstMatch?.range(at: 1) {
            if let swiftRange = Range(range, in: routerOutput) {
                let ipAddr = String(routerOutput[swiftRange])
                return ipAddr
            }
        } else {
            Log.debug("Could not find router ip address")
        }

        return nil
    }

    // from https://stackoverflow.com/questions/30748480/swift-get-devices-wifi-ip-address/30754194#30754194
    class func getLocalAddress(bsd: String) -> String? {
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0, let firstAddr = ifaddr else {
            return nil
        }

        var ipV4: String?
        var ipV6: String?

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            guard addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) else {
                continue
            }

            // Check interface name:
            let name = String(cString: interface.ifa_name)
            guard name == bsd else {
                continue
            }

            // Convert interface address to a human readable string:
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                        &hostname, socklen_t(hostname.count),
                        nil, socklen_t(0), NI_NUMERICHOST)

            if addrFamily == UInt8(AF_INET) {
                ipV4 = String(cString: hostname)
            } else if addrFamily == UInt8(AF_INET6) {
                ipV6 = String(cString: hostname)
            }
        }

        freeifaddrs(ifaddr)

        // ipV4 has priority
        return ipV4 ?? ipV6
    }
    class func getNetBaseNameArray() -> [String]?{
        var arrayString = [String]();
        //正则表达式
       // let netRegex = #".*\n"# // for ipv4 and ipv6
        //拼接执行的命令
        let routerCommand = ["-c", "networksetup -listallnetworkservices", ""]
        //执行命令接受返回值
        guard let routerOutput = Commands.execute(executablePath: .shell, args: routerCommand).0 else {
            return nil
        }
        //初始化正则对象
        
         let asd1 = routerOutput.split(separator: "\n")
    
        for temp in asd1 {
                // please consider handling the case where String(bytes:encoding:) returns nil.
            arrayString.append(String(temp) )
        }

        return arrayString
    }
    class func getMAC() -> String {
        let routerCommand = ["-c", "ifconfig -a", ""]
        guard let routerOutput = Commands.execute(executablePath: .shell, args: routerCommand).0 else {
            return ""
        }
        let myMACOutput = routerOutput.components(separatedBy: "\n")
        var myMac = ""

        for line in myMACOutput {
            if line.contains("ether") {
                myMac = line.replacingOccurrences(of: "ether", with: "").trimmingCharacters(in: CharacterSet.whitespaces)
                break
            }
        }
        if #available(OSX 13, *) {
               print("版本判断")
             } else {
                print("Not版本判断OSX 13")
             }
        return myMac
    }

}
