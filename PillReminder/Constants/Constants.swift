//
//  Constants.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

struct Constants {

    // MARK: - UI
    struct UI {
        static let screenHeightRatio: CGFloat = (UIScreen.main.bounds.size.height / 812.0)
        static let screenWidthRatio: CGFloat = (UIScreen.main.bounds.size.width / 375.0)
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        static let topConstraint: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0.0
        static let botomConstraint: CGFloat = UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0.0
    }
}
