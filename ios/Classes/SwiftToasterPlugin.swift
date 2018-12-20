import Flutter
import UIKit

public class SwiftToasterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "toaster", binaryMessenger: registrar.messenger())
    let instance = SwiftToasterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method == "getPlatformVersion") {
        result("iOS " + UIDevice.current.systemVersion)
    } else if (call.method == "toast" ) {
        let v = call.arguments as! [String:Any]
        let msg = v["message"] as! String
        let duration = v["duration"] as! Int
        
        showToast(msg: msg, duration: duration)
        
        result("Ini dari toaster")
    } else {
        result(FlutterMethodNotImplemented)
    }
  }
    
    func showToast(msg: String, duration: Int) {
        let viewController: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        
        //for LENGTH_SHORT 2 seconds, for LENGTH_LONG 3.5 seconds
        //source: https://stackoverflow.com/a/5079536/1730430
        var d = 2.0
        if(duration == 1) {
            d = 3.5
        }
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .actionSheet)
        
        viewController?.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Double(d) * Double(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            alert.dismiss(animated: true)
        })
    }
}
