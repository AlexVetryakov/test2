//
//  UIView+Corners.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.12.2023.
//

import UIKit

extension UIView {
    
    func makeViewRound() {
        addCornerRadius(min(bounds.height, bounds.width) / 2)
    }
    
    func addCornerRadius(
        _ radius: CGFloat,
        corners: CACornerMask = [
        .layerMaxXMaxYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMaxYCorner,
        .layerMinXMinYCorner]) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        layer.masksToBounds = true
    }

}

