//
//  String+Attributed.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.12.2023.
//

import UIKit

extension String {

    func setLineHeight(
        lineHeightMultiple: CGFloat,
        font: UIFont?,
        textColor: UIColor,
        paragraphSpacing: CGFloat = 0.0,
        paragraphAligment: NSTextAlignment = .left
    ) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.paragraphSpacing = paragraphSpacing
        paragraphStyle.alignment = paragraphAligment
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attrString.length)
        )
        guard let font = font else { return attrString }
        attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: textColor,
            range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
    func setUnderLine(
        lineHeightMultiple: CGFloat = 1.0,
        font: UIFont?,
        textColor: UIColor,
        paragraphAligment: NSTextAlignment = .left
    ) -> NSAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        paragraphStyle.alignment = paragraphAligment
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attrString.length)
        )
        attrString.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue], range: NSMakeRange(0, attrString.length))
        
        guard let font = font else { return attrString }
        attrString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attrString.length))
        attrString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: textColor,
            range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }

}
