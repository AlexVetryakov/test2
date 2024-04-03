//
//  ReminderInfoStepViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 03.12.2023.
//

import UIKit
import Combine

final class ReminderInfoStepViewModel: CancellablesApplicable {
    
    @Published var schedulePatternType: SchedulePatternType?
    @Published private(set) var startDate: String = ""
    @Published private(set) var endDate: String = ""
    
    var daysCount: String { "\(model.daysCount)" }
    
    let timeSlotAppended = PassthroughSubject<DateComponents?, Never>()
    let changeTimeAtIndex = PassthroughSubject<(DateComponents, Int), Never>()
    
    var selectedWeekDayCalendarIndexes: [Int] { model.selectedWeekDayCalendarIndexes }
    var selectedTimeSlots: [DateComponents] { model.selectedTimeSlots }
    
    var cancellables: [AnyCancellable] = []

    private let model: ReminderInfoStepModel
    
    init(model: ReminderInfoStepModel) {
        self.model = model
        
        initializeBindings()
    }
    
    func select(schedulePatternType: SchedulePatternType) {
        model.schedulePatternType = schedulePatternType
    }
    
    func selectWeekDay(at calendarIndex: Int) {
        model.selectWeekDay(at: calendarIndex)
    } 
    
    func appendTimeSlot() {
        model.appendTimeSlot()
    }
    
    func removeTimeSlot(at index: Int) {
        model.removeTimeSlot(at: index)
    }
    
    func showTimePIcker(for index: Int) {
        model.showTimePIcker(for: index)
    }
    
    func timeSlotTitle(at index: Int) -> String {
        StringBuilder.Time.timeFrom(component: model.selectedTimeSlots[index])
    }
    
    func update(startDate: Date) {
        model.update(startDate: startDate)
    }
    
    func update(daysCount: String) {
        model.update(daysCount: Int(daysCount) ?? 1)
    }
    
    func createReminder() {
        model.createReminder()
    }
    
    // MARK: - Initialize bindings
    
    private func initializeBindings() {
        model.$schedulePatternType
             .sink { [weak self] type in
                 self?.schedulePatternType = type
             }
             .store(in: &cancellables)
        
        model.timeSlotAppended
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dateComponent in
                self?.timeSlotAppended.send(dateComponent)
            }
            .store(in: &cancellables)
        
        model.changeTimeAtIndex
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dateComponent, index in
                self?.changeTimeAtIndex.send((dateComponent, index))
            }
            .store(in: &cancellables)
        
        model.$startDate
             .sink { [weak self] date in
                 guard let self = self else { return }
                 
                 if date.isToday {
                     self.startDate = R.string.localizable.commonTodayTitle()
                 } else {
                     self.startDate = DateFormatter.dayMonthYearDate.string(from: date)
                 }
             }
             .store(in: &cancellables)
        
        model.$endDate
             .sink { [weak self] date in
                 guard let self = self else { return }
                 
                 self.endDate = DateFormatter.dayMonthYearDate.string(from: date)
             }
             .store(in: &cancellables)
    }
}
