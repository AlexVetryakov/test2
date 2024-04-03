//
//  RemindPresentable.swift
//  PillReminder
//
//  Created by Александр Ветряков on 01.12.2023.
//

import UIKit

struct RemindPresentable {
    let name: String
    let date: Date
    let dose: String
    let iconImage: UIImage
    let status: PlannedRemindStatus
    let uuid: String
    
    var time: String {
        DateFormatter.hourMinutesDate.string(from: date)
    }
    
    var datePresentable: String {
        if date.isCurrentYear {
            return DateFormatter.monthDate.string(from: date)
        } else {
            return DateFormatter.monthYearDate.string(from: date)
        }
    }
    
    init(plannedRemind: PlannedRemind) {
        self.name = plannedRemind.remind?.name ?? ""
        self.status = plannedRemind.status
        self.iconImage = plannedRemind.status == .confirmed ? R.image.confirmed() ?? UIImage() : plannedRemind.remind?.form.icon ?? UIImage()
        self.uuid = plannedRemind.uuid
        self.date = plannedRemind.date
        self.dose = StringBuilder.Dose.doseFrom(drugFormType: plannedRemind.remind?.form ?? .tablet, count: plannedRemind.remind?.dose ?? 0.0)
    }
}
