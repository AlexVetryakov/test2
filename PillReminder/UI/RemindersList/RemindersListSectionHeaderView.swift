//
//  RemindersListSectionHeaderView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.12.2023.
//

import UIKit

final class RemindersListSectionHeaderView: BaseView, Reusable {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(16.0)
    }
    
    func apply(title: String, isCurrent: Bool) {
        titleLabel.attributedText = title.setLineHeight(
            lineHeightMultiple: 1.05,
            font: R.font.openSansRegular(size: 14.0),
            textColor: isCurrent ? R.color.textBlue() ?? .blue : R.color.textPrimary() ?? .black,
            paragraphAligment: .center
        )
        containerView.backgroundColor = isCurrent ? R.color.buttonPrimary10() ?? .blue : R.color.buttonSecondary10() ?? .lightGray
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.bottom.equalToSuperview().offset(-12.0)
            $0.centerX.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview().inset(4.0)
        }
        titleLabel.numberOfLines = 1
    }

}
