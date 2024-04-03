//
//  ScheduleCardView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 08.01.2024.
//

import UIKit

final class ScheduleCardView: BaseView {
    
    let daysSelectableView = ScheduleSelectableView()
    let cycleSelectableView = ScheduleSelectableView()
    let weekDaysView = WeekDaysView()
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let separatorContainerView = UIView()

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
        titleLabel.text = R.string.localizable.reminderInfoScheduleTitle()
        
        containerView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview()
        }
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(daysSelectableView)
        daysSelectableView.apply(title: R.string.localizable.reminderInfoDaysTitle())
        
        stackView.addArrangedSubview(weekDaysView)
        weekDaysView.isHidden = true
        
        separatorContainerView.backgroundColor = .clear
        let separatorView = UIView()
        separatorContainerView.addSubview(separatorView)
        separatorView.backgroundColor = R.color.divider()
        separatorView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1.0)
            $0.top.equalTo(15.0)
        }
        stackView.addArrangedSubview(separatorContainerView)
        
        stackView.addArrangedSubview(cycleSelectableView)
        cycleSelectableView.apply(title: R.string.localizable.reminderInfoCyclesTitle())
    }

}
