//
//  TimePickerModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 16.01.2024.
//

import UIKit

enum TimePickerEvent: NavigationEvent {
    case close
}

final class TimePickerModel: NavigationNode {
    
    var maxDate: Date?
    var minDate: Date?
    var currentDate: Date?
    let mode: UIDatePicker.Mode
    
    private var selectedDate: Date?
    private let completion: ((Date, Int?) -> Void)?
    private let index: Int?
    
    init(
        parent: NavigationNode?,
        index: Int?,
        currentDate: Date?,
        maxDate: Date?,
        minDate: Date?,
        mode: UIDatePicker.Mode,
        completion: ((Date, Int?) -> Void)?) {
            self.completion = completion
            self.index = index
            self.currentDate = currentDate
            self.maxDate = maxDate
            self.minDate = minDate
            self.mode = mode
        
            super.init(parent: parent)
    }
    
    func select(date: Date) {
        selectedDate = date
    }
    
    func acceptSelected() {
        guard let selectedDate = selectedDate else { return }
        
        completion?(selectedDate, index)
        raise(event: TimePickerEvent.close)
    }
    
    func close() {
        raise(event: TimePickerEvent.close)
    }

}
