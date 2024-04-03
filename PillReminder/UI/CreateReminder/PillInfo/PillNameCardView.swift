//
//  PillNameCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 27.12.2023.
//

import UIKit

final class PillNameCardView: BaseView {
    
    let nameInputField = CommonInputField(configurator: CommonInputField.Configurator(allowedRegex: "^.{0,20}$"))
    
    private let containerView = UIView()
    private let titleLabel = UILabel()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(12.0)
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.backgroundColor = R.color.backgroundSecondary()
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16.0)
        }
        titleLabel.text = R.string.localizable.pillInfoNameTitle()
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        
        containerView.addSubview(nameInputField)
        nameInputField.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
        }
    }

}
