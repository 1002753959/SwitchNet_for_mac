//日志
//
 

import Foundation
import os.log

final class Log {
    static func debug(_ message: String) {
        if #available(OSX 11.0, *) {
            Logger.heliPort.info("DEBUG: \(message, privacy: .public))")
        } else {
            os_log("%{public}@", log: .heliPort, type: .info, "DEBUG: " + message)
        }
    }

    static func error(_ message: String) {
        if #available(OSX 11.0, *) {
            Logger.heliPort.error("ERROR: \(message, privacy: .public))")
        } else {
            os_log("%{public}@", log: .heliPort, type: .error, "ERROR: " + message)
        }
    }
}

@available(OSX 11.0, *)
extension Logger {
    static let heliPort = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "NetSwitch")
}

extension OSLog {
    static let heliPort = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "NetSwitch")
}
