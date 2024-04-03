//
//  UIApplication+Window.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.12.2023.
//

import UIKit

extension UIApplication {
    class func topViewController() -> UIViewController? {
        if let window = UIApplication.shared.delegate!.window {
            return window?.visibleViewController
        }
        else if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first {
            return window.visibleViewController
        }
        return nil
    }
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first(where: { $0 is UIWindowScene }).flatMap({ $0 as? UIWindowScene })?.windows.first(where: \.isKeyWindow)
    }
}
