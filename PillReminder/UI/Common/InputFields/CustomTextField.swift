//
//  CustomTextField.swift
//  PillReminder
//
//  Created by Александр Ветряков on 27.12.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    var enablePaste: Bool = true
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return enablePaste
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
