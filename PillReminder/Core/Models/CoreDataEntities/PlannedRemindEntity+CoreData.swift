//
//  PlannedRemindEntity+CoreData.swift
//  PillReminder
//
//  Created by Александр Ветряков on 24.01.2024.
//

import Foundation
import CoreData

extension PlannedRemindEntity {
    
    static func createFetchRequest(from date: Date) -> NSFetchRequest<PlannedRemindEntity> {
        let request = NSFetchRequest<PlannedRemindEntity>(entityName: "PlannedRemindEntity")
        let filter = [
            NSPredicate(format: "date >= %@", argumentArray: [date]),
        ]
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filter)
        request.predicate = predicate
        return request
    }
    
    static func createFetchRequest(for uuid: String) -> NSFetchRequest<PlannedRemindEntity> {
        let request = NSFetchRequest<PlannedRemindEntity>(entityName: "PlannedRemindEntity")
        let filter = [
            NSPredicate(format: "uuid == %@", argumentArray: [uuid]),
        ]
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filter)
        request.predicate = predicate
        return request
    }
    
    func update(with remindStaus: PlannedRemindStatus) {
        self.status = Int16(remindStaus.rawValue)
    }
    
    static func fetchRemindersAfter(controlDate: Date, page: Int, perPage: Int) -> NSFetchRequest<PlannedRemindEntity> {
        let fetchRequest: NSFetchRequest<PlannedRemindEntity> = PlannedRemindEntity.fetchRequest()
        fetchRequest.fetchLimit = perPage
        fetchRequest.fetchOffset = page * perPage
        fetchRequest.predicate = NSPredicate(format: "date > %@", controlDate as CVarArg)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        return fetchRequest
    }
    
    static func fetchRemindersBefore(controlDate: Date, page: Int, perPage: Int) -> NSFetchRequest<PlannedRemindEntity> {
        let fetchRequest: NSFetchRequest<PlannedRemindEntity> = PlannedRemindEntity.fetchRequest()
        fetchRequest.fetchLimit = perPage
        fetchRequest.fetchOffset = page * perPage
        fetchRequest.predicate = NSPredicate(format: "date < %@", controlDate as CVarArg)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        return fetchRequest
    }

}
