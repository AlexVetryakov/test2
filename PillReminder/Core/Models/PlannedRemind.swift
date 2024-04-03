//
//  PlannedRemind.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import UIKit

struct PlannedRemind {

    let uuid: String
    let userUuid: String
    let date: Date
    let status: PlannedRemindStatus
    var remind: Remind?
    
    init(from plannedRemindEntity: PlannedRemindEntity) {
        self.uuid = plannedRemindEntity.uuid ?? ""
        self.userUuid = plannedRemindEntity.userUuid ?? ""
        self.date = plannedRemindEntity.date ?? Date()
        self.status = PlannedRemindStatus(rawValue: Int(plannedRemindEntity.status)) ?? .planed
        if let remind = plannedRemindEntity.remind {
            self.remind = Remind(from: remind)
        }
    }
    
    init(
        uuid: String,
        userUuid: String,
        date: Date,
        status: PlannedRemindStatus,
        remind: Remind?
    ) {
        self.uuid = uuid
        self.userUuid = userUuid
        self.date = date
        self.status = status
        self.remind = remind
    }
}
