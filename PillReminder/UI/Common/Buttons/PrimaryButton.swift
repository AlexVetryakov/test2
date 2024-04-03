//
//  PrimaryButton.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

final class PrimaryButton: UIButton {
    
    private let enabledBackgrunColor: UIColor = R.color.buttonPrimary() ?? .blue
    private let disabledBackgroundColor: UIColor = R.color.buttonPrimary10() ?? .blue.withAlphaComponent(0.1)
    private let enabledTitleColor: UIColor = R.color.primaryButtonEnableText() ?? .white
    private let disabledTitleColor: UIColor = R.color.primaryButtonDisableText() ?? .white
    private let titleFont: UIFont = R.font.openSansSemiBold(size: 16.0) ?? UIFont()

    override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            layer.backgroundColor = newValue ? enabledBackgrunColor.cgColor : disabledBackgroundColor.cgColor
            setTitleColor(newValue ? enabledTitleColor : disabledTitleColor, for: .normal)
            super.isEnabled = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 8.0
        layer.backgroundColor = isEnabled ? enabledBackgrunColor.cgColor : disabledBackgroundColor.cgColor
        setTitleColor(isEnabled ? enabledTitleColor : disabledTitleColor, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        titleLabel?.font = titleFont
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
    }

}


