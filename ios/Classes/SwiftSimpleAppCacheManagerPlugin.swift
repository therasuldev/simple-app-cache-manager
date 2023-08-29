import Flutter
import UIKit

public class SwiftSimpleAppCacheManagerPlugin: NSObject, FlutterPlugin {
    private var channel: FlutterMethodChannel?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "simple_app_cache_manager", binaryMessenger: registrar.messenger())
        let instance = SwiftSimpleAppCacheManagerPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let channel = channel else {
            result(FlutterError(code: "channel_not_initialized", message: "Method channel is not initialized", details: nil))
            return
        }
        
        switch call.method {
        case "checkCacheExistence":
            result(checkCacheExistence())
        case "getTotalCacheSize":
            result(getTotalCacheSize())
        case "clearCache":
            clearCache()
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func checkCacheExistence() -> Bool {
        let cacheDir = getCacheDirectory()
        return FileManager.default.fileExists(atPath: cacheDir.path)
    }

    public func getTotalCacheSize() -> String {
        let cacheDir = getCacheDirectory()
        let totalSize = calculateDirectorySize(directory: cacheDir)
        let formattedSize = formatBytes(totalSize)
        return formattedSize
    }

    public func clearCache() {
        let cacheDir = getCacheDirectory()
        do {
            try FileManager.default.removeItem(at: cacheDir)
        } catch {
            print("Error clearing cache: \(error)")
        }
    }

    private func formatBytes(_ bytes: Int) -> String {
        let units = ["B", "KB", "MB", "GB", "TB"]
        var index = 0
        var size = Double(bytes)

        while size > 1024 {
            size /= 1024
            index += 1
        }

        return String(format: "%.2f %@", size, units[index])
    }

    public func getCacheDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    }

    public func calculateDirectorySize(directory: URL) -> Int {
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
            var totalSize = 0
            for item in contents {
                let attributes = try FileManager.default.attributesOfItem(atPath: item.path)
                totalSize += attributes[.size] as? Int ?? 0
            }
            return totalSize
        } catch {
            print("Error calculating directory size: \(error)")
            return 0
        }
    }
}
