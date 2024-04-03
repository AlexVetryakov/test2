//
//  TimePickerViewModel.swift
//  PillReminder
//
//  Created by Александр Ветряков on 16.01.2024.
//

import UIKit

final class TimePickerViewModel {

    private let model: TimePickerModel
    
    init(model: TimePickerModel) {
        self.model = model
        
    }
    
    func minDate() -> Date? {
        model.minDate
    }
    
    func maxDate() -> Date? {
        model.maxDate
    }
    
    func currentDate() -> Date? {
        model.currentDate
    }
    
    func mode() -> UIDatePicker.Mode {
        model.mode
    }
    
    func select(date: Date) {
        model.select(date: date)
    }
    
    func acceptSelected() {
        model.acceptSelected()
    }
    
    func close() {
        model.close()
    }

}
