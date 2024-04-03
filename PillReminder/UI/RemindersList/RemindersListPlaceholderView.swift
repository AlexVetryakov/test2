//
//  RemindersListPlaceholderView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

final class RemindersListPlaceholderView: BaseView {
    
    let proceedButton = PrimaryButton()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    private func setupViews() {
        let iconImageView = UIImageView()
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(154.0 * Constants.UI.screenHeightRatio)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 72.0, height: 72.0))
        }
        iconImageView.image = R.image.pillIcon()
        
        let titleLabel = UILabel()
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(32.0 * Constants.UI.screenHeightRatio)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        titleLabel.numberOfLines = 0
        titleLabel.attributedText = R.string.localizable.reminderListPlaceholderTitle().setLineHeight(
            lineHeightMultiple: 1.1,
            font: R.font.openSansSemiBold(size: 18.0),
            textColor: R.color.textPrimary() ?? .black,
            paragraphAligment: .center
        )
        
        let subtitleLabel = UILabel()
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        subtitleLabel.numberOfLines = 0
        subtitleLabel.attributedText = R.string.localizable.reminderListPlaceholderSubtitle().setLineHeight(
            lineHeightMultiple: 1.1,
            font: R.font.openSansRegular(size: 16.0),
            textColor: R.color.textSecondary() ?? .gray,
            paragraphAligment: .center
        )
        
        addSubview(proceedButton)
        proceedButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(48.0)
            $0.bottom.lessThanOrEqualToSuperview()
        }
        proceedButton.setTitle(R.string.localizable.reminderListProceedButtonTitle(), for: .normal)
    }
}
