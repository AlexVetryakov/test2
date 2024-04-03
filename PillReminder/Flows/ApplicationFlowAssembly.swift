//
//  ApplicationFlowAssembly.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.11.2023.
//

import Swinject
import SwinjectAutoregistration

final class ApplicationFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(DataBaseClient.self) { _ in
            DataBaseClient(userUuidProducer: { "" } )
        }.inObjectScope(.container)
        
        container.register(ReminderService.self) { resolver in
            ReminderService(dataBaseClient: resolver.autoresolve())
        }.inObjectScope(.container)
    }
}
