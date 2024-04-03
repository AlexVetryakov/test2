//
//  PeriodCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 11.01.2024.
//

import UIKit

final class PeriodCardView: BaseView {
    
    let startPeriodInputField = CommonInputField(configurator: .init(enablePaste: false))
    let daysPeriodInputField = CommonInputField(configurator: .init(keyboardType: .numberPad, enablePaste: false))
    let endPeriodInputField = CommonInputField(configurator: .init(isKeyboardNeeded: false, enablePaste: false))

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let startPeriodLabel = UILabel()
    private let daysPeriodLabel = UILabel()
    private let endPeriodLabel = UILabel()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
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
            $0.leading.trailing.top.equalToSuperview().inset(16.0)
        }
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .left
        titleLabel.text = R.string.localizable.reminderInfoReceptionPeriodTitle()
        
        containerView.addSubview(startPeriodLabel)
        startPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        startPeriodLabel.numberOfLines = 1
        startPeriodLabel.font = R.font.openSansRegular(size: 14.0)
        startPeriodLabel.textColor = R.color.textPrimary()
        startPeriodLabel.textAlignment = .left
        startPeriodLabel.text = R.string.localizable.reminderInfoStartPeriodTitle()
        
        containerView.addSubview(startPeriodInputField)
        startPeriodInputField.snp.makeConstraints {
            $0.top.equalTo(startPeriodLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().offset(16.0)
            $0.width.equalTo(114.0 * Constants.UI.screenWidthRatio)
            $0.bottom.equalToSuperview().offset(-16.0)
        }
        startPeriodInputField.setupDatePicker()
        
        containerView.addSubview(daysPeriodLabel)
        daysPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(startPeriodInputField.snp.trailing).offset(12.0)
        }
        daysPeriodLabel.numberOfLines = 1
        daysPeriodLabel.font = R.font.openSansRegular(size: 14.0)
        daysPeriodLabel.textColor = R.color.textPrimary()
        daysPeriodLabel.textAlignment = .left
        daysPeriodLabel.text = R.string.localizable.reminderInfoDaysPeriodTitle()
        
        containerView.addSubview(daysPeriodInputField)
        daysPeriodInputField.snp.makeConstraints {
            $0.top.equalTo(daysPeriodLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(startPeriodInputField.snp.trailing).offset(12.0)
            $0.width.equalTo(60.0 * Constants.UI.screenWidthRatio)
        }
        
        containerView.addSubview(endPeriodLabel)
        endPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(daysPeriodInputField.snp.trailing).offset(12.0)
        }
        endPeriodLabel.numberOfLines = 1
        endPeriodLabel.font = R.font.openSansRegular(size: 14.0)
        endPeriodLabel.textColor = R.color.textPrimary()
        endPeriodLabel.textAlignment = .left
        endPeriodLabel.text = R.string.localizable.reminderInfoEndPeriodTitle()
        
        containerView.addSubview(endPeriodInputField)
        endPeriodInputField.snp.makeConstraints {
            $0.top.equalTo(endPeriodLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(daysPeriodInputField.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().offset(-16.0)
        }
    }

}
