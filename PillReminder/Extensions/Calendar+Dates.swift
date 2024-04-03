//
//  Calendar+Dates.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import UIKit

extension Calendar {
    func datesRange(from: Date, to: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = from
        
        while currentDate <= to {
            dates.append(currentDate)
            guard let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDate
        }
        
        return dates
    }
    
    func daysBetweenDates(_ startDate: Date, _ endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        guard let days = components.day else {
            return 0
        }
        
        return days
    }

}
