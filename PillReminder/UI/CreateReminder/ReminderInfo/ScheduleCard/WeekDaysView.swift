//
//  WeekDaysView.swift
//  PillReminder
//
//  Created by Александр Ветряков on 04.01.2024.
//

import UIKit

final class WeekDaysView: BaseView {

    var daySelectedHandler: ((Int) -> Void)?
    
    private var days: [WeekDayButton] = []
    private let daysStackView = UIStackView()

    override init() {

        super.init()

        backgroundColor = .clear
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        days.forEach { $0.addCornerRadius(18.0) }
    }
    
    func apply(selectedDays: [Int]) {
        days.enumerated().forEach { index, value in
            if selectedDays.contains(where: { $0 == value.tag }) {
                value.isSelected = true
            }
        }
    }
    
    private func setupViews() {
        addSubview(daysStackView)
        daysStackView.axis = .horizontal
        daysStackView.distribution = .equalSpacing
        daysStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        daysStackView.backgroundColor = .clear
        
        for index in 0...6  {
            let dayButton = WeekDayButton()
            dayButton.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 36.0 * Constants.UI.screenWidthRatio, height: 36.0 * Constants.UI.screenWidthRatio))
            }
            dayButton.setTitle(weekDayTitle(at: index).title, for: .normal)
            dayButton.isSelected = false
            dayButton.tag = weekDayTitle(at: index).calendarIndex
            dayButton.addTarget(self, action: #selector(dayOfWeekTouchUpInside), for: .touchUpInside)
            days.append(dayButton)
            daysStackView.addArrangedSubview(dayButton)
        }
    }
    
    @objc
    private func dayOfWeekTouchUpInside(sender: UIButton) {
        daySelectedHandler?(sender.tag)
        sender.isSelected = !sender.isSelected
    }
    
    private func weekDayTitle(at index: Int) -> (title: String, calendarIndex: Int) {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "UK-uk")
        let indexOfFirstWeekday = (Calendar.current.firstWeekday - 1) % 7
        let adjustedIndex = (index + indexOfFirstWeekday + 7) % 7
        return (title: calendar.shortWeekdaySymbols[adjustedIndex].capitalized, calendarIndex: adjustedIndex)
    }

}
