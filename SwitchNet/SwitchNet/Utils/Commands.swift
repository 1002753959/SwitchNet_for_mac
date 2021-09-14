//  Switch直接执行 命令行
 
 
 
import Foundation

class Commands {
    //默认地址配置
    enum ExecutablePath: String {
        case shell = "/bin/sh"
        case log = "/usr/bin/log"
        case nvram = "/usr/sbin/nvram"
    }

    // MARK: Run command and returns the output and exit status.

    public class func execute(executablePath: ExecutablePath, args: [String]) -> (String?, Int32) {
        let process = Process()
        let pipe = Pipe()
        process.standardOutput = pipe
        if #available(OSX 10.13, *) {
            process.executableURL = URL(fileURLWithPath: executablePath.rawValue)
        } else {
            process.launchPath = executablePath.rawValue
        }
        process.arguments = args
        if #available(OSX 10.13, *) {
            guard (try? process.run()) != nil else {
                Log.debug("Could not run command")
                return (nil, 1)
            }
        } else {
            process.launch()
        }
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        process.waitUntilExit()
        guard let output = String(data: data, encoding: .utf8),
            !output.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return (nil, process.terminationStatus)
        }

        return (output.trimmingCharacters(in: .whitespacesAndNewlines), process.terminationStatus)
    }

}
