//
//  Remind.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import UIKit

struct Remind {

    let uuid: String
    let userUuid: String
    let daysCount: Int
    let dose: Double
    let name: String
    let endDate: Date
    let startDate: Date
    let form: DrugFormType
    let imageUrl: String?
    let timeSlots: [DateComponents]
    let scheduleType: SchedulePatternType
    let weekDaysIndexes: [Int]
    
    func binaryTimeSlots() -> Data? {
        let encoder = PropertyListEncoder()
        return try? encoder.encode(timeSlots)
    }
    
    func binaryWeekDaysIndexes() -> Data? {
        try? JSONSerialization.data(withJSONObject: weekDaysIndexes, options: [])
    }
    
    init(from remindEntity: RemindEntity) {
        self.uuid = remindEntity.uuid ?? ""
        self.userUuid = remindEntity.userUuid ?? ""
        self.daysCount = Int(remindEntity.daysCount)
        self.dose = remindEntity.dose
        self.name = remindEntity.name ?? ""
        self.endDate = remindEntity.endDate ?? Date()
        self.startDate = remindEntity.startDate ?? Date()
        self.form = DrugFormType(rawValue: Int(remindEntity.form)) ?? .tablet
        self.imageUrl = remindEntity.imageUrl
        self.timeSlots = remindEntity.binaryToTimeSlots() ?? []
        self.weekDaysIndexes = remindEntity.binaryToWeekDaysIndexes() ?? []
        self.scheduleType = SchedulePatternType(rawValue: Int(remindEntity.scheduleType)) ?? .weekDays
    }
    
    init(
        uuid: String,
        userUuid: String,
        daysCount: Int,
        dose: Double,
        name: String,
        endDate: Date,
        startDate: Date,
        form: DrugFormType,
        imageUrl: String?,
        timeSlots: [DateComponents],
        weekDaysIndexes: [Int],
        scheduleType: SchedulePatternType
    ) {
        self.uuid = uuid
        self.userUuid = userUuid
        self.daysCount = daysCount
        self.dose = dose
        self.name = name
        self.endDate = endDate
        self.startDate = startDate
        self.form = form
        self.imageUrl = imageUrl
        self.timeSlots = timeSlots
        self.weekDaysIndexes = weekDaysIndexes
        self.scheduleType = scheduleType
    }
}
