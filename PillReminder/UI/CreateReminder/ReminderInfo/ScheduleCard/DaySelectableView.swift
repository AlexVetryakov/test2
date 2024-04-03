//
//  DaySelectableView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 04.01.2024.
//

import UIKit

final class DaySelectableView: BaseView {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    private var isSelected = false

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    func select() {
        isSelected = !isSelected
        backgroundColor = isSelected ? R.color.buttonPrimary10() : R.color.buttonSecondary()
        titleLabel.textColor = isSelected ? R.color.textBlue() : R.color.textPrimary()
    }
    
    func apply(title: String) {
        titleLabel.text = title
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }

}
