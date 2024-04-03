//
//  UserEntity+CoreData.swift
//  PillReminder
//
//  Created by Александр Ветряков on 19.01.2024.
//

import UIKit
import CoreData

extension UserEntity {
    
    static func createFetchRequest() -> NSFetchRequest<UserEntity> {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
//        let filter = [
//            NSPredicate(format: "uuid == %@", argumentArray: [uuid]),
//            NSPredicate(format: "userUuid == %@", argumentArray: [userUuid])
//        ]
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: filter)
//        request.predicate = predicate
        return request
    }
}
