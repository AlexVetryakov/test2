//
//  DataBaseClient.swift
//  PillReminder
//
//  Created by Александр Ветряков on 19.01.2024.
//

import UIKit
import CoreData

final class DataBaseClient {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            container.viewContext.automaticallyMergesChangesFromParent = true
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private var containerName: String
    private let userUuidProducer: () -> String?
    
    init(userUuidProducer: @escaping () -> String?) {
        self.containerName = "PillReminder"
        self.userUuidProducer = userUuidProducer
    }
    
    private func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Database save error: \(error.localizedDescription)")
        }
    }
    
    func fetch<T>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func delete(request: NSFetchRequest<NSFetchRequestResult>) {
        guard let userUuid = userUuidProducer() else { return }
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("data base delete error")
        }
    }
}

// MARK: - RemindEntity

extension DataBaseClient {
    
    func createAndSave(from remind: Remind) -> RemindEntity? {
        guard let userUuid = userUuidProducer() else { return nil }
        
        let remindEntity = RemindEntity(context: context)
        remindEntity.uuid = remind.uuid
        remindEntity.name = remind.name
        remindEntity.userUuid = remind.userUuid
        remindEntity.daysCount = Int16(remind.daysCount)
        remindEntity.dose = remind.dose
        remindEntity.endDate = remind.endDate
        remindEntity.startDate = remind.startDate
        remindEntity.form = Int16(remind.form.rawValue)
        remindEntity.imageUrl = remind.imageUrl
        remindEntity.timeSlots = remind.binaryTimeSlots()
        save()
        return remindEntity
    }
}

// MARK: - PlannedRemindEntity

extension DataBaseClient {
    
    func createAndSave(from plannedRemind: PlannedRemind, remind: RemindEntity) {
        guard let userUuid = userUuidProducer() else { return }
        
        let remindEntity = PlannedRemindEntity(context: context)
        remindEntity.uuid = plannedRemind.uuid
        remindEntity.userUuid = plannedRemind.userUuid
        remindEntity.date = plannedRemind.date
        remindEntity.status = Int16(plannedRemind.status.rawValue)
        remindEntity.remind = remind
        save()
    }
    
    func update(status: PlannedRemindStatus, for uuid: String) {
        guard let userUuid = userUuidProducer() else { return }
        
        let request = PlannedRemindEntity.createFetchRequest(for: uuid)
        do {
            if let plannedRemind = try context.fetch(request).first {
                plannedRemind.update(with: status)
                save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
