//
//  RemindEntity+CoreData.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import Foundation
import CoreData

extension RemindEntity {
    
    func binaryToTimeSlots() -> [DateComponents]? {
        guard let timeSlots = timeSlots else { return [] }
        
        let decoder = PropertyListDecoder()
        return try? decoder.decode([DateComponents].self, from: timeSlots)
    }
    
    func binaryToWeekDaysIndexes() -> [Int]? {
        guard let weekDaysIndexes = weekDaysIndexes else { return [] }
        
        return (try? JSONSerialization.jsonObject(with: weekDaysIndexes, options: [])) as? [Int]
    }
    
    static func createFetchRequest(by uuid: String) -> NSFetchRequest<RemindEntity> {
        let request = NSFetchRequest<RemindEntity>(entityName: "RemindEntity")
        let filter = [
            NSPredicate(format: "uuid == %@", argumentArray: [uuid]),
        ]
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filter)
        request.predicate = predicate
        return request
    }

}
