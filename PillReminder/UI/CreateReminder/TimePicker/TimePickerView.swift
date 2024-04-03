//
//  TimePickerView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 16.01.2024.
//

import UIKit

final class TimePickerView: BaseView {
    
    var closeAction: (() -> Void)?

    let actionButton = PrimaryButton()
    let datePickerView = UIDatePicker()
    
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let backView = UIView()

    // MARK: - Life Cycle

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addCornerRadius(24.0)
    }
    
    private func setupViews() {
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        backView.backgroundColor = .black.withAlphaComponent(0.3)
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(backAction))
        backView.addGestureRecognizer(tapGesture)
        
        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.centerY.equalToSuperview()
        }
        contentView.backgroundColor = R.color.backgroundPrimary()
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16.0)
        }
        titleLabel.text = R.string.localizable.timePickerTitle()
        titleLabel.numberOfLines = 1
        titleLabel.font = R.font.openSansSemiBold(size: 16.0)
        titleLabel.textColor = R.color.textPrimary()
        titleLabel.textAlignment = .center
        
        contentView.addSubview(datePickerView)
        datePickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.height.equalTo(300.0 * Constants.UI.screenHeightRatio)
        }
        
        contentView.addSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16.0)
            $0.height.equalTo(44.0)
            $0.top.equalTo(datePickerView.snp.bottom).offset(8.0)
        }
        actionButton.setTitle(R.string.localizable.commonAcceptTitle(), for: .normal)
    }
    
    @objc
    private func backAction() {
        closeAction?()
    }
}
