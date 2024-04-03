//
//  ReminderService.swift
//  PillReminder
//
//  Created by Александр Ветряков on 23.01.2024.
//

import Foundation
import CoreData

final class ReminderService {
    
    private let dataBaseClient: DataBaseClient
    
    init(dataBaseClient: DataBaseClient) {
        self.dataBaseClient = dataBaseClient
    }
    
    func createReminds(reminderInfo: ReminderInfoStepModel.ReminderInfo, pillInfo: PillInfoStepModel.PillInfo) {
        let remind = Remind(
            uuid: UUID().uuidString,
            userUuid: "",
            daysCount: reminderInfo.daysCount,
            dose: pillInfo.dose, 
            name: pillInfo.name,
            endDate: reminderInfo.endDate,
            startDate: reminderInfo.startDate,
            form: pillInfo.form,
            imageUrl: "",
            timeSlots: reminderInfo.timeSlots,
            weekDaysIndexes: reminderInfo.weekDayIndexes,
            scheduleType: reminderInfo.schedulePatternType
        )
        
        guard let remindEntity = dataBaseClient.createAndSave(from: remind) else { return }
        
        let dates: [Date] = Calendar.current.datesRange(from: reminderInfo.startDate, to: reminderInfo.endDate.startOfDay)
        
        dates.forEach { value in
            remind.timeSlots.forEach { timeSlot in
                if let updatedDate = Calendar.current.date(bySettingHour: timeSlot.hour ?? 0, minute: timeSlot.minute ?? 0, second: 0, of: value) {
                    if remind.weekDaysIndexes.contains(weekDayIndex(from: updatedDate)) {
                        let plannedRemind = PlannedRemind(
                            uuid: UUID().uuidString,
                            userUuid: "",
                            date: updatedDate,
                            status: .planed,
                            remind: remind
                        )
                        dataBaseClient.createAndSave(from: plannedRemind, remind: remindEntity)
                    }
                }
            }
        }
    }
    
    func update(status: PlannedRemindStatus, for uuid: String) {
        dataBaseClient.update(status: status, for: uuid)
    }
    
    func getPlannedReminds(from date: Date) -> [PlannedRemind] {
        let request = PlannedRemindEntity.createFetchRequest(from: date)
        let plannedReminds = dataBaseClient.fetch(request).map { PlannedRemind(from: $0) }
        
        return plannedReminds
    }
    
    func getPlannedRemindersAfter(controlDate: Date, page: Int, perPage: Int) -> [PlannedRemind] {
        let request = PlannedRemindEntity.fetchRemindersAfter(controlDate: controlDate, page: page, perPage: perPage)
        let plannedReminds = dataBaseClient.fetch(request).map { PlannedRemind(from: $0) }
        
        return plannedReminds
    }
    
    func getPlannedRemindersBefore(controlDate: Date, page: Int, perPage: Int) -> [PlannedRemind] {
        let request = PlannedRemindEntity.fetchRemindersBefore(controlDate: controlDate, page: page, perPage: perPage)
        let plannedReminds = dataBaseClient.fetch(request).map { PlannedRemind(from: $0) }
        
        return plannedReminds
    }
    
    func getDefaultPlannedReminders(controlDate: Date) -> [PlannedRemind] {
        let beforeRequest = PlannedRemindEntity.fetchRemindersBefore(controlDate: controlDate, page: 0, perPage: 30)
        let afterRequest = PlannedRemindEntity.fetchRemindersAfter(controlDate: controlDate, page: 0, perPage: 30)
        
        let beforeReminds = dataBaseClient.fetch(beforeRequest).map { PlannedRemind(from: $0) }
        let afterReminds = dataBaseClient.fetch(afterRequest).map { PlannedRemind(from: $0) }
        
        let combinedReminders = beforeReminds + afterReminds
        return combinedReminders
    }
    
    private func weekDayIndex(from date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "UK-uk")
        let indexOfFirstWeekday = (Calendar.current.firstWeekday - 1) % 7
        let components = calendar.dateComponents([.weekday], from: date)
        
        guard let weekday = components.weekday else { return -1 }
        
        let adjustedIndex = (weekday + indexOfFirstWeekday + 5) % 7
        return adjustedIndex
    }

}
