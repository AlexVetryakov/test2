//
//  ReminderInfoStepView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit

final class ReminderInfoStepView: BaseView {
    
    let scheduleCardView = ScheduleCardView()
    let dailyPillsCardView = DailyPillsCardView()
    let periodCardView = PeriodCardView()
    let actionButton = PrimaryButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()

    override init() {

        super.init()

        backgroundColor = R.color.backgroundPrimary()
        setupViews()
        setupGestures()
    }
    
    func update(schedulePatternType: SchedulePatternType?) {
        guard let schedulePatternType = schedulePatternType else {
            
            scheduleCardView.weekDaysView.isHidden = true
            return
        }
        switch schedulePatternType {
        case .weekDays:
            scheduleCardView.weekDaysView.isHidden = false
            scheduleCardView.daysSelectableView.update(isSelected: true)
            scheduleCardView.cycleSelectableView.update(isSelected: false)
            
        case .cycles:
            scheduleCardView.weekDaysView.isHidden = true
            scheduleCardView.daysSelectableView.update(isSelected: false)
            scheduleCardView.cycleSelectableView.update(isSelected: true)
        }
    }
    
    func animateKayboard(duration: CGFloat, keyboardHeight: CGFloat) {
        if keyboardHeight == 0.0 {
            contentView.snp.remakeConstraints {
                $0.edges.equalToSuperview()
                $0.width.equalToSuperview()
          }
        } else {
            contentView.snp.remakeConstraints {
                $0.width.leading.trailing.equalToSuperview()
                $0.centerY.equalToSuperview().offset(-keyboardHeight)
          }
        }

        UIView.animate(withDuration: duration, delay: TimeInterval(0), animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        endEditing(true)
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
        
        contentView.backgroundColor = R.color.backgroundPrimary()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(scheduleCardView)
        stackView.addArrangedSubview(dailyPillsCardView)
        dailyPillsCardView.isHidden = true
        stackView.addArrangedSubview(periodCardView)
        periodCardView.isHidden = true
        stackView.addArrangedSubview(actionButton)
        actionButton.isHidden = true
        actionButton.setTitle(R.string.localizable.commonCreateTitle(), for: .normal)
        actionButton.snp.makeConstraints {
            $0.height.equalTo(48.0)
        }
    }

}
