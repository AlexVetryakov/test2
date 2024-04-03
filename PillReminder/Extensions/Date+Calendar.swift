//
//  Date+Calendar.swift
//  PillReminder
//
//  Created by Александр Ветряков on 02.12.2023.
//

import Foundation

extension Date {
        
    private static var calendar = Calendar(identifier: .gregorian)
    
    var isToday: Bool {
        Date.calendar.isDateInToday(self)
    }
    
    var isCurrentYear: Bool {
        Date.calendar.dateComponents([.year], from: self).year == Date.calendar.dateComponents([.year], from: Date()).year
    }
    
    var startOfDay: Date {
        Date.calendar.startOfDay(for: self)
    }
    
    var startOfMonth: Date? {
        Date.calendar.date(from: Date.calendar.dateComponents([.year, .month], from: startOfDay))
    }
    
    func addDay(_ day: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: day, to: self) ?? Date()
    }
    
}
