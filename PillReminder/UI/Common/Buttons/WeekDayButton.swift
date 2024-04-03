//
//  WeekDayButton.swift
//  PillReminder
//
//  Created by Александр Ветряков on 04.01.2024.
//

import UIKit

final class WeekDayButton: UIButton {
    
    private let selectedBackgrunColor: UIColor = R.color.buttonPrimary10() ?? .blue
    private let deselectedBackgroundColor: UIColor = R.color.buttonSecondary() ?? .white
    private let selectedTitleColor: UIColor = R.color.textBlue() ?? .blue
    private let deselectedTitleColor: UIColor = R.color.textPrimary() ?? .white
    private let titleFont: UIFont = R.font.openSansRegular(size: 14.0) ?? UIFont()

    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            layer.backgroundColor = newValue ? selectedBackgrunColor.cgColor : deselectedBackgroundColor.cgColor
            setTitleColor(newValue ? selectedTitleColor : deselectedTitleColor, for: .normal)
            super.isSelected = newValue
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
        layer.backgroundColor = isSelected ? selectedBackgrunColor.cgColor : deselectedBackgroundColor.cgColor
        setTitleColor(isSelected ? selectedTitleColor : deselectedTitleColor, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        titleLabel?.font = titleFont
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
    }

}
