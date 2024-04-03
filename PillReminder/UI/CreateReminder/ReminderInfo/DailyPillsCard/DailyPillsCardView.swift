//
//  DailyPillsCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 09.01.2024.
//

import UIKit

final class DailyPillsCardView: BaseView {
    
    var deleteTimeAction: ((Int) -> Void)?
    var changeTimeAction: ((Int) -> Void)?
    
    let plusButton = UIButton()
    let paramsButton = UIButton()
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let countLabel = UILabel()
    private let stackView = UIStackView()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
    }
    
    func apply(title: String) {
        countLabel.text = title
    }
    
    func append(time: String, index: Int) {
        let dailyTimeView = DailyTimeView()
        dailyTimeView.tag = index
        dailyTimeView.apply(time: time, count: "\(index + 1)")
        dailyTimeView.changeTimeAction = changeTimeAction
        dailyTimeView.deleteAction = deleteTimeAction
        stackView.addArrangedSubview(dailyTimeView)
    }
    
    func update(time: String, index: Int) {
        guard let dailyTimeView = stackView.arrangedSubviews[index] as? DailyTimeView else { return }
        
        dailyTimeView.apply(time: time, count: "\(index + 1)")
    }
    
    func remove(at index: Int) {
        stackView.arrangedSubviews[index].removeFromSuperview()
        stackView.arrangedSubviews.enumerated().forEach { ind, value in
            stackView.arrangedSubviews[ind].tag = ind
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.addCornerRadius(12.0)
        plusButton.addCornerRadius(8.0)
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
        titleLabel.text = R.string.localizable.reminderInfoDailyPillsTitle()
        
        containerView.addSubview(plusButton)
        plusButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24.0)
            $0.trailing.equalToSuperview().offset(-16.0)
            $0.size.equalTo(CGSize(width: 48.0, height: 40.0))
        }
        
        plusButton.setImage(R.image.plus(), for: .normal)
        plusButton.backgroundColor = .white
        
        containerView.addSubview(countLabel)
        countLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.centerY.equalTo(plusButton.snp.centerY)
        }
        countLabel.numberOfLines = 1
        countLabel.font = R.font.openSansRegular(size: 14.0)
        countLabel.textColor = R.color.textPrimary()
        countLabel.textAlignment = .left
        
        containerView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        containerView.addSubview(paramsButton)
        paramsButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(32.0)
            $0.top.equalTo(stackView.snp.bottom).offset(10.0)
            $0.bottom.equalToSuperview().offset(-10.0)
        }
        paramsButton.setTitle(R.string.localizable.reminderInfoExtensionParametersTitle(), for: .normal)
        paramsButton.backgroundColor = .clear
        paramsButton.titleLabel?.font = R.font.openSansRegular(size: 14.0)
        paramsButton.setTitleColor(R.color.textSecondary(), for: .normal)
        paramsButton.contentMode = .center
        #warning("Remove it after logic added")
        paramsButton.isEnabled = false
    }
}
