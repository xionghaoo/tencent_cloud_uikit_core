import Flutter
import UIKit

public class SwiftTencentCloudUikitCorePlugin: NSObject, FlutterPlugin {

    static let channelName = "tuicore"
    private let channel: FlutterMethodChannel
    let registrar: FlutterPluginRegistrar
    var messager: FlutterBinaryMessenger {
       return registrar.messenger()
    }

    init(registrar: FlutterPluginRegistrar) {
       self.channel = FlutterMethodChannel(name: SwiftTencentCloudUikitCorePlugin.channelName, binaryMessenger: registrar.messenger())
       self.registrar = registrar
       super.init()
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
       let instance = SwiftTencentCloudUikitCorePlugin.init(registrar: registrar)
       registrar.addMethodCallDelegate(instance, channel: instance.channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "showToast":
            showToast(call, result: result)
        default:
            break
        }
    }
    
    public func showToast(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let content = MethodUtils.getMethodParams(call: call, key: "content", resultType: String.self) else {
            FlutterResultUtils.handleMethod(code: .paramNotFound, methodName: "showToast", paramKey: "content", result: result)
            return
        }

        guard let durationEnum = MethodUtils.getMethodParams(call: call, key: "duration", resultType: Int.self) else {
            FlutterResultUtils.handleMethod(code: .paramNotFound, methodName: "showToast", paramKey: "duration", result: result)
            return
        }

        guard let gravityEnum = MethodUtils.getMethodParams(call: call, key: "gravity", resultType: Int.self) else {
            FlutterResultUtils.handleMethod(code: .paramNotFound, methodName: "showToast", paramKey:  "gravity", result: result)
            return
        }

        let duration = durationEnum == 0 ? 2 : 4
        var position: ToastPosition = .bottom
        switch(gravityEnum) {
        case 0:
            position = .top
        case 1:
            position = .bottom
        case 2:
            position = .center
        default:
            position = .bottom
        }
        
        Toast.show(message: content, duration: TimeInterval(duration), position: position)
        result(NSNumber(value: 0))
    }
    
    func getKeyWindow() -> UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
