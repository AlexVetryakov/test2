//
//  ReminderInfoStepModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

final class ReminderInfoStepModel {
    
    struct ReminderInfo {
        let schedulePatternType: SchedulePatternType
        let startDate: Date
        let daysCount: Int
        let endDate: Date
        let weekDayIndexes: [Int]
        let timeSlots: [DateComponents]
    }
    
    @Published var schedulePatternType: SchedulePatternType?
    @Published private(set) var startDate: Date = Date()
    @Published private(set) var endDate: Date = Date().addDay(1)
    
    private(set) var daysCount: Int = 1
    let timeSlotAppended = PassthroughSubject<DateComponents?, Never>()
    let changeTimeAtIndex = PassthroughSubject<(DateComponents, Int), Never>()

    var selectedWeekDayCalendarIndexes: [Int] = [0, 1, 2, 3, 4, 5, 6]
    var selectedTimeSlots: [DateComponents] = []
    
    private var defaultTimeSlots: [DateComponents] = []
    private let handleEvents: ReminderInfoStepHandable

    init(handleEvents: ReminderInfoStepHandable) {
        self.handleEvents = handleEvents
        setupDefaults()
    }
    
    func createReminder() {
        let reminderInfo = ReminderInfo(
            schedulePatternType: schedulePatternType ?? .weekDays,
            startDate: startDate,
            daysCount: daysCount,
            endDate: endDate,
            weekDayIndexes: selectedWeekDayCalendarIndexes,
            timeSlots: selectedTimeSlots
        )
        handleEvents.finishStepAction(reminderInfo: reminderInfo)
    }
    
    func appendTimeSlot() {
        if selectedTimeSlots.isEmpty {
            selectedTimeSlots.append(defaultTimeSlots[0])
            timeSlotAppended.send(defaultTimeSlots[0])
        } else {
            guard let lastSelectedHour = selectedTimeSlots.last?.hour, let lastSelectedMinute = selectedTimeSlots.last?.minute else { return }

            if let nextTimeSlot = defaultTimeSlots.first(where: {
                $0.hour! > lastSelectedHour ||
                ($0.hour == lastSelectedHour && $0.minute! > lastSelectedMinute)
            }) {
                selectedTimeSlots.append(nextTimeSlot)
                timeSlotAppended.send(nextTimeSlot)
            } else {
                timeSlotAppended.send(nil)
            }
        }
    }
    
    func removeTimeSlot(at index: Int) {
        selectedTimeSlots.remove(at: index)
    }
    
    func showTimePIcker(for index: Int) {
        var maxDateComponent = DateComponents()
        var minDateComponent = DateComponents()
        
        if index == 0 && selectedTimeSlots.count == 1 {
            maxDateComponent.minute = 59
            maxDateComponent.hour = 23
            minDateComponent.minute = 0
            minDateComponent.hour = 0
        } else if index == 0 && selectedTimeSlots.count > 1 {
            maxDateComponent.minute = (selectedTimeSlots[index + 1].minute ?? 0) + 1
            maxDateComponent.hour = selectedTimeSlots[index + 1].hour
            minDateComponent.minute = 0
            minDateComponent.hour = 0
        } else if index == selectedTimeSlots.count - 1 {
            maxDateComponent.minute = 59
            maxDateComponent.hour = 23
            minDateComponent.minute = (selectedTimeSlots[index - 1].minute ?? 0) + 1
            minDateComponent.hour = selectedTimeSlots[index - 1].hour
        } else {
            maxDateComponent.minute = (selectedTimeSlots[index + 1].minute ?? 0) + 1
            maxDateComponent.hour = selectedTimeSlots[index + 1].hour
            minDateComponent.minute = (selectedTimeSlots[index - 1].minute ?? 0) + 1
            minDateComponent.hour = selectedTimeSlots[index - 1].hour
        }
        
        let calendar = Calendar.current
        guard let minDate = calendar.date(from: minDateComponent), 
                let maxDate = calendar.date(from: maxDateComponent),
                let currentDate = calendar.date(from: selectedTimeSlots[index]) else { return }
        handleEvents.showTimeChange(
            index: index,
            currentDate: currentDate,
            maxDate: maxDate,
            minDate: minDate,
            mode: .time
        ) { [weak self] date, index in
                let calendar = Calendar.current
                let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
            if let index = index {
                self?.selectedTimeSlots[index] = dateComponents
                self?.changeTimeAtIndex.send((dateComponents, index))
            }
        }
    }
    
    func selectWeekDay(at calendarIndex: Int) {
        if !selectedWeekDayCalendarIndexes.contains(where: { $0 == calendarIndex }) {
            selectedWeekDayCalendarIndexes.append(calendarIndex)
        } else {
            selectedWeekDayCalendarIndexes.enumerated().forEach { index, value in
                if value == calendarIndex {
                    selectedWeekDayCalendarIndexes.remove(at: index)
                }
            }
        }
    }
    
    func update(startDate: Date) {
        self.startDate = startDate
        endDate = startDate.addDay(daysCount)
    }
    
    func update(daysCount: Int) {
        self.daysCount = daysCount
        endDate = startDate.addDay(daysCount)
    }
    
    private func setupDefaults() {
        var time = DateComponents()
        time.hour = 6
        time.minute = 0
        defaultTimeSlots.append(time)
        time.hour = 9
        defaultTimeSlots.append(time)
        time.hour = 12
        defaultTimeSlots.append(time)
        time.hour = 15
        defaultTimeSlots.append(time)
        time.hour = 18
        defaultTimeSlots.append(time)
        time.hour = 21
        defaultTimeSlots.append(time)
        time.hour = 22
        defaultTimeSlots.append(time)
        time.minute = 30
        defaultTimeSlots.append(time)
        time.hour = 23
        time.minute = 0
        defaultTimeSlots.append(time)
        time.minute = 30
        defaultTimeSlots.append(time)
    }
    
}
