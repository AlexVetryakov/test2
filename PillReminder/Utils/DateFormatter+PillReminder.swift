//
//  DateFormatter+PillReminder.swift
//  PillReminder
//
//  Created by Александр Ветряков on 18.01.2024.
//

import Foundation

extension DateFormatter {
    
    static let dayMonthYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter
    }()
    
    static let hourMinutesDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    static let monthDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter
    }()
    
    static let monthYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()
    
    static let weekDayMonthYearDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        return dateFormatter
    }()

}
